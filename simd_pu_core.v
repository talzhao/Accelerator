`timescale 1ns / 1ps
module simd_pu_core #(
  // Instruction width for PU controller
    parameter integer  INST_WIDTH                   = 32,
  // Data width
    parameter integer  DATA_WIDTH                   = 16,
    parameter integer  ACC_DATA_WIDTH               = 32,
    parameter integer  SIMD_LANES                   = 1,
    parameter integer  SIMD_DATA_WIDTH              = SIMD_LANES * DATA_WIDTH,
    parameter integer  SIMD_INTERIM_WIDTH           = SIMD_LANES * ACC_DATA_WIDTH,
    parameter integer  OBUF_AXI_DATA_WIDTH          = 256,

    parameter integer  AXI_DATA_WIDTH               = 64,

    parameter integer  SRC_ADDR_WIDTH               = 4,
    parameter integer  RF_ADDR_WIDTH                = SRC_ADDR_WIDTH-1,

    parameter integer  OP_WIDTH                     = 3,
    parameter integer  FN_WIDTH                     = 3,
    parameter integer  IMM_WIDTH                    = 16,
    parameter integer  SOFTIMMI                      = $clog2(SIMD_LANES/2)
)
(
    input  wire                                         clk,
    input  wire                                         reset,

    input  wire                                         alu_fn_valid,
    input  wire  [ FN_WIDTH             -1 : 0 ]        alu_fn,
    input  wire  [ IMM_WIDTH            -1 : 0 ]        alu_imm,

    input  wire  [ SRC_ADDR_WIDTH       -1 : 0 ]        alu_in0_addr,
    input  wire                                         alu_in1_src,
    input  wire  [ SRC_ADDR_WIDTH       -1 : 0 ]        alu_in1_addr,
    input  wire  [ SRC_ADDR_WIDTH       -1 : 0 ]        alu_out_addr,

  // From controller
    input  wire                                         obuf_ld_stream_read_req,
    output wire                                         obuf_ld_stream_read_ready,
    input  wire                                         ddr_ld0_stream_read_req,
    output wire                                         ddr_ld0_stream_read_ready,
    input  wire                                         ddr_ld1_stream_read_req,
    output wire                                         ddr_ld1_stream_read_ready,
    input  wire                                         ddr_st_stream_write_req,
    output wire                                         ddr_st_stream_write_ready,

  // From DDR
    input  wire                                         ddr_st_stream_read_req,
    output wire  [ AXI_DATA_WIDTH       -1 : 0 ]        ddr_st_stream_read_data,
    output wire                                         ddr_st_stream_read_ready,

    input  wire                                         ddr_ld0_stream_write_req,
    input  wire  [ AXI_DATA_WIDTH       -1 : 0 ]        ddr_ld0_stream_write_data,
    output wire                                         ddr_ld0_stream_write_ready,

    input  wire                                         ddr_ld1_stream_write_req,
    input  wire  [ AXI_DATA_WIDTH       -1 : 0 ]        ddr_ld1_stream_write_data,
    output wire                                         ddr_ld1_stream_write_ready,

  // From OBUF
    input  wire                                         obuf_ld_stream_write_req,
    input  wire  [ OBUF_AXI_DATA_WIDTH  -1 : 0 ]        obuf_ld_stream_write_data,
    output wire                                         obuf_ld_stream_write_ready,

    output wire  [ INST_WIDTH           -1 : 0 ]        obuf_ld_stream_read_count,
    output wire  [ INST_WIDTH           -1 : 0 ]        obuf_ld_stream_write_count,
    output wire  [ INST_WIDTH           -1 : 0 ]        ddr_st_stream_read_count,
    output wire  [ INST_WIDTH           -1 : 0 ]        ddr_st_stream_write_count,
    output wire  [ INST_WIDTH           -1 : 0 ]        ld0_stream_counts,
    output wire  [ INST_WIDTH           -1 : 0 ]        ld1_stream_counts,
    input wire softmax1,
    input wire  [ 3                    -1 : 0 ]        pu_ctrl_state
);

//==============================================================================
// Localparams
//==============================================================================
//==============================================================================
   reg status;
//==============================================================================
// Wires & Regs
//==============================================================================
    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        alu_in0_data;
    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        alu_in1_data;

    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        obuf_ld_stream_read_data;

    wire [ SIMD_DATA_WIDTH      -1 : 0 ]        ddr_ld0_stream_read_data;
    wire                                        ld0_req_buf_write_ready;
    wire                                        ld0_req_buf_almost_full;
    wire                                        ld0_req_buf_almost_empty;

    wire [ SIMD_DATA_WIDTH      -1 : 0 ]        ddr_ld1_stream_read_data;
    wire                                        ld1_req_buf_write_ready;
    wire                                        ld1_req_buf_almost_full;
    wire                                        ld1_req_buf_almost_empty;

    wire                                        st_req_buf_almost_full;
    wire                                        st_req_buf_almost_empty;
    wire [ SIMD_DATA_WIDTH      -1 : 0 ]        ddr_st_stream_write_data;

    wire [ FN_WIDTH             -1 : 0 ]        alu_fn_stage2;
    wire [ FN_WIDTH             -1 : 0 ]        alu_fn_stage3;
    wire [ FN_WIDTH             -1 : 0 ] alu_fn_choose;
    wire                                        alu_fn_valid_stage2;
    wire                                        alu_fn_valid_stage3;
    wire alu_fn_valid_choose;
    wire [ IMM_WIDTH            -1 : 0 ]        alu_imm_stage2;
    wire [ IMM_WIDTH            -1 : 0 ]        alu_imm_stage3;
    wire [ IMM_WIDTH            -1 : 0 ]        alu_imm_choose;
    wire                                        alu_in1_src_stage2;
    wire                                        alu_in1_src_stage3;
    wire                                        alu_in1_src_choose;
    wire [ SRC_ADDR_WIDTH       -1 : 0 ]        alu_in0_addr_stage2;
    wire [ SRC_ADDR_WIDTH       -1 : 0 ]        alu_in1_addr_stage2;

    wire                                        ld_req_buf_almost_full;
    wire                                        ld_req_buf_almost_empty;

    wire                                        alu_in0_req;
    wire                                        alu_in1_req;
    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        alu_out;
    reg  [ SIMD_INTERIM_WIDTH   -1 : 0 ]        alu_out_fwd;
    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        alu_out_fwd1;

  // chaining consecutive ops
    wire                                        chain_rs0;
    wire                                        chain_rs1;
    wire                                        chain_rs0_stage2;
    wire                                        chain_rs0_stage3;
    wire                                        chain_rs1_stage2;

  // forwarding between ops
    wire                                        fwd_rs0;
    wire                                        fwd_rs1;
    wire                                        fwd_rs0_stage2;
    wire                                        fwd_rs1_stage2;

    wire [ SRC_ADDR_WIDTH       -1 : 0 ]        alu_out_addr_stage2;
    wire [ SRC_ADDR_WIDTH       -1 : 0 ]        alu_out_addr_stage3;

    reg softmax;
    //wire softmax1;
    //assign softmax1 = 1;
    reg [SOFTIMMI:0]softimm;
    genvar i;
//==============================================================================

//==============================================================================
// Chaining/Forwarding logic
//==============================================================================
    assign chain_rs0 = alu_fn_valid && alu_fn_valid_stage2 && (alu_in0_addr[2:0] == alu_out_addr_stage2[2:0]);
    assign chain_rs1 = alu_fn_valid && alu_fn_valid_stage2 && (alu_in1_addr[2:0] == alu_out_addr_stage2[2:0]);

    assign fwd_rs0 = (alu_fn_valid && alu_fn_valid_stage3 && (alu_in0_addr == alu_out_addr_stage3));
    assign fwd_rs1 = (alu_fn_valid && alu_fn_valid_stage3 && (alu_in1_addr == alu_out_addr_stage3));
//==============================================================================

//==============================================================================
// Registers
//==============================================================================
  register_sync_with_enable #(1) stage2_chain_rs0
  (clk, reset, 1'b1, chain_rs0, chain_rs0_stage2);
  register_sync_with_enable #(1) stage2_chain_rs00
  (clk, reset, 1'b1, chain_rs0_stage2, chain_rs0_stage3);

  register_sync_with_enable #(1) stage2_chain_rs1
  (clk, reset, 1'b1, chain_rs1, chain_rs1_stage2);

  register_sync_with_enable #(1) stage2_fwd_rs0
  (clk, reset, 1'b1, fwd_rs0, fwd_rs0_stage2);

  register_sync_with_enable #(1) stage2_fwd_rs1
  (clk, reset, 1'b1, fwd_rs1, fwd_rs1_stage2);

  register_sync_with_enable #(SRC_ADDR_WIDTH) stage2_alu_out_addr
  (clk, reset, 1'b1, alu_out_addr, alu_out_addr_stage2);
  register_sync_with_enable #(SRC_ADDR_WIDTH) stage3_alu_out_addr
  (clk, reset, 1'b1, alu_out_addr_stage2, alu_out_addr_stage3);
//==============================================================================

//==============================================================================
// Assigns
//==============================================================================
//==============================================================================

//==============================================================================
// PU OBUF LD FIFO
//==============================================================================
    assign obuf_ld_stream_write_ready = ~ld_req_buf_almost_full;
  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( OBUF_AXI_DATA_WIDTH            ),
    .RD_DATA_WIDTH                  ( SIMD_INTERIM_WIDTH             ),
    .WR_ADDR_WIDTH                  ( 3                              )
  ) ld_req_buf (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( obuf_ld_stream_write_req       ), //input
    .s_write_data                   ( obuf_ld_stream_write_data      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( obuf_ld_stream_read_req        ), //input
    .s_read_ready                   ( obuf_ld_stream_read_ready      ), //output
    .s_read_data                    ( obuf_ld_stream_read_data       ), //output
    .almost_full                    ( ld_req_buf_almost_full         ), //output
    .almost_empty                   ( ld_req_buf_almost_empty        )  //output
  );
//==============================================================================
    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        alu_in0;
    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        alu_in1;
    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        ld_data_in0;
    wire [ RF_ADDR_WIDTH        -1 : 0 ]        ld_type_in0;
    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        ld_data_in1;
    wire [ RF_ADDR_WIDTH        -1 : 0 ]        ld_type_in1;
 //   wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        zero;
    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        aluin0;
    wire [ SIMD_INTERIM_WIDTH   -1 : 0 ]        aluin1;
//==============================================================================
// PU Store FIFO
//==============================================================================
    assign ddr_st_stream_write_ready = ~st_req_buf_almost_full;
wire [15:0] soft;

generate
for (i=0; i<SIMD_LANES; i=i+1)
begin
assign soft[i] =(reset ==1)?0:(alu_out[ACC_DATA_WIDTH-1:0] == ld_data_in0[i*ACC_DATA_WIDTH+ACC_DATA_WIDTH-1:i*ACC_DATA_WIDTH] )?1'b1:1'b0;
end 
endgenerate

reg [5:0]index1;
always @(posedge clk)
case(1'b1)
soft[0]: index1=6'h1;
soft[1]: index1=6'h2;
soft[2]: index1=6'h3;
soft[3]: index1=6'h4;
soft[4]: index1=6'h5;
soft[5]: index1=6'h6;
soft[6]: index1=6'h7;
soft[7]: index1=6'h8;
soft[8]: index1=6'h9;
soft[9]: index1=6'ha;
soft[10]: index1=6'hb;
soft[11]: index1=6'hc;
soft[12]: index1=6'hd;
soft[13]: index1=6'he;
soft[14]: index1=6'hf;
soft[15]: index1=6'h10;
default: index1=6'h0;
endcase




/*generate
for (i=0; i<SIMD_LANES; i=i+1)
begin*/
   reg [10:0]index;
   reg[ACC_DATA_WIDTH-1:0] max;
   reg [10:0]times;

 assign ddr_st_stream_write_data[SIMD_DATA_WIDTH      -1 : 0 ] = (softmax1==0)?alu_out[SIMD_DATA_WIDTH      -1 : 0 ]:/*(alu_out[ACC_DATA_WIDTH-1:0] == ld_data_in0[i*ACC_DATA_WIDTH+ACC_DATA_WIDTH-1:i*ACC_DATA_WIDTH] )?*/{464'b0,soft[SIMD_LANES-1:0],alu_out[ACC_DATA_WIDTH-1:0]};

  //  assign ddr_st_stream_read_data[ACC_DATA_WIDTH+5:ACC_DATA_WIDTH]=(ddr_st_stream_read_data[ACC_DATA_WIDTH-1:0] == alu_out[i*ACC_DATA_WIDTH+ACC_DATA_WIDTH-1:i*ACC_DATA_WIDTH] )?i:0;
//end
//endgenerate
wire  [ AXI_DATA_WIDTH       -1 : 0 ]        ddr_st_stream_read_data1;
wire softmax2;
wire softmax3;
wire softmax4;
  register_sync #(1) softmax11 (clk, reset, softmax1 ,softmax2);
  register_sync #(1) softmax22 (clk, reset, softmax2 ,softmax3);
  register_sync #(1) softmax33 (clk, reset, softmax3 ,softmax4);
assign ddr_st_stream_read_data=(softmax4==0)?ddr_st_stream_read_data1:{5'b0,index,max,176'b0,ddr_st_stream_read_data1[SIMD_LANES+ACC_DATA_WIDTH-1:0]};
  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( SIMD_DATA_WIDTH                ),
    .RD_DATA_WIDTH                  ( AXI_DATA_WIDTH                 ),
    .WR_ADDR_WIDTH                  ( 3                              )
  ) st_req_buf (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( ddr_st_stream_write_req        ), //input
    .s_write_data                   ( ddr_st_stream_write_data       ), //output
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( ddr_st_stream_read_req         ), //input
    .s_read_ready                   ( ddr_st_stream_read_ready       ), //output
    .s_read_data                    ( ddr_st_stream_read_data1        ), //input
    .almost_full                    ( st_req_buf_almost_full         ), //output
    .almost_empty                   ( st_req_buf_almost_empty        )  //output
  );

reg [1:0]clear;
reg [1:0]clear_d;
  always @(posedge clk)
  begin
  if(reset)
  clear<=2'b0;
  else clear<=clear_d;
  end


  always @(posedge clk)
  begin
  clear_d<=clear;
  case(clear)
  2'b0:if(softmax1) clear_d<=2'b1;
  2'b1:clear_d<=2'b11;
  2'b11:if(reset) clear_d<=2'b00;
  default:clear_d<=2'b0;
  endcase
  end
  

  always @(posedge clk)
  begin
    if (reset || clear==2'b1)
      begin
      index <= 10'b0;
      max <= 'b0;
      times <=6'b0;
      end
    else if (ddr_st_stream_write_req && softmax1==1)
      begin
      times <= times +1'b1;
      if(ddr_st_stream_write_data[ACC_DATA_WIDTH-1:0]>max)
      begin
      index <= index1+(times<<<4);
      max <= ddr_st_stream_write_data[ACC_DATA_WIDTH-1:0];
      end
      end
  /*  else if((chain_rs0_stage2) && (alu_fn_stage3 ==3'b101)&& softmax1==1)
      softimm <= softimm>> 1 ;*/
  end
//==============================================================================

//==============================================================================
// PU LD0 FIFO
//==============================================================================
    assign ddr_ld0_stream_write_ready = ~ld0_req_buf_almost_full;
  fifo_asymmetric #(
    .RD_DATA_WIDTH                  ( SIMD_DATA_WIDTH                ),
    .WR_DATA_WIDTH                  ( AXI_DATA_WIDTH                 ),
    .RD_ADDR_WIDTH                  ( 6                              )
  ) ld0_req_buf (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( ddr_ld0_stream_write_req       ), //input
    .s_write_data                   ( ddr_ld0_stream_write_data      ), //output
    .s_write_ready                  ( ld0_req_buf_write_ready        ), //output
    .s_read_req                     ( ddr_ld0_stream_read_req        ), //input
    .s_read_ready                   ( ddr_ld0_stream_read_ready      ), //output
    .s_read_data                    ( ddr_ld0_stream_read_data       ), //input
    .almost_full                    ( ld0_req_buf_almost_full        ), //output
    .almost_empty                   ( ld0_req_buf_almost_empty       )  //output
  );

  always @(posedge clk)
  begin
    if (reset)
      begin
      softimm <= 0;
    //  softmax <= 1;
      end
    else if (obuf_ld_stream_read_req && softmax && status ==1)
      begin
      softimm <= 1<<SOFTIMMI;
     // softmax <= 0;
      end
    else if((chain_rs0_stage2) && (alu_fn_stage3 ==3'b101))
      softimm <= softimm>> 1 ;
  end

always @(posedge clk)
  begin
    if (reset)
      softmax <= 1;
    else if (obuf_ld_stream_read_req && softmax && status ==1)
      softmax <= 0;
else if(softimm==5'h0) softmax<=1;
end

  always @(posedge clk)
  begin
    if (reset)
      begin
      status <= 1;
      end
    else if (pu_ctrl_state == 3'b110)
      begin
      status <= 1;
      end
    else if(softimm==5'h10)
     status <= 0;
  end

`ifdef COCOTB_SIM
  integer ld0_total_writes;
  always @(posedge clk)
  begin
    if (reset)
      ld0_total_writes <= 0;
    else if (ddr_ld0_stream_write_req && ddr_ld0_stream_write_ready)
      ld0_total_writes <= ld0_total_writes + 1;
  end

  integer ld0_total_reads;
  always @(posedge clk)
  begin
    if (reset)
      ld0_total_reads <= 0;
    else if (ddr_ld0_stream_read_req && ddr_ld0_stream_read_ready)
      ld0_total_reads <= ld0_total_reads + 1;
  end


