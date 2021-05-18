//
// Wrapper for memory
//
// Hardik Sharma
// (hsharma@gatech.edu)

`timescale 1ns/1ps
module obuf_mem_wrapper #(
  // Internal Parameters
    parameter integer  MEM_ID                       = 1,
    parameter integer  STORE_ENABLED                = 1,
    parameter integer  MEM_REQ_W                    = 16,
    parameter integer  ADDR_WIDTH                   = 8,
    parameter integer  DATA_WIDTH                   = 64,
    parameter integer  LOOP_ITER_W                  = 16,
    parameter integer  ADDR_STRIDE_W                = 32,
    parameter integer  LOOP_ID_W                    = 5,
    parameter integer  BUF_TYPE_W                   = 2,
    parameter integer  NUM_TAGS                     = 4,
    parameter integer  TAG_W                        = $clog2(NUM_TAGS),

  // AXI
    parameter integer  AXI_ID_WIDTH                 = 1,
    parameter integer  AXI_ADDR_WIDTH               = 42,
    parameter integer  AXI_DATA_WIDTH               = 64,
    parameter integer  AXI_BURST_WIDTH              = 8,
    parameter integer  WSTRB_W                      = AXI_DATA_WIDTH/8,

  // Buffer
    parameter integer  ARRAY_N                      = 4,
    parameter integer  ARRAY_M                      = 4,
    parameter integer  BUF_DATA_WIDTH               = DATA_WIDTH * ARRAY_M,
    parameter integer  BUF_ADDR_W                   = 16,
    parameter integer  MEM_ADDR_W                   = BUF_ADDR_W + $clog2(BUF_DATA_WIDTH / AXI_DATA_WIDTH),
    parameter integer  TAG_BUF_ADDR_W               = BUF_ADDR_W + TAG_W,
    parameter integer  TAG_MEM_ADDR_W               = MEM_ADDR_W + TAG_W
) (
    input  wire                                         clk,
    input  wire                                         reset,

    input  wire                                         tag_req,
    input  wire                                         tag_reuse,
    input  wire                                         tag_bias_prev_sw,
    input  wire                                         tag_ddr_pe_sw,
    output wire                                         tag_ready,
    output wire                                         tag_done,
    input  wire                                         compute_done,
    input  wire                                         block_done,
    input  wire  [ ADDR_WIDTH           -1 : 0 ]        tag_base_ld_addr,
    input  wire  [ ADDR_WIDTH           -1 : 0 ]        tag_base_st_addr,
    input  wire                                           obuf_ld_addr_v,
    input  wire                                           obuf_st_addr_v,

    output wire                                         compute_ready,
    output wire                                         compute_bias_prev_sw,

  // Programming
    input  wire                                         cfg_loop_stride_v,
    input  wire  [ ADDR_STRIDE_W        -1 : 0 ]        cfg_loop_stride,
    input  wire  [ LOOP_ID_W            -1 : 0 ]        cfg_loop_stride_loop_id,
    input  wire  [ BUF_TYPE_W           -1 : 0 ]        cfg_loop_stride_id,
    input  wire  [ 2                    -1 : 0 ]        cfg_loop_stride_type,

    input  wire                                         cfg_loop_iter_v,
    input  wire  [ LOOP_ITER_W          -1 : 0 ]        cfg_loop_iter,
    input  wire  [ LOOP_ID_W            -1 : 0 ]        cfg_loop_iter_loop_id,

    input  wire                                         cfg_mem_req_v,
    input  wire  [ BUF_TYPE_W           -1 : 0 ]        cfg_mem_req_id,
    input  wire  [ MEM_REQ_W            -1 : 0 ]        cfg_mem_req_size,
    input  wire  [ LOOP_ID_W            -1 : 0 ]        cfg_mem_req_loop_id,
    input  wire  [ 2                    -1 : 0 ]        cfg_mem_req_type,

  // Systolic Array
    input  wire  [ BUF_DATA_WIDTH       -1 : 0 ]        buf_write_data,
    input  wire                                         buf_write_req,
    input  wire  [ BUF_ADDR_W           -1 : 0 ]        buf_write_addr,
    output wire  [ BUF_DATA_WIDTH       -1 : 0 ]        buf_read_data,
    input  wire                                         buf_read_req,
    input  wire  [ BUF_ADDR_W           -1 : 0 ]        buf_read_addr,

  // PU
    input  wire                                         pu_buf_read_req,
    input  wire  [ MEM_ADDR_W           -1 : 0 ]        pu_buf_read_addr,
    output wire                                         pu_buf_read_ready,

    output wire  [ AXI_DATA_WIDTH       -1 : 0 ]        obuf_ld_stream_write_data,
    output wire                                         obuf_ld_stream_write_req,

    output wire                                         pu_compute_start,
    input  wire                                         pu_compute_ready,
    input  wire                                         pu_compute_done,

  // CL_wrapper -> DDR AXI4 interface
    // Master Interface Write Address
    output wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        mws_awaddr,
    output wire  [ AXI_BURST_WIDTH      -1 : 0 ]        mws_awlen,
    output wire  [ 3                    -1 : 0 ]        mws_awsize,
    output wire  [ 2                    -1 : 0 ]        mws_awburst,
    output wire                                         mws_awvalid,
    input  wire                                         mws_awready,
    // Master Interface Write Data
    output wire  [ AXI_DATA_WIDTH       -1 : 0 ]        mws_wdata,
    output wire  [ WSTRB_W              -1 : 0 ]        mws_wstrb,
    output wire                                         mws_wlast,
    output wire                                         mws_wvalid,
    input  wire                                         mws_wready,
    // Master Interface Write Response
    input  wire  [ 2                    -1 : 0 ]        mws_bresp,
    input  wire                                         mws_bvalid,
    output wire                                         mws_bready,
    // Master Interface Read Address
    output wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        mws_araddr,
    output wire  [ AXI_ID_WIDTH         -1 : 0 ]        mws_arid,
    output wire  [ AXI_BURST_WIDTH      -1 : 0 ]        mws_arlen,
    output wire  [ 3                    -1 : 0 ]        mws_arsize,
    output wire  [ 2                    -1 : 0 ]        mws_arburst,
    output wire                                         mws_arvalid,
    input  wire                                         mws_arready,
    // Master Interface Read Data
    input  wire  [ AXI_DATA_WIDTH       -1 : 0 ]        mws_rdata,
    input  wire  [ AXI_ID_WIDTH         -1 : 0 ]        mws_rid,
    input  wire  [ 2                    -1 : 0 ]        mws_rresp,
    input  wire                                         mws_rlast,
    input  wire                                         mws_rvalid,
    output wire                                         mws_rready,

    output wire  [ 4                    -1 : 0 ]        stmem_state,
    output wire  [ TAG_W                -1 : 0 ]        stmem_tag,
    output wire                                         stmem_ddr_pe_sw,
   output wire                                        ldmem_tag_done,
   output wire                                        stmem_tag_done,
  output wire                                        stmem_tag_ready,
 // input wire permit,
    output wire                                        mws_ld_start,
    input  wire [4-1:0] wrapperldstate,
    input wire noneed
);

//==============================================================================
// Localparams
//==============================================================================
    localparam integer  LDMEM_IDLE                   = 0;
    localparam integer  LDMEM_CHECK_RAW              = 1;
    localparam integer  LDMEM_BUSY                   = 2;
    localparam integer  LDMEM_WAIT_0                 = 3;
    localparam integer  LDMEM_WAIT_1                 = 4;
    localparam integer  LDMEM_WAIT_2                 = 5;
    localparam integer  LDMEM_WAIT_3                 = 6;
    localparam integer  LDMEM_DONE                   = 7;

    localparam integer  STMEM_IDLE                   = 0;
    localparam integer  STMEM_COMPUTE_WAIT           = 1;
    localparam integer  STMEM_DDR                    = 2;
    localparam integer  STMEM_DDR_WAIT               = 3;
    localparam integer  STMEM_DONE                   = 4;
    localparam integer  STMEM_PU                     = 5;

    localparam integer  MEM_LD                       = 0;
    localparam integer  MEM_ST                       = 1;
    localparam integer  MEM_RD                       = 2;
    localparam integer  MEM_WR                       = 3;

     wire [4-1:0] wrapperldstate_dly1;
wire [4-1:0] wrapperldstate_dly2;
//==============================================================================
    register_sync_with_enable #(4) ldstate_delay1
    (clk, reset, 1'b1, wrapperldstate, wrapperldstate_dly1);
    register_sync_with_enable #(4) ldstate_delay2
    (clk, reset, 1'b1, wrapperldstate_dly1, wrapperldstate_dly2);
//==============================================================================
// Wires/Regs
//==============================================================================
    wire                                        compute_tag_done;
    wire                                        compute_tag_reuse;
    wire                                        compute_tag_ready;
    wire [ TAG_W                -1 : 0 ]        compute_tag;
    wire [ TAG_W                -1 : 0 ]        compute_tag_delayed;
//    wire                                        ldmem_tag_done;
    wire                                        ldmem_tag_ready;
    wire [ TAG_W                -1 : 0 ]        ldmem_tag;
//    wire                                        stmem_tag_done;
 //   wire                                        stmem_tag_ready;

    reg  [ 4                    -1 : 0 ]        ldmem_state_d;
    reg  [ 4                    -1 : 0 ]        ldmem_state_q;

    reg  [ 4                    -1 : 0 ]        stmem_state_d;
    reg  [ 4                    -1 : 0 ]        stmem_state_q;

    wire                                        ld_mem_req_v;
    wire                                        st_mem_req_v;

    wire [ TAG_W                -1 : 0 ]        tag;


    reg                                         ld_iter_v_q;
    reg  [ LOOP_ITER_W          -1 : 0 ]        iter_q;
    reg                                         st_iter_v_q;

    reg  [ LOOP_ID_W            -1 : 0 ]        ld_loop_id_counter;
    reg  [ LOOP_ID_W            -1 : 0 ]        st_loop_id_counter;

    wire [ LOOP_ID_W            -1 : 0 ]        mws_ld_loop_iter_loop_id;
    wire [ LOOP_ITER_W          -1 : 0 ]        mws_ld_loop_iter;
    wire                                        mws_ld_loop_iter_v;
//    wire                                        mws_ld_start;
    wire                                        mws_ld_done;
    wire                                        mws_ld_stall;
    wire                                        mws_ld_init;
    wire                                        mws_ld_enter;
    wire                                        mws_ld_exit;
    wire [ LOOP_ID_W            -1 : 0 ]        mws_ld_index;
    wire                                        mws_ld_index_valid;
    wire                                        mws_ld_step;

    wire [ LOOP_ID_W            -1 : 0 ]        mws_st_loop_iter_loop_id;
    wire [ LOOP_ITER_W          -1 : 0 ]        mws_st_loop_iter;
    wire                                        mws_st_loop_iter_v;
    wire                                        mws_st_start;
    wire                                        mws_st_done;
    wire                                        mws_st_stall;
    wire                                        mws_st_init;
    wire                                        mws_st_enter;
    wire                                        mws_st_exit;
    wire [ LOOP_ID_W            -1 : 0 ]        mws_st_index;
    wire                                        mws_st_index_valid;
    wire                                        mws_st_step;

    wire                                        ld_stride_v;
    wire [ ADDR_STRIDE_W        -1 : 0 ]        ld_stride;
    wire [ BUF_TYPE_W           -1 : 0 ]        ld_stride_id;
    wire                                        st_stride_v;
    wire [ ADDR_STRIDE_W        -1 : 0 ]        st_stride;
    wire [ BUF_TYPE_W           -1 : 0 ]        st_stride_id;

    wire [ ADDR_WIDTH           -1 : 0 ]        ld_addr;
    wire [ ADDR_WIDTH           -1 : 0 ]        mws_ld_base_addr;
    wire                                        ld_addr_v;
    wire [ ADDR_WIDTH           -1 : 0 ]        st_addr;
    wire [ ADDR_WIDTH           -1 : 0 ]        mws_st_base_addr;
    wire                                        st_addr_v;


    reg  [ MEM_REQ_W            -1 : 0 ]        ld_req_size;
    reg  [ MEM_REQ_W            -1 : 0 ]        st_req_size;

    wire                                        ld_req_valid_d;
    wire                                        st_req_valid_d;

    reg                                         ld_req_valid_q;
    reg                                         st_req_valid_q;

    reg  [ ADDR_WIDTH           -1 : 0 ]        tag_ld_addr[0:NUM_TAGS-1];
    reg  [ ADDR_WIDTH           -1 : 0 ]        tag_st_addr[0:NUM_TAGS-1];

    reg  [ ADDR_WIDTH           -1 : 0 ]        ld_req_addr;
    reg  [ ADDR_WIDTH           -1 : 0 ]        st_req_addr;

    reg  [ MEM_REQ_W            -1 : 0 ]        st_req_loop_id;

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

    wire                                        mem_write_req;
    wire [ AXI_ID_WIDTH         -1 : 0 ]        mem_write_id;
    wire [ AXI_DATA_WIDTH       -1 : 0 ]        mem_write_data;
    reg  [ MEM_ADDR_W           -1 : 0 ]        mem_write_addr;
    wire                                        mem_write_ready;
    wire [ AXI_DATA_WIDTH       -1 : 0 ]        mem_read_data;
    wire [ MEM_ADDR_W           -1 : 0 ]        mem_read_addr;
    reg  [ MEM_ADDR_W           -1 : 0 ]        axi_mem_read_addr;
    wire                                        axi_mem_read_req;
    wire                                        axi_mem_read_ready;
    wire                                        mem_read_req;
    wire                                        mem_read_ready;

  // Adding register to buf read data
    wire [ BUF_DATA_WIDTH       -1 : 0 ]        _buf_read_data;
//==============================================================================

//==============================================================================
// Assigns
//==============================================================================
    assign ld_stride = cfg_loop_stride;
    assign ld_stride_v = cfg_loop_stride_v && cfg_loop_stride_loop_id == 1 + MEM_ID && cfg_loop_stride_type == MEM_LD && cfg_loop_stride_id == MEM_ID;
    assign st_stride = cfg_loop_stride;
    assign st_stride_v = cfg_loop_stride_v && cfg_loop_stride_loop_id == 1 + MEM_ID && cfg_loop_stride_type == MEM_ST && cfg_loop_stride_id == MEM_ID;

    assign mws_ld_base_addr = tag_ld_addr[ldmem_tag];
    assign mws_st_base_addr = tag_st_addr[stmem_tag];
    assign axi_rd_req = ld_req_valid_q;
    assign axi_rd_req_size = ld_req_size * (ARRAY_M * DATA_WIDTH) / AXI_DATA_WIDTH;
    assign axi_rd_addr = ld_req_addr;

    assign axi_wr_req = st_req_valid_q;
    assign axi_wr_req_id = 1'b0;
    assign axi_wr_req_size = st_req_size * (ARRAY_M * DATA_WIDTH) / AXI_DATA_WIDTH;
    assign axi_wr_addr = st_req_addr;
//==============================================================================

//==============================================================================
//==============================================================================
    reg                                         read_req_dly1;
  always @(posedge clk)
  begin
    if (reset) begin
      read_req_dly1 <= 1'b0;
    end else begin
      read_req_dly1 <= pu_buf_read_req;
    end
  end
    assign obuf_ld_stream_write_req = read_req_dly1;
    assign obuf_ld_stream_write_data = mem_read_data;
//==============================================================================

//==============================================================================
// Address generators
//==============================================================================
    assign mws_ld_stall=noneed?0:( ~ldmem_tag_ready || ~axi_rd_ready);
    assign mws_ld_step = mws_ld_index_valid && !mws_ld_stall;
  mem_walker_stride #(
    .ADDR_WIDTH                     ( ADDR_WIDTH                     ),
    .ADDR_STRIDE_W                  ( ADDR_STRIDE_W                  ),
    .LOOP_ID_W                      ( LOOP_ID_W                      )
  ) mws_ld (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .base_addr                      ( mws_ld_base_addr               ), //input
    .loop_ctrl_done                 ( mws_ld_done                    ), //input
    .loop_index                     ( mws_ld_index                   ), //input
    .loop_index_valid               ( mws_ld_step                    ), //input
    .loop_init                      ( mws_ld_init                    ), //input
    .loop_enter                     ( mws_ld_enter                   ), //input
    .loop_exit                      ( mws_ld_exit                    ), //input
    .cfg_addr_stride_v              ( ld_stride_v                    ), //input
    .cfg_addr_stride                ( ld_stride                      ), //input
    .addr_out                       ( ld_addr                        ), //output
    .addr_out_valid                 ( ld_addr_v                      )  //output
  );

    wire                                        _mws_st_done;
    assign _mws_st_done = mws_st_done || mws_ld_done; // Added for the cases when the mws_st is programmed but not used
  mem_walker_stride #(
    .ADDR_WIDTH                     ( ADDR_WIDTH                     ),
    .ADDR_STRIDE_W                  ( ADDR_STRIDE_W                  ),
    .LOOP_ID_W                      ( LOOP_ID_W                      )
  ) mws_st (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .base_addr                      ( mws_st_base_addr               ), //input
    .loop_ctrl_done                 ( _mws_st_done                   ), //input
    .loop_index                     ( mws_st_index                   ), //input
    .loop_index_valid               ( mws_st_step                    ), //input
    .loop_init                      ( mws_st_init                    ), //input
    .loop_enter                     ( mws_st_enter                   ), //input
    .loop_exit                      ( mws_st_exit                    ), //input
    .cfg_addr_stride_v              ( st_stride_v                    ), //input
    .cfg_addr_stride                ( st_stride                      ), //input
    .addr_out                       ( st_addr                        ), //output
    .addr_out_valid                 ( st_addr_v                      )  //output
    );

    assign mws_st_step = mws_st_index_valid && !mws_st_stall;
    assign mws_st_stall = ~stmem_tag_ready || ~axi_wr_ready;
//==============================================================================

//=============================================================
// Loop controller
//=============================================================
  always@(posedge clk)
  begin
    if (reset)
      ld_loop_id_counter <= 'b0;
    else begin
      if (mws_ld_loop_iter_v)
        ld_loop_id_counter <= ld_loop_id_counter + 1'b1;
      else if (tag_req && tag_ready)
        ld_loop_id_counter <= 'b0;
    end
  end

  always @(posedge clk)
  begin
    if (reset)
      ld_iter_v_q <= 1'b0;
    else begin
      if (cfg_loop_iter_v && cfg_loop_iter_loop_id == 1 + MEM_ID)
        ld_iter_v_q <= 1'b1;
      else if (cfg_loop_iter_v || ld_stride_v)
        ld_iter_v_q <= 1'b0;
    end
  end


  always @(posedge clk)
  begin
    if (reset)
      st_iter_v_q <= 1'b0;
    else begin
      if (cfg_loop_iter_v && cfg_loop_iter_loop_id == 1 + MEM_ID)
        st_iter_v_q <= 1'b1;
      else if (cfg_loop_iter_v || st_stride_v)
        st_iter_v_q <= 1'b0;
    end
  end

  always@(posedge clk)
  begin
    if (reset)
      st_loop_id_counter <= 'b0;
    else begin
      if (mws_st_loop_iter_v)
        st_loop_id_counter <= st_loop_id_counter + 1'b1;
      else if (tag_req && tag_ready)
        st_loop_id_counter <= 'b0;
    end
  end

    assign mws_ld_start = (ldmem_state_q == LDMEM_BUSY);
    assign mws_ld_loop_iter_v = ld_stride_v && ld_iter_v_q;
    assign mws_ld_loop_iter = iter_q;
    assign mws_ld_loop_iter_loop_id = ld_loop_id_counter;

  always @(posedge clk)
  begin
    if (reset) begin
      iter_q <= 'b0;
    end
    else if (cfg_loop_iter_v && cfg_loop_iter_loop_id == 1 + MEM_ID) begin
      iter_q <= cfg_loop_iter;
    end
  end

  controller_fsm #(
    .LOOP_ID_W                      ( LOOP_ID_W                      ),
    .LOOP_ITER_W                    ( LOOP_ITER_W                    ),
    .IMEM_ADDR_W                    ( LOOP_ID_W                      )
  ) mws_ld_ctrl (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .stall                          ( mws_ld_stall                   ), //input
    .cfg_loop_iter_v                ( mws_ld_loop_iter_v             ), //input
    .cfg_loop_iter                  ( mws_ld_loop_iter               ), //input
    .cfg_loop_iter_loop_id          ( mws_ld_loop_iter_loop_id       ), //input
    .start                          ( mws_ld_start                   ), //input
    .done                           ( mws_ld_done                    ), //output
    .loop_init                      ( mws_ld_init                    ), //output
    .loop_enter                     ( mws_ld_enter                   ), //output
    .loop_last_iter                 (                                ), //output
    .loop_exit                      ( mws_ld_exit                    ), //output
    .loop_index                     ( mws_ld_index                   ), //output
    .loop_index_valid               ( mws_ld_index_valid             )  //output
  );

    assign mws_st_loop_iter_loop_id = st_loop_id_counter;
    assign mws_st_start = stmem_state_q == STMEM_DDR;
    assign mws_st_loop_iter = iter_q;

    assign mws_st_loop_iter_v = st_stride_v && st_iter_v_q;

  controller_fsm #(
    .LOOP_ID_W                      ( LOOP_ID_W                      ),
    .LOOP_ITER_W                    ( LOOP_ITER_W                    ),
    .IMEM_ADDR_W                    ( LOOP_ID_W                      )
  ) mws_st_ctrl (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .stall                          ( mws_st_stall                   ), //input
    .cfg_loop_iter_v                ( mws_st_loop_iter_v             ), //input
    .cfg_loop_iter                  ( mws_st_loop_iter               ), //input
    .cfg_loop_iter_loop_id          ( mws_st_loop_iter_loop_id       ), //input
    .start                          ( mws_st_start                   ), //input
    .done                           ( mws_st_done                    ), //output
    .loop_init                      ( mws_st_init                    ), //output
    .loop_last_iter                 (                                ), //output
    .loop_enter                     ( mws_st_enter                   ), //output
    .loop_exit                      ( mws_st_exit                    ), //output
    .loop_index                     ( mws_st_index                   ), //output
    .loop_index_valid               ( mws_st_index_valid             )  //output
  );
//=============================================================

//==============================================================================
// Memory Request generation
//==============================================================================
    assign ld_mem_req_v = cfg_mem_req_v && cfg_mem_req_loop_id == (1 + MEM_ID) && cfg_mem_req_type == MEM_LD && cfg_mem_req_id == MEM_ID;
  always @(posedge clk)
  begin
    if (reset) begin
      ld_req_size <= 'b0;
    end
    else if (ld_mem_req_v) begin
      ld_req_size <= cfg_mem_req_size;
    end
  end

    assign st_mem_req_v = cfg_mem_req_v && cfg_mem_req_loop_id == (1 + MEM_ID) && cfg_mem_req_type == MEM_ST && cfg_mem_req_id == MEM_ID;
  always @(posedge clk)
  begin
    if (reset) begin
      st_req_size <= 'b0;
      st_req_loop_id <= 'b0;
    end
    else if (st_mem_req_v) begin
      st_req_size <= cfg_mem_req_size;
      st_req_loop_id <= st_loop_id_counter;
    end
  end

  // assign ld_req_valid_d = (ld_req_loop_id == mws_ld_index) && (mws_ld_enter || mws_ld_step);
    // assign ld_req_valid_d = (ld_req_loop_id == mws_ld_index) && ld_addr_v;
    assign ld_req_valid_d = ld_addr_v;
  // assign st_req_valid_d = STORE_ENABLED == 1 && (st_req_loop_id == mws_st_index) && (mws_st_step  || mws_st_exit);
    assign st_req_valid_d = STORE_ENABLED == 1 && (st_req_loop_id == mws_st_index) && st_addr_v;

  always @(posedge clk)
  begin
    if (reset) begin
      ld_req_valid_q <= 1'b0;
      ld_req_addr <= 'b0;
      st_req_valid_q <= 1'b0;
      st_req_addr <= 1'b0;
    end
    else begin
      ld_req_valid_q <= ld_req_valid_d;
      ld_req_addr <= ld_addr;
      st_req_valid_q <= st_req_valid_d;
      st_req_addr <= st_addr;
    end
  end


reg [ ADDR_WIDTH           -1 : 0 ]        tag_base_ld_addr_s;
reg [ ADDR_WIDTH           -1 : 0 ]        tag_base_st_addr_s;
  always @(posedge clk)
  begin
    if (obuf_ld_addr_v) begin
      tag_base_ld_addr_s <= tag_base_ld_addr;
    end
  end
  always @(posedge clk)
  begin
    if (obuf_st_addr_v) begin
      tag_base_st_addr_s <= tag_base_st_addr;
    end
  end
  always @(posedge clk)
  begin
    if (tag_req && tag_ready && ~tag_reuse) begin
      tag_ld_addr[tag] <= tag_base_ld_addr_s;
      tag_st_addr[tag] <= tag_base_st_addr_s;
    end
  end

  // wire [ 31                      : 0 ]        tag0_ld_addr;
  // wire [ 31                      : 0 ]        tag1_ld_addr;
  // wire [ 31                      : 0 ]        tag0_st_addr;
  // wire [ 31                      : 0 ]        tag1_st_addr;
  // assign tag0_ld_addr = tag_ld_addr[0];
  // assign tag1_ld_addr = tag_ld_addr[1];
  // assign tag0_st_addr = tag_st_addr[0];
  // assign tag1_st_addr = tag_st_addr[1];
//==============================================================================

//==============================================================================
// Tag-based synchronization for double buffering
//==============================================================================
    reg                                         raw;
    reg  [ TAG_W                -1 : 0 ]        raw_stmem_tag_d;
    reg  [ TAG_W                -1 : 0 ]        raw_stmem_tag_q;
    wire [ TAG_W                -1 : 0 ]        raw_stmem_tag;
    wire                                        raw_stmem_tag_ready;
    wire [ ADDR_WIDTH           -1 : 0 ]        raw_stmem_st_addr;

  always @(posedge clk)
  begin
    if (reset)
      raw_stmem_tag_q <= 0;
    else
      raw_stmem_tag_q <= raw_stmem_tag_d;
  end

    assign raw_stmem_tag = raw_stmem_tag_q;
    assign raw_stmem_st_addr = tag_st_addr[raw_stmem_tag];

    assign stmem_state = stmem_state_q;
  always @(*)
  begin
    ldmem_state_d = ldmem_state_q;
    raw_stmem_tag_d = raw_stmem_tag_q;
    case(ldmem_state_q)
      LDMEM_IDLE: begin
        if (ldmem_tag_ready && wrapperldstate == 4'b0100) begin
          if (ldmem_tag == stmem_tag)
            ldmem_state_d = LDMEM_BUSY;
          else begin
            ldmem_state_d = LDMEM_CHECK_RAW;
            raw_stmem_tag_d = stmem_tag;
          end
        end
      end
      LDMEM_CHECK_RAW: begin
        if (raw_stmem_st_addr != mws_ld_base_addr && stmem_state_q==STMEM_IDLE)/////////////
          ldmem_state_d = LDMEM_BUSY;
        else if (stmem_state_q == STMEM_DONE)
          ldmem_state_d = LDMEM_IDLE;
      end
      LDMEM_BUSY: begin
        if (mws_ld_done)
          ldmem_state_d = LDMEM_WAIT_0;
        else if(noneed)
              ldmem_state_d = LDMEM_DONE;
      end
      LDMEM_WAIT_0: begin
        ldmem_state_d = LDMEM_WAIT_1;
      end
      LDMEM_WAIT_1: begin
        ldmem_state_d = LDMEM_WAIT_2;
      end
      LDMEM_WAIT_2: begin
        ldmem_state_d = LDMEM_WAIT_3;
      end
      LDMEM_WAIT_3: begin
        if (axi_rd_done || noneed)
          ldmem_state_d = LDMEM_DONE;
      end
      LDMEM_DONE: begin
        ldmem_state_d = LDMEM_IDLE;
      end
    endcase
  end

  always @(posedge clk)
  begin
    if (reset)
      ldmem_state_q <= LDMEM_IDLE;
    else
      ldmem_state_q <= ldmem_state_d;
  end

    reg                                         pu_start_d;
    reg                                         pu_start_q;
    assign pu_compute_start = pu_start_q;

  always @(posedge clk)
  begin
    if (reset)
      pu_start_q <= 1'b0;
    else
      pu_start_q <= pu_start_d;
  end

    localparam integer  WAIT_CYCLE_WIDTH             = $clog2(ARRAY_N) > 5 ? $clog2(ARRAY_N) : 5;
    reg  [ WAIT_CYCLE_WIDTH        : 0 ]        wait_cycles_d;
    reg  [ WAIT_CYCLE_WIDTH        : 0 ]        wait_cycles_q;

  always @(posedge clk)
  begin
    if (reset)
      wait_cycles_q <= 0;
    else
      wait_cycles_q <= wait_cycles_d;
  end

  always @(*)
  begin
    stmem_state_d = stmem_state_q;
    pu_start_d = 1'b0;
    wait_cycles_d = wait_cycles_q;
    case(stmem_state_q)
      STMEM_IDLE: begin
        if (stmem_tag_ready&&~ldmem_tag_ready&& (wrapperldstate_dly2!=4'b0001&&wrapperldstate_dly2!=4'b0010&&wrapperldstate_dly2!=4'b0011 )) begin
          stmem_state_d = STMEM_COMPUTE_WAIT;
          wait_cycles_d = ARRAY_N;
        end
      end
      STMEM_COMPUTE_WAIT: begin
        if (wait_cycles_q == 0) begin
//         if(permit)
//          begin
          if (~stmem_ddr_pe_sw)//////////////////
            stmem_state_d = STMEM_DDR;
          else if (pu_compute_ready &&((ldmem_state_q==LDMEM_IDLE)||(ldmem_state_q==LDMEM_CHECK_RAW))&&(wrapperldstate == 4'b0101||wrapperldstate == 4'b0100)) begin////////////////////////////////////
            stmem_state_d = STMEM_PU;
            pu_start_d = 1'b1;
            wait_cycles_d = ARRAY_N + 1'b1;
          end
//          end
        end
        else
          wait_cycles_d = wait_cycles_q - 1'b1;
      end
      STMEM_PU: begin
        if (pu_compute_done)
          stmem_state_d = STMEM_DONE;
      end
      STMEM_DDR: begin
        if (mws_st_done) begin
          stmem_state_d = STMEM_DDR_WAIT;
          wait_cycles_d = 4;
        end
      end
      STMEM_DDR_WAIT: begin
        if (wait_cycles_q == 0) begin
          if (axi_wr_done) begin
            stmem_state_d = STMEM_DONE;
            wait_cycles_d = 0;
          end
        end else
          wait_cycles_d = wait_cycles_q - 1'b1;
      end
      STMEM_DONE: begin
        stmem_state_d = STMEM_IDLE;
      end
    endcase
  end

  always @(posedge clk)
  begin
    if (reset)
      stmem_state_q <= STMEM_IDLE;
    else
      stmem_state_q <= stmem_state_d;
  end


    wire                                        ldmem_ready;

    assign compute_tag_done = compute_done;
    assign compute_ready = compute_tag_ready;

    assign ldmem_tag_done = ldmem_state_q == LDMEM_DONE;
    assign ldmem_ready = ldmem_tag_ready;
  // assign ldmem_tag_done = mws_ld_done;

    assign stmem_tag_done = stmem_state_q == STMEM_DONE;

  tag_sync  #(
    .NUM_TAGS                       ( NUM_TAGS                       )
  )
  mws_tag (
    .clk                            ( clk                            ),
    .reset                          ( reset                          ),
    .block_done                     ( block_done                     ),
    .tag_req                        ( tag_req                        ),
    .tag_reuse                      ( tag_reuse                      ),
    .tag_bias_prev_sw               ( tag_bias_prev_sw               ),
    .tag_ddr_pe_sw                  ( tag_ddr_pe_sw                  ), //input
    .tag_ready                      ( tag_ready                      ),
    .tag                            ( tag                            ),
    .tag_done                       ( tag_done                       ),
    .raw_stmem_tag                  ( raw_stmem_tag_q                ),
    .raw_stmem_tag_ready            ( raw_stmem_tag_ready            ),
    .compute_tag_done               ( compute_tag_done               ),
    .compute_tag_ready              ( compute_tag_ready              ),
    .compute_bias_prev_sw           ( compute_bias_prev_sw           ),
    .compute_tag                    ( compute_tag                    ),
    .ldmem_tag_done                 ( ldmem_tag_done                 ),
    .ldmem_tag_ready                ( ldmem_tag_ready                ),
    .ldmem_tag                      ( ldmem_tag                      ),
    .stmem_ddr_pe_sw                ( stmem_ddr_pe_sw                ),
    .stmem_tag_done                 ( stmem_tag_done                 ),
    .stmem_tag_ready                ( stmem_tag_ready                ),
    .stmem_tag                      ( stmem_tag                      )
  );
//==============================================================================

//==============================================================================
// AXI4 Memory Mapped interface
//==============================================================================
    assign mem_write_ready = 1'b1;
    assign mem_read_ready = 1'b1;
    assign axi_rd_req_id = 0;
  axi_master #(
    .TX_SIZE_WIDTH                  ( MEM_REQ_W                      ),
    .AXI_DATA_WIDTH                 ( AXI_DATA_WIDTH                 ),
    .AXI_ADDR_WIDTH                 ( AXI_ADDR_WIDTH                 ),
    .AXI_BURST_WIDTH                ( AXI_BURST_WIDTH                ),
    .AXISTATE                ( 4               ),
    .AXISTATEELSE                ( 5               )
  ) u_axi_mm_master (
    .clk                            ( clk                            ),
    .reset                          ( reset                          ),
    .m_axi_awaddr                   ( mws_awaddr                     ),
    .m_axi_awlen                    ( mws_awlen                      ),
    .m_axi_awsize                   ( mws_awsize                     ),
    .m_axi_awburst                  ( mws_awburst                    ),
    .m_axi_awvalid                  ( mws_awvalid                    ),
    .m_axi_awready                  ( mws_awready                    ),
    .m_axi_wdata                    ( mws_wdata                      ),
    .m_axi_wstrb                    ( mws_wstrb                      ),
    .m_axi_wlast                    ( mws_wlast                      ),
    .m_axi_wvalid                   ( mws_wvalid                     ),
    .m_axi_wready                   ( mws_wready                     ),
    .m_axi_bresp                    ( mws_bresp                      ),
    .m_axi_bvalid                   ( mws_bvalid                     ),
    .m_axi_bready                   ( mws_bready                     ),
    .m_axi_araddr                   ( mws_araddr                     ),
    .m_axi_arid                     ( mws_arid                       ),
    .m_axi_arlen                    ( mws_arlen                      ),
    .m_axi_arsize                   ( mws_arsize                     ),
    .m_axi_arburst                  ( mws_arburst                    ),
    .m_axi_arvalid                  ( mws_arvalid                    ),
    .m_axi_arready                  ( mws_arready                    ),
    .m_axi_rdata                    ( mws_rdata                      ),
    .m_axi_rid                      ( mws_rid                        ),
    .m_axi_rresp                    ( mws_rresp                      ),
    .m_axi_rlast                    ( mws_rlast                      ),
    .m_axi_rvalid                   ( mws_rvalid                     ),
    .m_axi_rready                   ( mws_rready                     ),
    // Buffer
    .mem_write_id                   ( mem_write_id                   ),
    .mem_write_req                  ( mem_write_req                  ),
    .mem_write_data                 ( mem_write_data                 ),
    .mem_write_ready                ( mem_write_ready                ),
    .mem_read_data                  ( mem_read_data                  ),
    .mem_read_req                   ( axi_mem_read_req               ),
    .mem_read_ready                 ( axi_mem_read_ready             ),
    // AXI RD Req
    .rd_req                         ( axi_rd_req     && (noneed==0)                ),
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
//==============================================================================

//==============================================================================
// Dual-port RAM
//==============================================================================
  always @(posedge clk)
  begin
    if (reset)
      axi_mem_read_addr <= 0;
    else begin
      if (mem_read_req)
        axi_mem_read_addr <= axi_mem_read_addr + 1'b1;
      else if (stmem_state_q == STMEM_DONE)
        axi_mem_read_addr <= 0;
    end
  end

    assign mem_read_addr = stmem_state_q == STMEM_PU ? pu_buf_read_addr : axi_mem_read_addr;
    assign mem_read_req = stmem_state_q == STMEM_PU ? pu_buf_read_req : axi_mem_read_req;
    assign axi_mem_read_ready = stmem_state_q != STMEM_PU;
    assign pu_buf_read_ready = stmem_state_q == STMEM_PU;

  always @(posedge clk)
  begin
    if (reset)
      mem_write_addr <= 0;
    else begin
      if (mem_write_req)
        mem_write_addr <= mem_write_addr + 1'b1;
      else if (ldmem_state_q == LDMEM_DONE)
        mem_write_addr <= 0;
    end
  end

    wire [ TAG_MEM_ADDR_W       -1 : 0 ]        tag_mem_read_addr;
    wire [ TAG_MEM_ADDR_W       -1 : 0 ]        tag_mem_write_addr;

    wire [ TAG_BUF_ADDR_W       -1 : 0 ]        tag_buf_read_addr;
    wire [ TAG_BUF_ADDR_W       -1 : 0 ]        tag_buf_write_addr;

    assign tag_mem_read_addr = {stmem_tag, mem_read_addr};
    assign tag_mem_write_addr = {ldmem_tag, mem_write_addr};

  genvar i;
  generate
    if (MEM_ID == 1 || MEM_ID == 3)
    begin: OBUF_TAG_DELAY
      for (i=0; i<ARRAY_N+3; i=i+1)
      begin: TAG_DELAY_LOOP
        wire [TAG_W-1:0] prev_tag, next_tag;
        if (i==0)
    assign prev_tag = compute_tag;
        else
    assign prev_tag = OBUF_TAG_DELAY.TAG_DELAY_LOOP[i-1].next_tag;
        register_sync #(TAG_W) tag_delay (clk, reset, prev_tag, next_tag);
      end
      // Increased compute tag delays
      // Might need a separate compute_tag_delayed for buf_read
    assign compute_tag_delayed = OBUF_TAG_DELAY.TAG_DELAY_LOOP[ARRAY_N+2].next_tag;
    end
    else begin
    assign compute_tag_delayed = compute_tag;
    end
  endgenerate

    assign tag_buf_read_addr = {compute_tag_delayed, buf_read_addr};
    assign tag_buf_write_addr = {compute_tag_delayed, buf_write_addr};

  register_sync #(BUF_DATA_WIDTH)
  buf_read_data_delay (clk, reset, _buf_read_data, buf_read_data);

  obuf #(
    .TAG_W                          ( TAG_W                          ),
    .BUF_ADDR_WIDTH                 ( TAG_BUF_ADDR_W                 ),
    .ARRAY_M                        ( ARRAY_M                        ),
    .MEM_DATA_WIDTH                 ( AXI_DATA_WIDTH                 ),
    .DATA_WIDTH                     ( DATA_WIDTH                     )
  ) buf_ram (
    .clk                            ( clk                            ),
    .reset                          ( reset                          ),
    .mem_write_addr                 ( tag_mem_write_addr             ),
    .mem_write_req                  ( mem_write_req                  ),
    .mem_write_data                 ( mem_write_data                 ),
    .mem_read_addr                  ( tag_mem_read_addr              ),
    .mem_read_req                   ( mem_read_req                   ),
    .mem_read_data                  ( mem_read_data                  ),
    .buf_write_addr                 ( tag_buf_write_addr             ),
    .buf_write_req                  ( buf_write_req                  ),
    .buf_write_data                 ( buf_write_data                 ),
    .buf_read_addr                  ( tag_buf_read_addr              ),
    .buf_read_req                   ( buf_read_req                   ),
    .buf_read_data                  ( _buf_read_data                 )
  );
//==============================================================================

//==============================================================================
`ifdef COCOTB_SIM
  integer wr_req_count=0;
  integer rd_req_count=0;
  integer missed_rd_req_count=0;
  integer req_count;

  always @(posedge clk)
    if (reset)
      wr_req_count <= 0;
    else
      wr_req_count <= wr_req_count + axi_wr_req;

  always @(posedge clk)
    if (reset)
      rd_req_count <= 0;
    else
      rd_req_count <= rd_req_count + axi_rd_req;

  always @(posedge clk)
    if (reset)
      missed_rd_req_count <= 0;
    else
      missed_rd_req_count <= missed_rd_req_count + (axi_rd_req && ~axi_rd_ready);

  always @(posedge clk)
  begin
    if (reset) req_count <= 0;
    else req_count = req_count + (tag_req && tag_ready);
  end
`endif
//==============================================================================

//=============================================================
// VCD
//=============================================================
`ifdef COCOTB_TOPLEVEL_mem_wrapper
initial begin
  $dumpfile("mem_wrapper.vcd");
  $dumpvars(0, mem_wrapper);
end
`endif
//=============================================================
endmodule
