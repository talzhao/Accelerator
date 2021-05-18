//
// DnnWeaver2 controller
//
// Hardik Sharma
// (hsharma@gatech.edu)

`timescale 1ns/1ps
module controller #(
    parameter integer  NUM_TAGS                     = 2,
    parameter integer  TAG_W                        = $clog2(NUM_TAGS),
    parameter integer  ADDR_WIDTH                   = 32,
    parameter integer  IBUF_ADDR_WIDTH              = ADDR_WIDTH,
    parameter integer  WBUF_ADDR_WIDTH              = ADDR_WIDTH,
    parameter integer  OBUF_ADDR_WIDTH              = ADDR_WIDTH,
    parameter integer  BBUF_ADDR_WIDTH              = ADDR_WIDTH,
  // Instructions
    parameter integer  INST_DATA_WIDTH              = 32,
    parameter integer  INST_ADDR_WIDTH              = 32,
    parameter integer  INST_WSTRB_WIDTH             = INST_DATA_WIDTH/8,
    parameter integer  INST_BURST_WIDTH             = 8,
  // Decoder
    parameter integer  BUF_TYPE_W                   = 2,
    parameter integer  LOOP_ITER_W                  = 16,
    parameter integer  ADDR_STRIDE_W                = 32,
    parameter integer  MEM_REQ_W                    = 16,
    parameter integer  LOOP_ID_W                    = 5,
    parameter integer  OP_SPEC_W                    = 7,
    parameter integer  AXI_ID_WIDTH                 = 1,
  // AXI-Lite
    parameter integer  CTRL_ADDR_WIDTH              = 32,
    parameter integer  CTRL_DATA_WIDTH              = 32,
    parameter integer  CTRL_WSTRB_WIDTH             = CTRL_DATA_WIDTH/8,
  // AXI
    parameter integer  AXI_BURST_WIDTH              = 8,
  // Instruction Mem
    parameter integer  IMEM_ADDR_WIDTH              = 12
) (
    input  wire                                        start,
    input  wire                                         clk,
    input  wire                                         reset,
    output  wire  [ INST_ADDR_WIDTH      -1 : 0 ]        ddr_data_awaddr,
    output wire  [ INST_BURST_WIDTH     -1 : 0 ]        ddr_data_awlen,
    output  wire  [ 3                    -1 : 0 ]        ddr_data_awsize,
    output  wire  [ 2                    -1 : 0 ]        ddr_data_awburst,
    output  wire                                         ddr_data_awvalid,
    input wire                                         ddr_data_awready,
  // Slave Interface Write Data
    output  wire  [ 256      -1 : 0 ]        ddr_data_wdata,
    output  wire  [ 256/8     -1 : 0 ]        ddr_data_wstrb,
    output  wire                                         ddr_data_wlast,
    output  wire                                         ddr_data_wvalid,
    input wire                                         ddr_data_wready,
  // Slave Interface Write Response
    input wire  [ 2                    -1 : 0 ]        ddr_data_bresp,
    input wire                                         ddr_data_bvalid,
    output  wire                                         ddr_data_bready,
  // Slave Interface Read Address
    output  wire  [ INST_ADDR_WIDTH      -1 : 0 ]        ddr_data_araddr,
    output  wire  [ INST_BURST_WIDTH     -1 : 0 ]        ddr_data_arlen,
    output  wire  [ 3                    -1 : 0 ]        ddr_data_arsize,
    output  wire  [ 2                    -1 : 0 ]        ddr_data_arburst,
    output  wire                                         ddr_data_arvalid,
    input wire                                         ddr_data_arready,
    output wire  [ AXI_ID_WIDTH         -1 : 0 ]        ddr_data_arid,
  // Slave Interface Read Data
    input wire  [ 256      -1 : 0 ]        ddr_data_rdata,
    input wire  [ 2                    -1 : 0 ]        ddr_data_rresp,
    input  wire  [ AXI_ID_WIDTH         -1 : 0 ]        ddr_data_rid,
    input wire                                         ddr_data_rlast,
    input wire                                         ddr_data_rvalid,
    output  wire                                         ddr_data_rready,

  // controller <-> compute handshakes
    output wire                                         tag_flush,
    output wire                                         tag_req,
    output wire                                         ibuf_tag_reuse,
    output wire                                         obuf_tag_reuse,
    output wire                                         wbuf_tag_reuse,
    output wire                                         bias_tag_reuse,
    input  wire                                         tag_ready,
    input  wire                                         ibuf_tag_done,
    input  wire                                         wbuf_tag_done,
    input  wire                                         obuf_tag_done,
    input  wire                                         bias_tag_done,

    input  wire                                         compute_done,
    input  wire                                         pu_compute_done,
    input  wire                                         pu_write_done,
    input  wire                                         pu_compute_start,
    input  wire  [ 3                    -1 : 0 ]        pu_ctrl_state,
    input  wire  [ 4                    -1 : 0 ]        stmem_state,
    input  wire  [ TAG_W                -1 : 0 ]        stmem_tag,
    input  wire                                         stmem_ddr_pe_sw,
    input  wire                                         ld_obuf_req,
    input  wire                                         ld_obuf_ready,

  // Load/Store addresses
    // Bias load address
    output wire  [ BBUF_ADDR_WIDTH      -1 : 0 ]        bias_ld_addr,
    output wire                                         bias_ld_addr_v,
    // IBUF load address
    output wire  [ IBUF_ADDR_WIDTH      -1 : 0 ]        ibuf_ld_addr,
    output wire                                         ibuf_ld_addr_v,
    // WBUF load address
    output wire  [ WBUF_ADDR_WIDTH      -1 : 0 ]        wbuf_ld_addr,
    output wire                                         wbuf_ld_addr_v,
    // OBUF load/store address
    output wire  [ OBUF_ADDR_WIDTH      -1 : 0 ]        obuf_ld_addr,
    output wire                                         obuf_ld_addr_v,
    output wire  [ OBUF_ADDR_WIDTH      -1 : 0 ]        obuf_st_addr,
    output wire                                         obuf_st_addr_v,

  // Load bias or obuf
    output wire                                         tag_bias_prev_sw,
    output wire                                         tag_ddr_pe_sw,


    
    input  wire                                         ibuf_compute_ready,
    input  wire                                         wbuf_compute_ready,
    input  wire                                         obuf_compute_ready,
    input  wire                                         bias_compute_ready,

  // Programming interface
    // Loop iterations
    output wire  [ LOOP_ITER_W          -1 : 0 ]        cfg_loop_iter,
    output wire  [ LOOP_ID_W            -1 : 0 ]        cfg_loop_iter_loop_id,
    output wire                                         cfg_loop_iter_v,
    // Loop stride
    output wire  [ ADDR_STRIDE_W        -1 : 0 ]        cfg_loop_stride,
    output wire                                         cfg_loop_stride_v,
    output wire  [ BUF_TYPE_W           -1 : 0 ]        cfg_loop_stride_id,
    output wire  [ 2                    -1 : 0 ]        cfg_loop_stride_type,
    output wire  [ LOOP_ID_W            -1 : 0 ]        cfg_loop_stride_loop_id,
    // Memory request
    output wire  [ MEM_REQ_W            -1 : 0 ]        cfg_mem_req_size,
    output wire                                         cfg_mem_req_v,
    output wire  [ 2                    -1 : 0 ]        cfg_mem_req_type,
    output wire  [ BUF_TYPE_W           -1 : 0 ]        cfg_mem_req_id,
    output wire  [ LOOP_ID_W            -1 : 0 ]        cfg_mem_req_loop_id,
    // Buffer request
    output wire  [ MEM_REQ_W            -1 : 0 ]        cfg_buf_req_size,
    output wire                                         cfg_buf_req_v,
    output wire                                         cfg_buf_req_type,
    output wire  [ BUF_TYPE_W           -1 : 0 ]        cfg_buf_req_loop_id,

    output wire                                         cfg_pu_inst_v,
    output wire  [ INST_DATA_WIDTH      -1 : 0 ]        cfg_pu_inst,
    output wire                                         pu_block_start,
 //   input wire [ INST_DATA_WIDTH      -1 : 0 ]        inst_read_data,
    output wire [ OP_SPEC_W            -1 : 0 ]        cfg_systolic_precision,
 output   wire                                        dnnweaver2_done,
output wire decoder_start,
output fc,
output fc1
  );

//=============================================================
// Localparam
//=============================================================
  // DnnWeaver2 controller state
    localparam integer  IDLE                         = 0;
    localparam integer  DECODE                       = 1;
    localparam integer  BASE_LOOP                    = 2;
    localparam integer  MEM_WAIT                     = 3;
    localparam integer  PU_WR_WAIT                   = 4;
    localparam integer  BLOCK_DONE                   = 5;
    localparam integer  DONE                         = 6;

    localparam integer  TM_STATE_WIDTH               = 2;
    localparam integer  TM_IDLE                      = 0;
    localparam integer  TM_REQUEST                   = 1;
    localparam integer  TM_CHECK                     = 2;
    localparam integer  TM_FLUSH                     = 3;
//=============================================================

//=============================================================
// Wires/Regs
//=============================================================
    wire                                        last_block;
wire [ INST_DATA_WIDTH      -1 : 0 ]        inst_read_data;
  // --------Debug--------
 
  // --------Debug--------

  // DnnWeaver2 states
    reg  [ 3                    -1 : 0 ]        dnnweaver2_state_d;
    reg  [ 3                    -1 : 0 ]        dnnweaver2_state_q;
    wire [ 3                    -1 : 0 ]        dnnweaver2_state;

  // Base addresses
    wire [ IBUF_ADDR_WIDTH      -1 : 0 ]        ibuf_base_addr;
    wire [ IBUF_ADDR_WIDTH      -1 : 0 ]        wbuf_base_addr;
    wire [ IBUF_ADDR_WIDTH      -1 : 0 ]        obuf_base_addr;
    wire [ IBUF_ADDR_WIDTH      -1 : 0 ]        bias_base_addr;

  // Handshake signals for main loop controller
    wire                                        base_loop_ctrl_start;
    wire                                        base_loop_ctrl_done;

    wire                                        block_done;
    //wire                                        dnnweaver2_done;

  // Handshake signals for decoder
//    wire                                        decoder_start;
    wire                                        decoder_done;

  // Instruction memory Read Port - Decoder
    wire                                        inst_read_req;
    wire [ IMEM_ADDR_WIDTH      -1 : 0 ]        inst_read_addr;


  // Start address for fetching/decoding instruction block
    wire [ IMEM_ADDR_WIDTH      -1 : 0 ]        num_blocks;

  // resetn for axi slave
    wire                                        resetn;



  // Accelerator start logic
    wire                                        start_bit_d;
    reg                                         start_bit_q;

  // TM State
    reg  [ TM_STATE_WIDTH       -1 : 0 ]        tm_state_d;
    reg  [ TM_STATE_WIDTH       -1 : 0 ]        tm_state_q;

    reg                                         tm_ibuf_tag_reuse_d;
    reg                                         tm_ibuf_tag_reuse_q;
    reg                                         tm_obuf_tag_reuse_d;
    reg                                         tm_obuf_tag_reuse_q;
    reg                                         tm_wbuf_tag_reuse_d;
    reg                                         tm_wbuf_tag_reuse_q;
    reg                                         tm_bias_tag_reuse_d;
    reg                                         tm_bias_tag_reuse_q;

    reg  [ ADDR_WIDTH           -1 : 0 ]        tm_ibuf_tag_addr_d;
    reg  [ ADDR_WIDTH           -1 : 0 ]        tm_ibuf_tag_addr_q;
    reg  [ ADDR_WIDTH           -1 : 0 ]        tm_obuf_tag_addr_d;
    reg  [ ADDR_WIDTH           -1 : 0 ]        tm_obuf_tag_addr_q;
    reg  [ ADDR_WIDTH           -1 : 0 ]        tm_wbuf_tag_addr_d;
    reg  [ ADDR_WIDTH           -1 : 0 ]        tm_wbuf_tag_addr_q;
    reg  [ ADDR_WIDTH           -1 : 0 ]        tm_bias_tag_addr_d;
    reg  [ ADDR_WIDTH           -1 : 0 ]        tm_bias_tag_addr_q;

    wire                                        base_ctrl_tag_req;
    wire                                        base_ctrl_tag_ready;

    assign tag_req = tm_state_q == TM_REQUEST;

  always @(posedge clk)
  begin
    if(reset)
      tm_state_q <= TM_IDLE;
    else
      tm_state_q <= tm_state_d;
  end

  always @(posedge clk)
  begin
    if(reset) begin
      tm_ibuf_tag_reuse_q <= 1'b0;
      tm_obuf_tag_reuse_q <= 1'b0;
      tm_wbuf_tag_reuse_q <= 1'b0;
      tm_bias_tag_reuse_q <= 1'b0;
      tm_ibuf_tag_addr_q  <= 0;
      tm_obuf_tag_addr_q  <= 0;
      tm_wbuf_tag_addr_q  <= 0;
      tm_bias_tag_addr_q  <= 0;
    end else begin
      tm_ibuf_tag_reuse_q <= tm_ibuf_tag_reuse_d;
      tm_obuf_tag_reuse_q <= tm_obuf_tag_reuse_d;
      tm_wbuf_tag_reuse_q <= tm_wbuf_tag_reuse_d;
      tm_bias_tag_reuse_q <= tm_bias_tag_reuse_d;
      tm_ibuf_tag_addr_q  <= tm_ibuf_tag_addr_d;
      tm_obuf_tag_addr_q  <= tm_obuf_tag_addr_d;
      tm_wbuf_tag_addr_q  <= tm_wbuf_tag_addr_d;
      tm_bias_tag_addr_q  <= tm_bias_tag_addr_d;
    end
  end

  always @(*)
  begin
  
    tm_state_d = tm_state_q;
    
    tm_ibuf_tag_reuse_d = 1'b0;
    tm_obuf_tag_reuse_d = 1'b0;
    tm_wbuf_tag_reuse_d = 1'b0;
    tm_bias_tag_reuse_d = 1'b0;
    
    tm_ibuf_tag_addr_d = tm_ibuf_tag_addr_q;
    tm_obuf_tag_addr_d = tm_obuf_tag_addr_q;
    tm_wbuf_tag_addr_d = tm_wbuf_tag_addr_q;
    tm_bias_tag_addr_d = tm_bias_tag_addr_q;
    
    case(tm_state_q)
      TM_IDLE: begin
        if (base_ctrl_tag_req && tag_ready)
          tm_state_d = TM_REQUEST;
      end
      TM_REQUEST: begin
        if (tag_ready) begin
          tm_state_d = TM_CHECK;
          tm_ibuf_tag_addr_d = ibuf_ld_addr;
          tm_obuf_tag_addr_d = obuf_ld_addr;
          tm_wbuf_tag_addr_d = wbuf_ld_addr;
          tm_bias_tag_addr_d = bias_ld_addr;
        end
      end
      TM_CHECK: begin
        if (base_ctrl_tag_req && tag_ready) begin
          tm_state_d = TM_REQUEST;
          tm_ibuf_tag_reuse_d = tm_ibuf_tag_addr_q == ibuf_ld_addr;
          tm_obuf_tag_reuse_d = tm_obuf_tag_addr_q == obuf_ld_addr;
          tm_wbuf_tag_reuse_d = tm_wbuf_tag_addr_q == wbuf_ld_addr;
          tm_bias_tag_reuse_d = tm_bias_tag_addr_q == bias_ld_addr;
        end
        else if (dnnweaver2_state_q == MEM_WAIT)
        begin
          tm_state_d = TM_FLUSH;
        end
      end
      TM_FLUSH: begin
        tm_state_d = TM_IDLE;
      end
    endcase
  end

  assign tag_flush = tm_state_q == TM_FLUSH;

    assign ibuf_tag_reuse = tm_ibuf_tag_reuse_q;
    assign obuf_tag_reuse = tm_obuf_tag_reuse_q;
    assign wbuf_tag_reuse = tm_wbuf_tag_reuse_q;
    assign bias_tag_reuse = tm_bias_tag_reuse_q;

    assign base_ctrl_tag_ready = tag_ready && tm_state_q == TM_REQUEST;
//=============================================================

//=============================================================
// Accelerator Start logic
//=============================================================

//=============================================================

//=============================================================
// FSM
//=============================================================
  always @(posedge clk)
  begin
    if (reset) begin
      dnnweaver2_state_q <= IDLE;
    end
    else begin
      dnnweaver2_state_q <= dnnweaver2_state_d;
    end
  end

  always @(*)
  begin
    dnnweaver2_state_d = dnnweaver2_state_q;
    case(dnnweaver2_state_q)
      IDLE: begin
        if (decoder_start) begin
          dnnweaver2_state_d = DECODE;
        end
      end
      DECODE: begin
        if (base_loop_ctrl_start)
          dnnweaver2_state_d = BASE_LOOP;
      end
      BASE_LOOP: begin
        if (base_loop_ctrl_done)
          dnnweaver2_state_d = MEM_WAIT;
      end
      MEM_WAIT: begin
        if (ibuf_tag_done && wbuf_tag_done && obuf_tag_done && bias_tag_done)
          dnnweaver2_state_d = PU_WR_WAIT;
      end
      PU_WR_WAIT: begin
        if (pu_write_done) begin
          dnnweaver2_state_d = BLOCK_DONE;
        end
      end
      BLOCK_DONE: begin
        if (~last_block)
          dnnweaver2_state_d = DECODE;
        else
          dnnweaver2_state_d = DONE;
      end
      DONE: begin
        dnnweaver2_state_d = IDLE;
      end
    endcase
  end
    assign block_done = dnnweaver2_state == BLOCK_DONE;
    assign dnnweaver2_done = dnnweaver2_state == DONE;
//=============================================================

//=============================================================
// Debug
//=============================================================
    reg  [ CTRL_DATA_WIDTH      -1 : 0 ]        tag_req_count;
    reg  [ CTRL_DATA_WIDTH      -1 : 0 ]        compute_done_count;
    reg  [ CTRL_DATA_WIDTH      -1 : 0 ]        pu_compute_done_count;
    reg  [ CTRL_DATA_WIDTH      -1 : 0 ]        pu_compute_start_count;
    always @(posedge clk)
    begin
      if (reset)
        tag_req_count <= 0;
      else if (tm_state_q == TM_REQUEST)
        tag_req_count <= tag_req_count + 1'b1;
    end

    always @(posedge clk)
    begin
      if (reset)
        compute_done_count <= 0;
      else if (compute_done)
        compute_done_count <= compute_done_count + 1'b1;
    end

    always @(posedge clk)
    begin
      if (reset)
        pu_compute_done_count <= 0;
      else if (pu_compute_done)
        pu_compute_done_count <= pu_compute_done_count + 1'b1;
    end

    always @(posedge clk)
    begin
      if (reset)
        pu_compute_start_count <= 0;
      else if (pu_compute_start)
        pu_compute_start_count <= pu_compute_start_count + 1'b1;
    end
//=============================================================

//=============================================================
// Assigns
//=============================================================
    assign dnnweaver2_state = dnnweaver2_state_q;

    assign resetn = ~reset;




 
    reg  [ CTRL_DATA_WIDTH      -1 : 0 ]        ld_obuf_read_counter;

    always @(posedge clk)
    begin
      if (reset)
        ld_obuf_read_counter <= 0;
      else if (ld_obuf_req)
        ld_obuf_read_counter <= ld_obuf_read_counter + 1'b1;
    end
    assign slv_reg31_in = ld_obuf_read_counter;

//=============================================================

//=============================================================

//=============================================================
// Instruction Memory
//=============================================================
/*  instruction_memory #(
    .DATA_WIDTH                     ( INST_DATA_WIDTH                ),
    .ADDR_WIDTH                     ( IMEM_ADDR_WIDTH                )
  ) imem (
    .clk                            ( clk                            ),
    .reset                          ( reset                          ),
    .pci_cl_data_awaddr             ( pci_cl_data_awaddr             ), //input
    .pci_cl_data_awlen              ( pci_cl_data_awlen              ), //input
    .pci_cl_data_awsize             ( pci_cl_data_awsize             ), //input
    .pci_cl_data_awburst            ( pci_cl_data_awburst            ), //input
    .pci_cl_data_awvalid            ( pci_cl_data_awvalid            ), //input
    .pci_cl_data_awready            ( pci_cl_data_awready            ), //output
    .pci_cl_data_wdata              ( pci_cl_data_wdata              ), //input
    .pci_cl_data_wstrb              ( pci_cl_data_wstrb              ), //input
    .pci_cl_data_wlast              ( pci_cl_data_wlast              ), //input
    .pci_cl_data_wvalid             ( pci_cl_data_wvalid             ), //input
    .pci_cl_data_wready             ( pci_cl_data_wready             ), //output
    .pci_cl_data_bresp              ( pci_cl_data_bresp              ), //output
    .pci_cl_data_bvalid             ( pci_cl_data_bvalid             ), //output
    .pci_cl_data_bready             ( pci_cl_data_bready             ), //input
    .pci_cl_data_araddr             ( pci_cl_data_araddr             ), //input
    .pci_cl_data_arlen              ( pci_cl_data_arlen              ), //input
    .pci_cl_data_arsize             ( pci_cl_data_arsize             ), //input
    .pci_cl_data_arburst            ( pci_cl_data_arburst            ), //input
    .pci_cl_data_arvalid            ( pci_cl_data_arvalid            ), //input
    .pci_cl_data_arready            ( pci_cl_data_arready            ), //output
    .pci_cl_data_rdata              ( pci_cl_data_rdata              ), //output
    .pci_cl_data_rresp              ( pci_cl_data_rresp              ), //output
    .pci_cl_data_rlast              ( pci_cl_data_rlast              ), //output
    .pci_cl_data_rvalid             ( pci_cl_data_rvalid             ), //output
    .pci_cl_data_rready             ( pci_cl_data_rready             ), //input
    .s_read_addr_b                  ( inst_read_addr                 ), //input
    .s_read_req_b                   ( inst_read_req                  ), //input
    .s_read_data_b                  ( inst_read_data                 )  //output
  );*/
//=============================================================

instruction_memory #(
    .DATA_WIDTH                     ( INST_DATA_WIDTH                ),
    .ADDR_WIDTH                     ( IMEM_ADDR_WIDTH                )
)inst_mem
(
.clk(clk),
.reset(reset),
    .ddr_data_awaddr             ( ddr_data_awaddr             ), //input
    .ddr_data_awlen              ( ddr_data_awlen              ), //input
    .ddr_data_awsize             ( ddr_data_awsize             ), //input
    .ddr_data_awburst            ( ddr_data_awburst            ), //input
    .ddr_data_awvalid            ( ddr_data_awvalid            ), //input
    .ddr_data_awready            ( ddr_data_awready            ), //output
    .ddr_data_wdata              ( ddr_data_wdata              ), //input
    .ddr_data_wstrb              ( ddr_data_wstrb              ), //input
    .ddr_data_wlast              ( ddr_data_wlast              ), //input
    .ddr_data_wvalid             ( ddr_data_wvalid             ), //input
    .ddr_data_wready             ( ddr_data_wready             ), //output
    .ddr_data_bresp              ( ddr_data_bresp              ), //output
    .ddr_data_bvalid             ( ddr_data_bvalid             ), //output
    .ddr_data_bready             ( ddr_data_bready             ), //input
    .ddr_data_araddr             ( ddr_data_araddr             ), //input
    .ddr_data_arlen              ( ddr_data_arlen              ), //input
    .ddr_data_arsize             ( ddr_data_arsize             ), //input
    .ddr_data_arburst            ( ddr_data_arburst            ), //input
    .ddr_data_arvalid            ( ddr_data_arvalid            ), //input
    .ddr_data_arready            ( ddr_data_arready            ), //output
    .ddr_data_arid(ddr_data_arid),
    .ddr_data_rdata              ( ddr_data_rdata              ), //output
    .ddr_data_rresp              ( ddr_data_rresp              ), //output
    .ddr_data_rlast              ( ddr_data_rlast              ), //output
    .ddr_data_rvalid             ( ddr_data_rvalid             ), //output
    .ddr_data_rready             ( ddr_data_rready             ), //input
    .ddr_data_rid( ddr_data_rid),
  // Decoder <- imem
.s_read_req_b(inst_read_req),
.s_read_addr_b(inst_read_addr),
.s_read_data_b(inst_read_data),
.start(start),
.decoder_start(decoder_start)
);
//=============================================================

//=============================================================
// Decoder
//=============================================================
  decoder #(
    .IMEM_ADDR_W                    ( IMEM_ADDR_WIDTH                )
  ) instruction_decoder (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .imem_read_data                 ( inst_read_data                 ), //input
    .imem_read_addr                 ( inst_read_addr                 ), //output
    .imem_read_req                  ( inst_read_req                  ), //output
    .start                          ( decoder_start                  ), //input
    .done                           ( decoder_done                   ), //output
    .loop_ctrl_start                ( base_loop_ctrl_start           ), //output
    .loop_ctrl_done                 ( base_loop_ctrl_done            ), //input
    .block_done                     ( block_done                     ), //input
    .last_block                     ( last_block                     ), //output
    .cfg_loop_iter_v                ( cfg_loop_iter_v                ), //output
    .cfg_loop_iter                  ( cfg_loop_iter                  ), //output
    .cfg_loop_iter_loop_id          ( cfg_loop_iter_loop_id          ), //output
    .cfg_loop_stride_v              ( cfg_loop_stride_v              ), //output
    .cfg_loop_stride                ( cfg_loop_stride                ), //output
    .cfg_loop_stride_loop_id        ( cfg_loop_stride_loop_id        ), //output
    .cfg_loop_stride_type           ( cfg_loop_stride_type           ), //output
    .cfg_loop_stride_id             ( cfg_loop_stride_id             ), //output
    .ibuf_base_addr                 ( ibuf_base_addr                 ), //output
    .wbuf_base_addr                 ( wbuf_base_addr                 ), //output
    .obuf_base_addr                 ( obuf_base_addr                 ), //output
    .bias_base_addr                 ( bias_base_addr                 ), //output
    .cfg_mem_req_v                  ( cfg_mem_req_v                  ), //output
    .cfg_mem_req_size               ( cfg_mem_req_size               ), //output
    .cfg_mem_req_type               ( cfg_mem_req_type               ), //output
    .cfg_mem_req_id                 ( cfg_mem_req_id                 ), //output
    .cfg_mem_req_loop_id            ( cfg_mem_req_loop_id            ), //output
    .cfg_buf_req_v                  ( cfg_buf_req_v                  ), //output
    .cfg_buf_req_size               ( cfg_buf_req_size               ), //output
    .cfg_buf_req_type               ( cfg_buf_req_type               ), //output
    .cfg_buf_req_loop_id            ( cfg_buf_req_loop_id            ), //output
    .cfg_pu_inst                    ( cfg_pu_inst                    ), //output
    .cfg_pu_inst_v                  ( cfg_pu_inst_v                  ), //output
    .pu_block_start                 ( pu_block_start                 ),  //output
    .cfg_systolic_precision(cfg_systolic_precision),
    //.noneed(noneed),
    .fc(fc),
    .fc1(fc1)
  );
//=============================================================

//=============================================================
// Base address generator
//    This module is in charge of the outer loops [16 - 31]
//=============================================================
  base_addr_gen #(
    .BASE_ID                        ( 1                              ),
    .MEM_REQ_W                      ( MEM_REQ_W                      ),
    .IBUF_ADDR_WIDTH                ( IBUF_ADDR_WIDTH                ),
    .WBUF_ADDR_WIDTH                ( WBUF_ADDR_WIDTH                ),
    .OBUF_ADDR_WIDTH                ( OBUF_ADDR_WIDTH                ),
    .BBUF_ADDR_WIDTH                ( BBUF_ADDR_WIDTH                ),
    .LOOP_ITER_W                    ( LOOP_ITER_W                    ),
    .ADDR_STRIDE_W                  ( ADDR_STRIDE_W                  ),
    .LOOP_ID_W                      ( LOOP_ID_W                      )
  ) base_ctrl (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input

    .start                          ( base_loop_ctrl_start           ), //input
    .done                           ( base_loop_ctrl_done            ), //output

    .tag_req                        ( base_ctrl_tag_req              ), //output
    .tag_ready                      ( base_ctrl_tag_ready            ), //output

    .cfg_loop_iter_v                ( cfg_loop_iter_v                ), //input
    .cfg_loop_iter                  ( cfg_loop_iter                  ), //input
    .cfg_loop_iter_loop_id          ( cfg_loop_iter_loop_id          ), //input

    .cfg_loop_stride_v              ( cfg_loop_stride_v              ), //input
    .cfg_loop_stride                ( cfg_loop_stride                ), //input
    .cfg_loop_stride_loop_id        ( cfg_loop_stride_loop_id        ), //input
    .cfg_loop_stride_type           ( cfg_loop_stride_type           ), //input
    .cfg_loop_stride_id             ( cfg_loop_stride_id             ), //input

    .obuf_base_addr                 ( obuf_base_addr                 ), //input
    .obuf_ld_addr                   ( obuf_ld_addr                   ), //output
    .obuf_ld_addr_v                 ( obuf_ld_addr_v                 ), //output
    .obuf_st_addr                   ( obuf_st_addr                   ), //output
    .obuf_st_addr_v                 ( obuf_st_addr_v                 ), //output
    .ibuf_base_addr                 ( ibuf_base_addr                 ), //input
    .ibuf_ld_addr                   ( ibuf_ld_addr                   ), //output
    .ibuf_ld_addr_v                 ( ibuf_ld_addr_v                 ), //output
    .wbuf_base_addr                 ( wbuf_base_addr                 ), //input
    .wbuf_ld_addr                   ( wbuf_ld_addr                   ), //output
    .wbuf_ld_addr_v                 ( wbuf_ld_addr_v                 ), //output
    .bias_base_addr                 ( bias_base_addr                 ), //input
    .bias_ld_addr                   ( bias_ld_addr                   ), //output
    .bias_ld_addr_v                 ( bias_ld_addr_v                 ), //output

    .bias_prev_sw                   ( tag_bias_prev_sw               ), //output
    .ddr_pe_sw                      ( tag_ddr_pe_sw                  )  //output
  );
//=============================================================

//=============================================================
// VCD
//=============================================================
  `ifdef COCOTB_TOPLEVEL_controller
  initial begin
    $dumpfile("controller.vcd");
    $dumpvars(0, controller);
  end
  `endif
//=============================================================

endmodule