`endif // COCOTB_SIM
//==============================================================================

//==============================================================================
// PU LD1 FIFO
//==============================================================================
    assign ddr_ld1_stream_write_ready = ~ld1_req_buf_almost_full;
  fifo_asymmetric #(
    .RD_DATA_WIDTH                  ( SIMD_DATA_WIDTH                ),
    .WR_DATA_WIDTH                  ( AXI_DATA_WIDTH                 ),
    .RD_ADDR_WIDTH                  ( 6                              )
  ) ld1_req_buf (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( ddr_ld1_stream_write_req       ), //input
    .s_write_data                   ( ddr_ld1_stream_write_data      ), //output
    .s_write_ready                  ( ld1_req_buf_write_ready        ), //output
    .s_read_req                     ( ddr_ld1_stream_read_req        ), //input
    .s_read_ready                   ( ddr_ld1_stream_read_ready      ), //output
    .s_read_data                    ( ddr_ld1_stream_read_data       ), //input
    .almost_full                    ( ld1_req_buf_almost_full        ), //output
    .almost_empty                   ( ld1_req_buf_almost_empty       )  //output
  );
`ifdef COCOTB_SIM
  integer ld1_total_writes;
  always @(posedge clk)
  begin
    if (reset)
      ld1_total_writes <= 0;
    else if (ddr_ld1_stream_write_req && ddr_ld1_stream_write_ready)
      ld1_total_writes <= ld1_total_writes + 1;
  end

  integer ld1_total_reads;
  always @(posedge clk)
  begin
    if (reset)
      ld1_total_reads <= 0;
    else if (ddr_ld1_stream_read_req && ddr_ld1_stream_read_ready)
      ld1_total_reads <= ld1_total_reads + 1;
  end
