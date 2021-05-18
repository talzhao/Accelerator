//
// Instruction Memory
//
// Hardik Sharma
// (hsharma@gatech.edu)
`timescale 1ns/1ps
module instruction_memory
#(
    parameter integer  DATA_WIDTH                   = 32,
    parameter integer  SIZE_IN_BITS                 = 1<<16,
    parameter integer  ADDR_WIDTH                   = $clog2(SIZE_IN_BITS/DATA_WIDTH),
  // Instructions
    parameter integer  INST_DATA_WIDTH              = 32,
    parameter integer  INST_ADDR_WIDTH              = 32,
    parameter integer  INST_WSTRB_WIDTH             = INST_DATA_WIDTH/8,
    parameter integer  INST_BURST_WIDTH             = 8,
    parameter integer  AXI_ID_WIDTH                 = 1,
    parameter integer  AXI_ADDR_WIDTH               = 32,
    parameter integer  C_S00_AXI_DATA_WIDTH               = 256,
    parameter integer  AXI_DATA_WIDTH               = 256,
    parameter integer  AXI_BURST_WIDTH              = 8,
    parameter integer  WSTRB_W                      = AXI_DATA_WIDTH/8,
    parameter integer  MEM_REQ_W                    = 16
)
(
  // clk, reset
    input  wire                                         clk,
    input  wire                                         reset,

  // Decoder <- imem
    input  wire                                         s_read_req_b,
    input  wire  [ ADDR_WIDTH           -1 : 0 ]        s_read_addr_b,
    output reg  [ DATA_WIDTH           -1 : 0 ]        s_read_data_b,

  // PCIe -> CL_wrapper AXI4 interface
  // Slave Interface Write Address
    output  wire  [ AXI_ADDR_WIDTH      -1 : 0 ]        ddr_data_awaddr,
    output  wire  [ AXI_BURST_WIDTH     -1 : 0 ]        ddr_data_awlen,
    output  wire  [ 3                    -1 : 0 ]        ddr_data_awsize,
    output  wire  [ 2                    -1 : 0 ]        ddr_data_awburst,
    output  wire                                         ddr_data_awvalid,
    input wire                                         ddr_data_awready,
  // Slave Interface Write Data
    output  wire  [ C_S00_AXI_DATA_WIDTH      -1 : 0 ]        ddr_data_wdata,
    output  wire  [ WSTRB_W     -1 : 0 ]        ddr_data_wstrb,
    output  wire                                         ddr_data_wlast,
    output  wire                                         ddr_data_wvalid,
    input wire                                         ddr_data_wready,
  // Slave Interface Write Response
    input wire  [ 2                    -1 : 0 ]        ddr_data_bresp,
    input wire                                         ddr_data_bvalid,
    output  wire                                         ddr_data_bready,
  // Slave Interface Read Address
    output  wire  [ AXI_ADDR_WIDTH      -1 : 0 ]        ddr_data_araddr,
    output  wire  [ AXI_BURST_WIDTH     -1 : 0 ]        ddr_data_arlen,
    output  wire  [ 3                    -1 : 0 ]        ddr_data_arsize,
    output  wire  [ 2                    -1 : 0 ]        ddr_data_arburst,
    output  wire                                         ddr_data_arvalid,
    input wire                                         ddr_data_arready,
    output wire  [ AXI_ID_WIDTH         -1 : 0 ]        ddr_data_arid,
  // Slave Interface Read Data
    input wire  [ C_S00_AXI_DATA_WIDTH      -1 : 0 ]        ddr_data_rdata,
    input wire  [ 2                    -1 : 0 ]        ddr_data_rresp,
    input  wire  [ AXI_ID_WIDTH         -1 : 0 ]        ddr_data_rid,
    input wire                                         ddr_data_rlast,
    input wire                                         ddr_data_rvalid,
    output  wire                                         ddr_data_rready,
    input wire start,
    output reg decoder_start
    //input decoder_done
);

//=============================================================
// Localparams
//=============================================================
  // Width of state
    localparam integer  STATE_W                      = 3;
  // States
    localparam integer  IMEM_IDLE                    = 0;
    localparam integer  IMEM_WR_ADDR                 = 1;
    localparam integer  IMEM_WR_DATA                 = 2;
    localparam integer  IMEM_RD_ADDR                 = 3;
    localparam integer  IMEM_RD_REQ                  = 4;
    localparam integer  IMEM_RD_DATA                 = 5;
  // RD count
    localparam          R_COUNT_W                    = INST_BURST_WIDTH + 1;
  // Bytes per word
    localparam BYTES_PER_WORD = DATA_WIDTH / 8;
    localparam BYTE_ADDR_W = $clog2(BYTES_PER_WORD);
//=============================================================

//=============================================================
// Wires/Regs
//=============================================================
  // Host <-> imem
    wire                                        s_req_a;
    wire                                        s_wr_en_a;
    wire [ DATA_WIDTH           -1 : 0 ]        s_read_data_a;
    wire [ ADDR_WIDTH           -1 : 0 ]        s_read_addr_a;
    wire [ DATA_WIDTH           -1 : 0 ]        s_write_data_a;
    reg [ ADDR_WIDTH           -1 : 0 ]        s_write_addr_a;
  // FSM for writes to instruction memory (imem)
    reg  [ STATE_W              -1 : 0 ]        imem_state_q;
    reg  [ STATE_W              -1 : 0 ]        imem_state_d;
  // writes address for instruction memory (imem)
    reg  [ INST_ADDR_WIDTH      -1 : 0 ]        w_addr_d;
    reg  [ INST_ADDR_WIDTH      -1 : 0 ]        w_addr_q;

  // read address for instruction memory (imem)
    reg  [ INST_ADDR_WIDTH      -1 : 0 ]        r_addr_d;
    reg  [ INST_ADDR_WIDTH      -1 : 0 ]        r_addr_q;
  // read counter


   // reg  [ DATA_WIDTH           -1 : 0 ]        _s_read_data_a;
    //reg  [ DATA_WIDTH           -1 : 0 ]        _s_read_data_b;
//=============================================================
//==============================================================================
// AXI4 Memory Mapped interface
//==============================================================================

    wire                                        axi_rd_req;
    wire [ AXI_ID_WIDTH         -1 : 0 ]        axi_rd_req_id;
    wire                                        axi_rd_done;
    wire [ MEM_REQ_W            -1 : 0 ]        axi_rd_req_size;
    wire                                        axi_rd_ready;
    wire [ AXI_ADDR_WIDTH       -1 : 0 ]        axi_rd_addr;

    wire                                        axi_wr_req;
    wire [ AXI_ID_WIDTH         -1 : 0 ]        axi_wr_req_id;
    wire                                        axi_wr_done;
    wire [ MEM_REQ_W            -1 : 0 ]        axi_wr_req_size;
    wire                                        axi_wr_ready;
    wire [ AXI_ADDR_WIDTH       -1 : 0 ]        axi_wr_addr;

    wire [ AXI_ID_WIDTH         -1 : 0 ]        mem_write_id;
    wire                                        mem_write_req;
    wire [ C_S00_AXI_DATA_WIDTH       -1 : 0 ]        mem_write_data;

    wire                                        mem_write_ready;
    wire [ C_S00_AXI_DATA_WIDTH       -1 : 0 ]        mem_read_data;

    wire                                        mem_read_req;
    wire                                        mem_read_ready;
    
    assign mem_write_ready = 1'b1;
    assign mem_read_ready = 1'b1;
    assign axi_rd_req_id = 0;
    assign mem_read_data = 0;
    wire [4-1:0]wrapperldstate;


  axi_master #(
    .TX_SIZE_WIDTH                  ( MEM_REQ_W                      ),
    .AXI_DATA_WIDTH                 ( AXI_DATA_WIDTH                 ),
    .AXI_ADDR_WIDTH                 ( AXI_ADDR_WIDTH                 ),
    .AXI_BURST_WIDTH                ( AXI_BURST_WIDTH                ),
    .AXISTATE                ( 3               ),
    .AXISTATEELSE                ( 8               )
  ) u_axi_mm_master (
    .clk                            ( clk                            ),
    .reset                          ( reset                          ),
    .m_axi_awaddr                   ( ddr_data_awaddr                     ),
    .m_axi_awlen                    ( ddr_data_awlen                      ),
    .m_axi_awsize                   ( ddr_data_awsize                     ),
    .m_axi_awburst                  ( ddr_data_awburst                    ),
    .m_axi_awvalid                  ( ddr_data_awvalid                    ),
    .m_axi_awready                  ( ddr_data_awready                    ),
    .m_axi_wdata                    ( ddr_data_wdata                      ),
    .m_axi_wstrb                    ( ddr_data_wstrb                      ),
    .m_axi_wlast                    ( ddr_data_wlast                      ),
    .m_axi_wvalid                   ( ddr_data_wvalid                     ),
    .m_axi_wready                   ( ddr_data_wready                     ),
    .m_axi_bresp                    ( ddr_data_bresp                      ),
    .m_axi_bvalid                   ( ddr_data_bvalid                     ),
    .m_axi_bready                   ( ddr_data_bready                     ),
    .m_axi_araddr                   ( ddr_data_araddr                     ),
    .m_axi_arid                     ( ddr_data_arid                      ),
    .m_axi_arlen                    ( ddr_data_arlen                      ),
    .m_axi_arsize                   ( ddr_data_arsize                     ),
    .m_axi_arburst                  ( ddr_data_arburst                    ),
    .m_axi_arvalid                  ( ddr_data_arvalid                    ),
    .m_axi_arready                  ( ddr_data_arready                    ),
    .m_axi_rdata                    ( ddr_data_rdata                      ),
    .m_axi_rid                      ( ddr_data_rid                        ),
    .m_axi_rresp                    ( ddr_data_rresp                      ),
    .m_axi_rlast                    ( ddr_data_rlast                      ),
    .m_axi_rvalid                   ( ddr_data_rvalid                     ),
    .m_axi_rready                   ( ddr_data_rready                     ),
    // Buffer
    .mem_write_req                  ( mem_write_req                  ),
    .mem_write_id                   ( mem_write_id                   ),
    .mem_write_data                 ( mem_write_data                 ),
    .mem_write_ready                ( 1'b1                ),
    .mem_read_data                  ( mem_read_data                  ),
    .mem_read_req                   ( mem_read_req                   ),
    .mem_read_ready                 ( mem_read_ready                 ),
    // AXI RD Req
    .rd_req                         ( axi_rd_req                     ),
    .rd_req_id                      ( axi_rd_req_id                  ),
    .rd_done                        ( axi_rd_done                    ),
    .rd_ready                       ( axi_rd_ready                   ),
    .rd_req_size                    ( axi_rd_req_size                ),
    .rd_addr                        ( axi_rd_addr                    ),
    // AXI WR Req
    .wr_req                         ( axi_wr_req                     ),
    .wr_req_id                      ( axi_wr_req_id                  ),
    .wr_ready                       ( axi_wr_ready                   ),
    .wr_req_size                    ( axi_wr_req_size                ),
    .wr_addr                        ( axi_wr_addr                    ),
    .wr_done                        ( axi_wr_done                    ),
    .wrapperstate(wrapperldstate)
  );

//=============================================================
// Dual port ram
//=============================================================
//  reg  [ DATA_WIDTH -1 : 0 ] mem [ 0 : 1<<ADDR_WIDTH ];

  reg[2:0] state_q;
  reg[2:0] state_d;
  reg inst_req;
    assign axi_rd_req = inst_req;
    assign axi_rd_req_size = 'd2080;
    assign axi_rd_addr = 32'hDF6BB0;

    assign axi_wr_req = 1'b0;
    assign axi_wr_req_id = 1'b0;
    assign axi_wr_req_size = 0;
    assign axi_wr_addr = 0;

  always @(posedge clk)
     if(reset)
     begin
      state_q<=0;
      end
     else
     state_q<=state_d;

   always @(*)
   begin
     state_d <= state_q;
     decoder_start<=0;
      inst_req<=0;
     case(state_q)
     3'b00:if(start)
         begin
         state_d <= 3'b11;
         inst_req <=1;
          
         end
     3'b11:begin
state_d<=3'b100 ;
 inst_req <=0;
end
     3'b100:state_d<=3'b101 ;
     3'b101:state_d<=3'b01 ;
     3'b01:if(axi_rd_done)
         begin
         inst_req <=0;
         //decoder_start <=1;
         state_d <= 3'b10;
         end
     3'b10:if (s_write_addr_a == 12'd2080)
begin
decoder_start<=1;
state_d<=3'b110;
end
     3'b110:
        decoder_start<=0;
     default:decoder_start<=0;
     endcase
  end
  // FSM for writes to instruction memory (imem)



  always @(posedge clk)
  begin: RAM_WRITE_PORT_A
    if (reset)
     s_write_addr_a<=0;
    else if (mem_write_req) begin
        //mem[s_write_addr_a] <= mem_write_data[INST_DATA_WIDTH-1:0];
        s_write_addr_a<=s_write_addr_a+1;
    end
  end
 /*
  always @(posedge clk)
  begin: RAM_WRITE_PORT_B
    if (s_read_req_b) begin
        s_read_data_b <= mem[s_read_addr_b];
    end
  end*/
wire [ADDR_WIDTH           -1 : 0 ]addr;
assign addr=s_read_req_b?s_read_addr_b:s_write_addr_a;
//=============================================================
 wire ceny;


  wire  weny;



  wire [1:0] soa;
  wire [1:0] sob;
  wire [DATA_WIDTH  -1 : 0]d;

  wire [DATA_WIDTH  -1 : 0]q;

  wire [11:0] ay;

 




sram_sp_hde_inst synch_sram_u1_2048(
.CENY(ceny), 
.WENY(weny), 
.AY(ay),
 .Q(s_read_data_b),
 .SO(),
 .CLK(clk),
 .CEN(~(s_read_req_b|mem_write_req)),
 .WEN(s_read_req_b),
 .A(addr),
 .D(mem_write_data[31:0]),
 .EMA(3'b010),
 .EMAW(2'b00),
 .TEN(1'b1),
 .TCEN(1'b1),
 .TWEN(1'b1),
 .TA(addr),
 .TD(),
 .RET1N(1'b1),
 .SI(2'b00),
 .SE(1'b0),
 .DFTRAMBYP(1'b0)

   );

//=============================================================
// VCD
//=============================================================
`ifdef COCOTB_TOPLEVEL_instruction_memory
  initial begin
    $dumpfile("instruction_memory.vcd");
    $dumpvars(0, instruction_memory);
  end
`endif
//=============================================================
endmodule