`endif // COCOTB_SIM
//==============================================================================

//==============================================================================
// delays
//==============================================================================
    register_sync_with_enable #(FN_WIDTH) alu_fn_delay_reg1
    (clk, reset, 1'b1, alu_fn, alu_fn_stage2);
    register_sync_with_enable #(FN_WIDTH) alu_fn_delay_reg2
    (clk, reset, 1'b1, alu_fn_stage2, alu_fn_stage3);

    register_sync_with_enable #(1) alu_fn_valid_delay_reg1
    (clk, reset, 1'b1, alu_fn_valid, alu_fn_valid_stage2);
    register_sync_with_enable #(1) alu_fn_valid_delay_reg2
    (clk, reset, 1'b1, alu_fn_valid_stage2, alu_fn_valid_stage3);

    register_sync_with_enable #(IMM_WIDTH) alu_imm_delay_reg1
    (clk, reset, 1'b1, alu_imm, alu_imm_stage2);


    register_sync_with_enable #(IMM_WIDTH) alu_imm_delay_reg2
    (clk, reset, 1'b1, alu_imm_stage2, alu_imm_stage3);


    register_sync_with_enable #(1) alu_in1_src_delay_reg1
    (clk, reset, 1'b1, alu_in1_src, alu_in1_src_stage2);

    register_sync_with_enable #(1) alu_in1_src_delay_reg2
    (clk, reset, 1'b1, alu_in1_src_stage2, alu_in1_src_stage3);

    register_sync_with_enable #(SRC_ADDR_WIDTH) alu_in0_addr_delay_reg1
    (clk, reset, 1'b1, alu_in0_addr, alu_in0_addr_stage2);

    register_sync_with_enable #(SRC_ADDR_WIDTH) alu_in1_addr_delay_reg1
    (clk, reset, 1'b1, alu_in1_addr, alu_in1_addr_stage2);
//==============================================================================

//==============================================================================
// Register File
//==============================================================================
    assign alu_in0_req = 1'b1;
    assign alu_in1_req = 1'b1;
    wire                                        alu_wb_req;
    assign alu_wb_req = alu_fn_valid_stage3 && ~ddr_st_stream_write_req;

    wire [ RF_ADDR_WIDTH        -1 : 0 ]        regfile_in0_addr;
    wire [ RF_ADDR_WIDTH        -1 : 0 ]        regfile_in1_addr;
    wire [ RF_ADDR_WIDTH        -1 : 0 ]        regfile_out_addr;
    assign regfile_in0_addr = alu_in0_addr;
    assign regfile_in1_addr = alu_in1_addr;
    assign regfile_out_addr = alu_out_addr_stage3;
  reg_file #(
    .DATA_WIDTH                     ( SIMD_INTERIM_WIDTH             ),
    .ADDR_WIDTH                     ( RF_ADDR_WIDTH                  )
  ) c_regfile (
    .clk                            ( clk                            ), //input
    .rd_req_0                       ( alu_in0_req                    ), //input
    .rd_addr_0                      ( regfile_in0_addr               ), //input
    .rd_data_0                      ( alu_in0_data                   ), //output
    .rd_req_1                       ( alu_in1_req                    ), //input
    .rd_addr_1                      ( regfile_in1_addr               ), //input
    .rd_data_1                      ( alu_in1_data                   ), //output
    .wr_req_0                       ( alu_wb_req                     ), //input
    .wr_addr_0                      ( regfile_out_addr               ), //input
    .wr_data_0                      ( alu_out                        )  //input
    );
//==============================================================================

//==============================================================================
// PU ALU
//==============================================================================


    assign ld_type_in0 = alu_in0_addr_stage2;
    assign ld_type_in1 = alu_in1_addr_stage2;
 //   assign zero    ='b0;


generate
for (i=0; i<SIMD_LANES; i=i+1)
begin
    assign ld_data_in0[i*ACC_DATA_WIDTH+:ACC_DATA_WIDTH] = ld_type_in0 == 0 ||softmax1 == 1?
                                                   obuf_ld_stream_read_data[i*ACC_DATA_WIDTH+:ACC_DATA_WIDTH] :
                                                   ld_type_in0 == 1 ? ddr_ld0_stream_read_data[i*DATA_WIDTH+:DATA_WIDTH] :
                                                                      ddr_ld1_stream_read_data[i*DATA_WIDTH+:DATA_WIDTH];
assign ld_data_in1[i*ACC_DATA_WIDTH+:ACC_DATA_WIDTH] = ld_type_in1 == 0 ||softmax1 == 1?
                                                   obuf_ld_stream_read_data[i*ACC_DATA_WIDTH+:ACC_DATA_WIDTH] :
                                                   ld_type_in1 == 1 ? ddr_ld0_stream_read_data[i*DATA_WIDTH+:DATA_WIDTH] :
                                                                      ddr_ld1_stream_read_data[i*DATA_WIDTH+:DATA_WIDTH];
end
endgenerate

    assign alu_in0 = softmax1 == 1? 'bz : alu_in0_addr_stage2[3] ? ld_data_in0 :
                     chain_rs0_stage2 ? alu_out :
                     fwd_rs0_stage2 ? alu_out_fwd : alu_in0_data;
    assign alu_in1 = softmax1 == 1?'bz : alu_in1_addr_stage2[3] ? ld_data_in1 :
                     chain_rs1_stage2 ? alu_out :
                     fwd_rs1_stage2 ? alu_out_fwd : alu_in1_data;

assign aluin0 =(softmax1==0)? 0:(softimm==5'h8)? ld_data_in0[8*ACC_DATA_WIDTH-1:0]:(softimm==5'h4)? alu_out_fwd1[4*ACC_DATA_WIDTH-1:0]:(softimm==5'h2)? alu_out_fwd1[2*ACC_DATA_WIDTH-1:0]:(softimm==5'h1)? alu_out_fwd1[1*ACC_DATA_WIDTH-1:0]:alu_out_fwd1[1*ACC_DATA_WIDTH-1:0];

//always @(posedge clk)
//if(softimm==5'h0) softmax<=1;
 /* always @(posedge clk)
  begin
    if (reset)
      aluin0 <= 0;
    else if (softmax1)
      case(softimm)
      5'h0: aluin0 <= 0;
      5'h1: begin if(alu_fn_choose==3'h5) 
aluin0 <= 0;
softmax<= 1; end
      5'h2: begin if(alu_fn_choose==3'h0) aluin0 <= alu_out_fwd1[1*ACC_DATA_WIDTH-1:0];end
      5'h4: begin if(alu_fn_choose==3'h5) aluin0 <= alu_out_fwd1[2*ACC_DATA_WIDTH-1:0];end
      5'h8: begin if(alu_fn_choose==3'h0) aluin0 <= alu_out_fwd1[4*ACC_DATA_WIDTH-1:0];end
      5'h10: 
begin if(chain_rs0_stage3) 
aluin0 <= alu_out_fwd1[8*ACC_DATA_WIDTH-1:0];
else
aluin0 <= ld_data_in0[16*ACC_DATA_WIDTH-1:0];
end

     endcase
    else
      aluin0 <= 'z;
  end

  always @(posedge clk)
  begin
    if (reset)
      aluin1 <= 0;
    else if (softmax1)
      case(softimm)
      5'h0: aluin1 <= 0;
      5'h1: begin if(alu_fn_choose==3'h5)aluin1 <= alu_out_fwd1[2*ACC_DATA_WIDTH-1:1*ACC_DATA_WIDTH]; end
      5'h2: begin if(alu_fn_choose==3'h0)aluin1 <= alu_out_fwd1[4*ACC_DATA_WIDTH-1:2*ACC_DATA_WIDTH]; end
      5'h4: begin if(alu_fn_choose==3'h5) aluin1 <= alu_out_fwd1[8*ACC_DATA_WIDTH-1:4*ACC_DATA_WIDTH]; end
      5'h8: begin if(alu_fn_choose==3'h0)aluin1 <= alu_out_fwd1[16*ACC_DATA_WIDTH-1:8*ACC_DATA_WIDTH]; end
      5'h10:begin if(chain_rs0_stage3) 
aluin1 <= alu_out_fwd1[16*ACC_DATA_WIDTH-1:8*ACC_DATA_WIDTH];
else
aluin1 <= ld_data_in0[32*ACC_DATA_WIDTH-1:16*ACC_DATA_WIDTH];
end
     endcase
    else
      aluin1 <= 'z;
  end*/
assign aluin1= (softmax1==0)? 0:(softimm==5'h8)? ld_data_in0[16*ACC_DATA_WIDTH-1:8*ACC_DATA_WIDTH]:(softimm==5'h4)? alu_out_fwd1[8*ACC_DATA_WIDTH-1:4*ACC_DATA_WIDTH]:(softimm==5'h2)? alu_out_fwd1[4*ACC_DATA_WIDTH-1:2*ACC_DATA_WIDTH]:(softimm==5'h1)? alu_out_fwd1[2*ACC_DATA_WIDTH-1:1*ACC_DATA_WIDTH]:0;


assign alu_fn_choose = softmax1 == 1?alu_fn_stage3 :alu_fn_stage2;
assign alu_fn_valid_choose = softmax1 == 1?alu_fn_valid_stage3 :alu_fn_valid_stage2;
    assign alu_imm_choose = (softmax1 == 1)?alu_imm_stage3:alu_imm_stage2;
    assign alu_in1_src_choose = (softmax1 == 1)?alu_in1_src_stage3:alu_in1_src_stage2;
generate
for (i=0; i<SIMD_LANES; i=i+1)
begin: ALU_INST
    wire [ ACC_DATA_WIDTH       -1 : 0 ]        local_alu_in0;
    wire [ DATA_WIDTH           -1 : 0 ]        local_alu_in1;
    wire [ ACC_DATA_WIDTH       -1 : 0 ]        local_alu_out;

    assign local_alu_in0 = softmax1?aluin0[i*ACC_DATA_WIDTH+ACC_DATA_WIDTH-1:i*ACC_DATA_WIDTH] :alu_in0[i*ACC_DATA_WIDTH+ACC_DATA_WIDTH-1:i*ACC_DATA_WIDTH];
    assign local_alu_in1 = softmax1? aluin1[i*ACC_DATA_WIDTH+ACC_DATA_WIDTH-1:i*ACC_DATA_WIDTH] :alu_in1[i*ACC_DATA_WIDTH+DATA_WIDTH-1:i*ACC_DATA_WIDTH];
    assign alu_out[i*ACC_DATA_WIDTH+:ACC_DATA_WIDTH] = local_alu_out;


    


  pu_alu #(
    .DATA_WIDTH                     ( DATA_WIDTH                     ),
    .ACC_DATA_WIDTH                 ( ACC_DATA_WIDTH                 ),
    .IMM_WIDTH                      ( IMM_WIDTH                      ),
    .FN_WIDTH                       ( FN_WIDTH                       )
  ) scalar_alu (
    .clk                            ( clk                            ), //input
    .fn_valid                       ( alu_fn_valid_choose            ), //input
    .fn                             ( alu_fn_choose                  ), //input
    .imm                            ( alu_imm_choose                 ), //input
    .alu_in0                        ( local_alu_in0                  ), //input
    .alu_in1_src                    ( alu_in1_src_choose             ), //input
    .alu_in1                        ( local_alu_in1                  ), //input
    .alu_out                        ( local_alu_out                  )  //output
  );
end
endgenerate

  always @(posedge clk)
    alu_out_fwd <= alu_out;
assign alu_out_fwd1=(softimm==5'h8)?alu_out:(~(softimm ==5'h8)&& chain_rs0_stage3&& (alu_fn_choose==3'b00||alu_fn_choose==3'b011))?alu_out:alu_out_fwd1;



//==============================================================================

//==============================================================================
// DEBUG Counters
//==============================================================================
 /*   reg  [ 16                   -1 : 0 ]        _obuf_ld_stream_read_count;
    reg  [ 16                   -1 : 0 ]        _obuf_ld_stream_write_count;
    reg  [ 16                   -1 : 0 ]        _ddr_st_stream_read_count;
    reg  [ 16                   -1 : 0 ]        _ddr_st_stream_write_count;

    reg  [ 16                   -1 : 0 ]        _ddr_ld0_stream_read_count;
    reg  [ 16                   -1 : 0 ]        _ddr_ld0_stream_write_count;
    reg  [ 16                   -1 : 0 ]        _ddr_ld1_stream_read_count;
    reg  [ 16                   -1 : 0 ]        _ddr_ld1_stream_write_count;

    wire [ 16                   -1 : 0 ]        _ld_req_buf_fifo_count;
    wire [ 16                   -1 : 0 ]        _st_req_buf_fifo_count;
    wire [ 16                   -1 : 0 ]        _ld0_req_buf_fifo_count;
    wire [ 16                   -1 : 0 ]        _ld1_req_buf_fifo_count;

always @(posedge clk)
begin
  if (reset) begin
    _obuf_ld_stream_read_count <= 0;
    _obuf_ld_stream_write_count <= 0;
    _ddr_st_stream_read_count <= 0;
    _ddr_st_stream_write_count <= 0;
    _ddr_ld0_stream_read_count <= 0;
    _ddr_ld0_stream_write_count <= 0;
    _ddr_ld1_stream_read_count <= 0;
    _ddr_ld1_stream_write_count <= 0;
  end else begin
    if (obuf_ld_stream_read_req)
      _obuf_ld_stream_read_count <= _obuf_ld_stream_read_count + 1'b1;
    if (obuf_ld_stream_write_req)
    _obuf_ld_stream_write_count <= _obuf_ld_stream_write_count + 1'b1;
    if (ddr_st_stream_read_req)
    _ddr_st_stream_read_count <= _ddr_st_stream_read_count + 1'b1;
    if (ddr_st_stream_write_req)
    _ddr_st_stream_write_count <= _ddr_st_stream_write_count + 1'b1;
    if (ddr_ld0_stream_read_req)
      _ddr_ld0_stream_read_count <= _ddr_ld0_stream_read_count + 1'b1;
    if (ddr_ld0_stream_write_req)
      _ddr_ld0_stream_write_count <= _ddr_ld0_stream_write_count + 1'b1;
    if (ddr_ld1_stream_read_req)
      _ddr_ld1_stream_read_count <= _ddr_ld1_stream_read_count + 1'b1;
    if (ddr_ld1_stream_write_req)
      _ddr_ld1_stream_write_count <= _ddr_ld1_stream_write_count + 1'b1;
  end
end

    assign _ld_req_buf_fifo_count = ld_req_buf.fifo_count;
    assign _st_req_buf_fifo_count = st_req_buf.fifo_count;
    assign _ld0_req_buf_fifo_count = ld0_req_buf.fifo_count;
    assign _ld1_req_buf_fifo_count = ld1_req_buf.fifo_count;



    assign obuf_ld_stream_read_count = {_obuf_ld_stream_read_count, _obuf_ld_stream_write_count};
    assign obuf_ld_stream_write_count = {_ddr_st_stream_read_count, _ddr_st_stream_write_count};
    assign ddr_st_stream_read_count = {_ld_req_buf_fifo_count, _st_req_buf_fifo_count};
    assign ddr_st_stream_write_count = {_ld1_req_buf_fifo_count, _ld0_req_buf_fifo_count};
    assign ld0_stream_counts = {_ddr_ld0_stream_read_count, _ddr_ld0_stream_write_count};
    assign ld1_stream_counts = {_ddr_ld1_stream_read_count, _ddr_ld1_stream_write_count};*/
//==============================================================================




//==============================================================================
// VCD
//==============================================================================
`ifdef COCOTB_TOPLEVEL_simd_pu_core
  initial begin
    $dumpfile("simd_pu_core.vcd");
    $dumpvars(0, simd_pu_core);
  end
`endif
//==============================================================================

endmodule
