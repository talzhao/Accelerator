`timescale 1ns/1ps
module wrapper #(
  // Internal Parameters
  parameter integer  BASE_ID                      = 1,
  parameter integer  IBUF_MEM_ID                  = 0,
  parameter integer  OBUF_MEM_ID                  = 1,
  parameter integer  WBUF_MEM_ID                  = 2,
  parameter integer  BBUF_MEM_ID                  = 3,

  parameter integer  MEM_REQ_W                    = 16,
  parameter integer  LOOP_ITER_W                  = 16,
  parameter integer  ADDR_STRIDE_W                = 32,
  parameter integer  LOOP_ID_W                    = 5,
  parameter integer  BUF_TYPE_W                   = 2,
    parameter integer  IMEM_ADDR_W                  = 10,
    parameter integer  DDR_ADDR_W                   = 32,
  // Internal
    parameter integer  INST_W                       = 32,
  
    parameter integer  IMM_WIDTH                    = 16,
    parameter integer  OP_CODE_W                    = 4,
    parameter integer  OP_SPEC_W                    = 7,
    parameter integer  INST_ADDR_W                  = 5,
    parameter integer  IFIFO_ADDR_W                 = 10,

    parameter integer  INST_ADDR_WIDTH              = 32,
    parameter integer  INST_DATA_WIDTH              = 32,
    parameter integer  INST_WSTRB_WIDTH             = INST_DATA_WIDTH / 8,
    parameter integer  INST_BURST_WIDTH             = 8,
    parameter integer  NUM_TAGS                     = 2,
    parameter integer  TAG_W                        = $clog2(NUM_TAGS),



  // Systolic Array
    parameter integer  ARRAY_N                      = 16,
    parameter integer  ARRAY_M                      = 16,

  // Precision
    parameter integer  DATA_WIDTH                   = 16,
    parameter integer  WEIGHT_WIDTH                   = 8,
    parameter integer  BIAS_WIDTH                   = 16,
    parameter integer  ACC_WIDTH                    = 16,


    parameter integer  IBUF_CAPACITY_BITS           = ARRAY_N * DATA_WIDTH * 800 / NUM_TAGS,
    parameter integer  WBUF_CAPACITY_BITS           = ARRAY_N * ARRAY_M * WEIGHT_WIDTH * 290 / NUM_TAGS,
    parameter integer  OBUF_CAPACITY_BITS           = ARRAY_M * ACC_WIDTH * 256 / NUM_TAGS,
    parameter integer  BBUF_CAPACITY_BITS           = ARRAY_M * BIAS_WIDTH * 90 / NUM_TAGS,

  // Buffer Addr Width
    parameter integer  IBUF_ADDR_WIDTH              = $clog2(IBUF_CAPACITY_BITS / ARRAY_N / DATA_WIDTH),
    parameter integer  WBUF_ADDR_WIDTH              = $clog2(WBUF_CAPACITY_BITS / ARRAY_N / ARRAY_M / WEIGHT_WIDTH),
    parameter integer  OBUF_ADDR_WIDTH              = $clog2(OBUF_CAPACITY_BITS / ARRAY_M / ACC_WIDTH),
    parameter integer  BBUF_ADDR_WIDTH              = $clog2(BBUF_CAPACITY_BITS / ARRAY_M / BIAS_WIDTH),

    parameter integer  CTRL_ADDR_WIDTH              = 32,
    parameter integer  CTRL_DATA_WIDTH              = 32,
    parameter integer  CTRL_WSTRB_WIDTH             = CTRL_DATA_WIDTH/8,

  // AXI DATA
    parameter integer  AXI_ADDR_WIDTH               = 32,
   parameter integer  ADDR_WIDTH               = 32,
    parameter integer  AXI_BURST_WIDTH              = 8,
    parameter integer  IBUF_AXI_DATA_WIDTH          = 256,
    parameter integer  IBUF_WSTRB_W                 = IBUF_AXI_DATA_WIDTH/8,
    parameter integer  OBUF_AXI_DATA_WIDTH          = 256,
    parameter integer  OBUF_WSTRB_W                 = OBUF_AXI_DATA_WIDTH/8,
    parameter integer  PU_AXI_DATA_WIDTH            = 256,
    parameter integer  PU_WSTRB_W                   = PU_AXI_DATA_WIDTH/8,
    parameter integer  WBUF_AXI_DATA_WIDTH          = 256,
    parameter integer  WBUF_WSTRB_W                 = WBUF_AXI_DATA_WIDTH/8,
    parameter integer  BBUF_AXI_DATA_WIDTH          = 256,
    parameter integer  BBUF_WSTRB_W                 = BBUF_AXI_DATA_WIDTH/8,
    parameter integer  AXI_ID_WIDTH                 = 1,
    parameter          DTYPE                        = "FXP", // FXP for dnnweaver2, FP32 for single precision, FP16 for half-precision
    parameter integer  WBUF_DATA_WIDTH              = ARRAY_N * ARRAY_M * WEIGHT_WIDTH,
    parameter integer  BBUF_DATA_WIDTH              = ARRAY_M * BIAS_WIDTH,
    parameter integer  IBUF_DATA_WIDTH              = ARRAY_N * DATA_WIDTH,
    parameter integer  OBUF_DATA_WIDTH              = ARRAY_M * ACC_WIDTH,

		parameter integer C_S00_AXI_ID_WIDTH	= 1,
		parameter integer C_S00_AXI_DATA_WIDTH	= 256,
		parameter  integer C_S00_AXI_ADDR_WIDTH	= 32,
		parameter  integer C_S00_AXI_AWUSER_WIDTH	= 0,
		parameter integer  C_S00_AXI_ARUSER_WIDTH	= 0,
		parameter  integer C_S00_AXI_WUSER_WIDTH	= 0,
		parameter  integer C_S00_AXI_RUSER_WIDTH	= 0,
		parameter  integer C_S00_AXI_BUSER_WIDTH	= 0, 
   parameter integer  PU_OBUF_ADDR_WIDTH           = OBUF_ADDR_WIDTH + $clog2(OBUF_DATA_WIDTH / OBUF_AXI_DATA_WIDTH),
   parameter integer  WAIT_CYCLE_WIDTH             = $clog2(ARRAY_N) > 5 ? $clog2(ARRAY_N) : 5
) 
(
    input  wire                                         clk,
    input  wire                                         reset,
    output wire dnnweaver2_done,
   input wire decoder_start,


  // CL_wrapper -> DDR0 AXI4 interface


 output wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr_0,
 output wire [7 : 0] s00_axi_awlen_0,
 output wire [2 : 0] s00_axi_awsize_0,
 output wire [1 : 0] s00_axi_awburst_0,
 output wire  s00_axi_awvalid_0,
 input wire s00_axi_awready,
 output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata_0,
 output wire[(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb_0,
 output wire s00_axi_wlast_0,
 output wire  s00_axi_wvalid_0,
 input wire s00_axi_wready,

 input wire[1 : 0] s00_axi_bresp,

input wire s00_axi_bvalid,
 output wire  s00_axi_bready_0,
 output wire[C_S00_AXI_ID_WIDTH-1: 0] s00_axi_arid_0,
 output wire[C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr_0,
 output wire [7 : 0] s00_axi_arlen_0,
 output wire [2 : 0] s00_axi_arsize_0,
 output wire [1 : 0] s00_axi_arburst_0,

 output wire  s00_axi_arvalid_0,
 input wire  s00_axi_arready,
 input wire[C_S00_AXI_ID_WIDTH-1 : 0] s00_axi_rid,
 input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
 input wire[1 : 0] s00_axi_rresp,
 input wire  s00_axi_rlast,

 input wire s00_axi_rvalid,
 output wire  s00_axi_rready_0,
 output   reg  [ 4                    -1 : 0 ]        ld_state_q
 // input wire  [ INST_W               -1 : 0 ] inst_read_data

/*
 output wire[C_S00_AXI_ID_WIDTH-1 : 0] s00_axi_awid,
 output wire[C_S00_AXI_ID_WIDTH-1: 0] s00_axi_bid,
output wire [C_S00_AXI_RUSER_WIDTH-1 : 0] s00_axi_ruser;
output wire [C_S00_AXI_WUSER_WIDTH-1 : 0] s00_axi_wuser;
output wire [C_S00_AXI_BUSER_WIDTH-1 : 0] s00_axi_buser;
output wire [1 : 0] s00_axi_arlock;
output wire [3 : 0] s00_axi_arcache;
output wire [2 : 0] s00_axi_arprot;
 output wire [3 : 0] s00_axi_arqos;
output wire [3 : 0] s00_axi_arregion;
output wire [C_S00_AXI_ARUSER_WIDTH-1 : 0] s00_axi_aruser;
output wire [1 : 0] s00_axi_awlock;
output wire [3 : 0] s00_axi_awcache;
output wire [2 : 0] s00_axi_awprot;
output wire [3 : 0] s00_axi_awqos;
output wire [3 : 0] s00_axi_awregion;
output wire[C_S00_AXI_AWUSER_WIDTH-1 : 0] s00_axi_awuser;*/
);

  // CL_wrapper -> DDR0 AXI4 interface

reg if_start;



 reg [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr;
reg [7 : 0] s00_axi_awlen;
reg [2 : 0] s00_axi_awsize;
reg [1 : 0] s00_axi_awburst;
 reg  s00_axi_awvalid;

reg [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata;
 reg[(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb;
reg s00_axi_wlast;
  reg  s00_axi_wvalid;

reg  s00_axi_bready;
 reg[C_S00_AXI_ID_WIDTH-1: 0] s00_axi_arid;
 reg[C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr;
reg [7 : 0] s00_axi_arlen;
reg [2 : 0] s00_axi_arsize;
 reg [1 : 0] s00_axi_arburst;

 reg  s00_axi_arvalid;


 reg  s00_axi_rready;


  reg                                         start;
  wire                                         done;

  wire                                         tag_req;
 wire                                       tag_ready;
 wire tag_ready_d;
  
  // Programming
  wire                                        cfg_loop_iter_v;
  wire [ LOOP_ITER_W          -1 : 0 ]        cfg_loop_iter;
  wire [ LOOP_ID_W            -1 : 0 ]        cfg_loop_iter_loop_id;

  // Programming
  wire                                        cfg_loop_stride_v;
  wire  [ ADDR_STRIDE_W        -1 : 0 ]        cfg_loop_stride;
  wire  [ LOOP_ID_W            -1 : 0 ]        cfg_loop_stride_loop_id;
  wire  [ BUF_TYPE_W           -1 : 0 ]        cfg_loop_stride_id;
  wire [ 2                    -1 : 0 ]        cfg_loop_stride_type;


  // Address - OBUF
    wire [ ADDR_WIDTH           -1 : 0 ]        obuf_base_addr;
    wire [ ADDR_WIDTH           -1 : 0 ]        obuf_ld_addr;
    wire                                        obuf_ld_addr_v;
    wire [ ADDR_WIDTH           -1 : 0 ]        obuf_st_addr;
    wire                                        obuf_st_addr_v;
  // Address - IBUF
    wire [ ADDR_WIDTH           -1 : 0 ]        ibuf_base_addr;
    wire [ ADDR_WIDTH           -1 : 0 ]        ibuf_ld_addr;
    wire                                        ibuf_ld_addr_v;
  // Address - WBUF
    wire [ ADDR_WIDTH           -1 : 0 ]        wbuf_base_addr;
    wire [ ADDR_WIDTH           -1 : 0 ]        wbuf_ld_addr;
    wire                                        wbuf_ld_addr_v;
    wire [ ADDR_WIDTH           -1 : 0 ]        wbuf_st_addr;
    wire                                        wbuf_st_addr_v;
  // Address - BIAS
    wire [ ADDR_WIDTH           -1 : 0 ]        bias_base_addr;
    wire [ ADDR_WIDTH           -1 : 0 ]        bias_ld_addr;
    wire                                        bias_ld_addr_v;
    wire [ ADDR_WIDTH           -1 : 0 ]        bias_st_addr;
    wire                                        bias_st_addr_v;


  wire                                         bias_prev_sw;
  wire                                         ddr_pe_sw;
  reg block_done;
  //reg decoder_start;

 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        cl_ddr0_awaddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        cl_ddr0_awlen;
 wire  [ 3                    -1 : 0 ]        cl_ddr0_awsize;
 wire  [ 2                    -1 : 0 ]        cl_ddr0_awburst;
 wire                                         cl_ddr0_awvalid;
reg                                        cl_ddr0_awready;

  // Master Interface Write Data
wire  [ IBUF_AXI_DATA_WIDTH  -1 : 0 ]        cl_ddr0_wdata;
wire  [ IBUF_WSTRB_W         -1 : 0 ]        cl_ddr0_wstrb;
 wire                                         cl_ddr0_wlast;
 wire                                         cl_ddr0_wvalid;
reg                                        cl_ddr0_wready;
  // Master Interface Write Response
reg  [ 2                    -1 : 0 ]        cl_ddr0_bresp;
reg                                         cl_ddr0_bvalid;
 wire                                         cl_ddr0_bready;
  // Master Interface Read Address
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        cl_ddr0_araddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        cl_ddr0_arlen;
wire  [ 3                    -1 : 0 ]        cl_ddr0_arsize;
wire  [ 2                    -1 : 0 ]        cl_ddr0_arburst;
 wire                                         cl_ddr0_arvalid;
 wire  [ AXI_ID_WIDTH         -1 : 0 ]        cl_ddr0_arid;
reg                                        cl_ddr0_arready;
  // Master Interface Read Data
reg  [ IBUF_AXI_DATA_WIDTH  -1 : 0 ]        cl_ddr0_rdata;
reg  [ AXI_ID_WIDTH         -1 : 0 ]        cl_ddr0_rid;
reg  [ 2                    -1 : 0 ]        cl_ddr0_rresp;
reg                                         cl_ddr0_rlast;
 reg                                         cl_ddr0_rvalid;
 wire                                         cl_ddr0_rready;
////////////////////////////////////////////////////////////////////////////////////////////////ddr2
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        cl_ddr2_awaddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        cl_ddr2_awlen;
 wire  [ 3                    -1 : 0 ]        cl_ddr2_awsize;
 wire  [ 2                    -1 : 0 ]        cl_ddr2_awburst;
 wire                                         cl_ddr2_awvalid;
reg                                        cl_ddr2_awready;
  // Master Interface Write Data
wire  [ WBUF_AXI_DATA_WIDTH  -1 : 0 ]        cl_ddr2_wdata;
wire  [ WBUF_WSTRB_W         -1 : 0 ]        cl_ddr2_wstrb;
 wire                                         cl_ddr2_wlast;
 wire                                         cl_ddr2_wvalid;
reg                                        cl_ddr2_wready;
  // Master Interface Write Response
reg  [ 2                    -1 : 0 ]        cl_ddr2_bresp;
reg                                         cl_ddr2_bvalid;
 wire                                         cl_ddr2_bready;
  // Master Interface Read Address
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        cl_ddr2_araddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        cl_ddr2_arlen;
wire  [ 3                    -1 : 0 ]        cl_ddr2_arsize;
wire  [ 2                    -1 : 0 ]        cl_ddr2_arburst;
 wire                                         cl_ddr2_arvalid;
 wire  [ AXI_ID_WIDTH         -1 : 0 ]        cl_ddr2_arid;
reg                                        cl_ddr2_arready;
  // Master Interface Read Data
reg  [ WBUF_AXI_DATA_WIDTH  -1 : 0 ]        cl_ddr2_rdata;
reg  [ AXI_ID_WIDTH         -1 : 0 ]        cl_ddr2_rid;
reg  [ 2                    -1 : 0 ]        cl_ddr2_rresp;
reg                                         cl_ddr2_rlast;
 reg                                         cl_ddr2_rvalid;
 wire                                         cl_ddr2_rready;

////////////////////////////////////////////////////////////////////////////////////////////////ddr3
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        cl_ddr3_awaddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        cl_ddr3_awlen;
 wire  [ 3                    -1 : 0 ]        cl_ddr3_awsize;
 wire  [ 2                    -1 : 0 ]        cl_ddr3_awburst;
 wire                                         cl_ddr3_awvalid;
reg                                        cl_ddr3_awready;
  // Master Interface Write Data
wire  [ BBUF_AXI_DATA_WIDTH  -1 : 0 ]        cl_ddr3_wdata;
wire  [ BBUF_WSTRB_W         -1 : 0 ]        cl_ddr3_wstrb;
 wire                                         cl_ddr3_wlast;
 wire                                         cl_ddr3_wvalid;
reg                                        cl_ddr3_wready;
  // Master Interface Write Response
reg  [ 2                    -1 : 0 ]        cl_ddr3_bresp;
reg                                         cl_ddr3_bvalid;
 wire                                         cl_ddr3_bready;
  // Master Interface Read Address
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        cl_ddr3_araddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        cl_ddr3_arlen;
wire  [ 3                    -1 : 0 ]        cl_ddr3_arsize;
wire  [ 2                    -1 : 0 ]        cl_ddr3_arburst;
 wire                                         cl_ddr3_arvalid;
 wire  [ AXI_ID_WIDTH         -1 : 0 ]        cl_ddr3_arid;
reg                                        cl_ddr3_arready;
  // Master Interface Read Data
reg  [ BBUF_AXI_DATA_WIDTH  -1 : 0 ]        cl_ddr3_rdata;
reg  [ AXI_ID_WIDTH         -1 : 0 ]        cl_ddr3_rid;
reg  [ 2                    -1 : 0 ]        cl_ddr3_rresp;
reg                                         cl_ddr3_rlast;
 reg                                         cl_ddr3_rvalid;
 wire                                         cl_ddr3_rready;


////////////////////////////////////////////////////////////////////////////////////////////////ddr1
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        cl_ddr1_awaddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        cl_ddr1_awlen;
 wire  [ 3                    -1 : 0 ]        cl_ddr1_awsize;
 wire  [ 2                    -1 : 0 ]        cl_ddr1_awburst;
 wire                                         cl_ddr1_awvalid;
reg                                        cl_ddr1_awready;
  // Master Interface Write Data
wire  [ OBUF_AXI_DATA_WIDTH  -1 : 0 ]        cl_ddr1_wdata;
wire  [ OBUF_WSTRB_W         -1 : 0 ]        cl_ddr1_wstrb;
 wire                                         cl_ddr1_wlast;
 wire                                         cl_ddr1_wvalid;
reg                                        cl_ddr1_wready;
  // Master Interface Write Response
reg  [ 2                    -1 : 0 ]        cl_ddr1_bresp;
reg                                         cl_ddr1_bvalid;
 wire                                         cl_ddr1_bready;
  // Master Interface Read Address
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        cl_ddr1_araddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        cl_ddr1_arlen;
wire  [ 3                    -1 : 0 ]        cl_ddr1_arsize;
wire  [ 2                    -1 : 0 ]        cl_ddr1_arburst;
 wire                                         cl_ddr1_arvalid;
 wire  [ AXI_ID_WIDTH         -1 : 0 ]        cl_ddr1_arid;
reg                                        cl_ddr1_arready;
  // Master Interface Read Data
reg  [ OBUF_AXI_DATA_WIDTH  -1 : 0 ]        cl_ddr1_rdata;
reg  [ AXI_ID_WIDTH         -1 : 0 ]        cl_ddr1_rid;
reg  [ 2                    -1 : 0 ]        cl_ddr1_rresp;
reg                                         cl_ddr1_rlast;
 reg                                         cl_ddr1_rvalid;
 wire                                         cl_ddr1_rready;

////////////////////////////////////////////////////////////////////////////////////////////////ddr4
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        cl_ddr4_awaddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        cl_ddr4_awlen;
 wire  [ 3                    -1 : 0 ]        cl_ddr4_awsize;
 wire  [ 2                    -1 : 0 ]        cl_ddr4_awburst;
 wire                                         cl_ddr4_awvalid;
reg                                        cl_ddr4_awready;
  // Master Interface Write Data
wire  [ OBUF_AXI_DATA_WIDTH  -1 : 0 ]        cl_ddr4_wdata;
wire  [ OBUF_WSTRB_W         -1 : 0 ]        cl_ddr4_wstrb;
 wire                                         cl_ddr4_wlast;
 wire                                         cl_ddr4_wvalid;
reg                                        cl_ddr4_wready;
  // Master Interface Write Response
reg  [ 2                    -1 : 0 ]        cl_ddr4_bresp;
reg                                         cl_ddr4_bvalid;
 wire                                         cl_ddr4_bready;
  // Master Interface Read Address
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        cl_ddr4_araddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        cl_ddr4_arlen;
wire  [ 3                    -1 : 0 ]        cl_ddr4_arsize;
wire  [ 2                    -1 : 0 ]        cl_ddr4_arburst;
 wire                                         cl_ddr4_arvalid;
 wire  [ AXI_ID_WIDTH         -1 : 0 ]        cl_ddr4_arid;
reg                                        cl_ddr4_arready;
  // Master Interface Read Data
reg  [ OBUF_AXI_DATA_WIDTH  -1 : 0 ]        cl_ddr4_rdata;
reg  [ AXI_ID_WIDTH         -1 : 0 ]        cl_ddr4_rid;
reg  [ 2                    -1 : 0 ]        cl_ddr4_rresp;
reg                                         cl_ddr4_rlast;
 reg                                         cl_ddr4_rvalid;
 wire                                         cl_ddr4_rready;
  // Memory request
    wire [ MEM_REQ_W            -1 : 0 ]        cfg_mem_req_size;
    wire                                        cfg_mem_req_v;
    wire [ 2                    -1 : 0 ]        cfg_mem_req_type;
    wire [ BUF_TYPE_W           -1 : 0 ]        cfg_mem_req_id;
    wire [ LOOP_ID_W            -1 : 0 ]        cfg_mem_req_loop_id;
    wire [ MEM_REQ_W            -1 : 0 ]        cfg_buf_req_size;
    wire                                        cfg_buf_req_v;
    wire         cfg_buf_req_type;
    wire [ BUF_TYPE_W            -1 : 0 ]        cfg_buf_req_loop_id;

    wire                                        ibuf_ld_done;
    wire                                        obuf_ld_start;
    wire                                        wbuf_ld_done;
    wire                                        bbuf_ld_done;
    wire                                        obuf_ld_done;
    wire                                        obuf_st_done;

    wire                                        ibuf_tag_ready;
    wire                                        ibuf_tag_done;
    wire                                        ibuf_compute_ready;

    wire                                        wbuf_tag_ready;
    wire                                        wbuf_tag_done;
    wire                                        wbuf_compute_ready;

    wire                                        obuf_tag_ready;
    wire                                        obuf_tag_done;
    wire                                        obuf_compute_ready;
    wire                                        obuf_bias_prev_sw;

    wire                                        bbuf_tag_ready;
    wire                                        bias_tag_done;
    wire                                        bias_compute_ready;

    wire                                        tag_flush;
    wire                                        ibuf_tag_reuse;
    wire                                        obuf_tag_reuse;
    wire                                        wbuf_tag_reuse;
    wire                                        bias_tag_reuse;
    wire                                        sync_tag_req;
 
 // Select logic for bias (0) or obuf_read_data (1)
    wire                                        compute_bias_prev_sw;
    wire                                        tag_bias_prev_sw;
    wire                                        tag_ddr_pe_sw;

    wire tag_bias_prev_sw_i;
    wire tag_bias_prev_sw_o;
    wire tag_bias_prev_sw_b;
    wire tag_bias_prev_sw_w;

    wire                                        tag_flush_b;
    wire                                        tag_flush_w;
    wire                                        tag_flush_o;

 // IBUF
    wire [ IBUF_DATA_WIDTH      -1 : 0 ]        ibuf_read_data;
    wire                                        ibuf_read_req;
    wire [ IBUF_ADDR_WIDTH      -1 : 0 ]        ibuf_read_addr;

  // WBUF
    wire [ WBUF_DATA_WIDTH      -1 : 0 ]        wbuf_read_data;
    wire                                        wbuf_read_req;
    wire [ WBUF_ADDR_WIDTH      -1 : 0 ]        wbuf_read_addr;

  // BIAS
    wire [ BBUF_DATA_WIDTH      -1 : 0 ]        bbuf_read_data;
    wire                                        bias_read_req;
    wire [ BBUF_ADDR_WIDTH      -1 : 0 ]        bias_read_addr;
    wire                                        sys_bias_read_req;
    wire [ BBUF_ADDR_WIDTH      -1 : 0 ]        sys_bias_read_addr;

  // OBUF
    wire [ OBUF_DATA_WIDTH      -1 : 0 ]        obuf_write_data;
    wire                                        obuf_write_req;
    wire [ OBUF_ADDR_WIDTH      -1 : 0 ]        obuf_write_addr;
    wire [ OBUF_DATA_WIDTH      -1 : 0 ]        obuf_read_data;
    wire                                        obuf_read_req;
    wire [ OBUF_ADDR_WIDTH      -1 : 0 ]        obuf_read_addr;

    wire                                        sys_obuf_write_req;
    wire [ OBUF_ADDR_WIDTH      -1 : 0 ]        sys_obuf_write_addr;

    wire                                        sys_obuf_read_req;
    wire [ OBUF_ADDR_WIDTH      -1 : 0 ]        sys_obuf_read_addr;
  // Systolic array
    wire                                        acc_clear;
    wire [ OBUF_DATA_WIDTH      -1 : 0 ]        sys_obuf_write_data;

    wire                                        compute_done;
    wire                                        compute_req;

    wire [ IBUF_ADDR_WIDTH      -1 : 0 ]        tie_ibuf_buf_base_addr;
    wire [ WBUF_ADDR_WIDTH      -1 : 0 ]        tie_wbuf_buf_base_addr;
    wire [ OBUF_ADDR_WIDTH      -1 : 0 ]        tie_obuf_buf_base_addr;
    wire [ BBUF_ADDR_WIDTH      -1 : 0 ]        tie_bias_buf_base_addr;

    wire                                        sys_array_c_sel;

    reg sync_tag_req_ldi;
    reg sync_tag_req_ldw;
    reg sync_tag_req_ldb;
    reg sync_tag_req_ldo;
    reg sync_tag_req_ldi_d;
    reg sync_tag_req_ldw_d;
    reg sync_tag_req_ldb_d;
    reg sync_tag_req_ldo_d;
 //  localparam integer  WAIT_CYCLE_WIDTH             = $clog2(ARRAY_N) > 5 ? $clog2(ARRAY_N) : 5;
   // wire obuf_st_done_d;
    register_sync #(1) tagreqi (clk, reset, sync_tag_req_ldi, sync_tag_req_ldi_d);
    register_sync #(1) tagreqw (clk, reset, sync_tag_req_ldw, sync_tag_req_ldw_d);
    register_sync #(1) tagreqo (clk, reset, sync_tag_req_ldo, sync_tag_req_ldo_d);
    register_sync #(1) tagreqb (clk, reset, sync_tag_req_ldb, sync_tag_req_ldb_d);
   // register_sync #(1) obufstdone (clk, reset, obuf_st_done, obuf_st_done_d);


    reg base_ctrl_tag_req;

  // PU
    wire                                        pu_compute_start;
    wire                                        pu_compute_start_d;
    wire                                        pu_compute_ready;
    wire                                        pu_compute_done;
    wire                                        pu_write_done;
    wire [ 3                    -1 : 0 ]        pu_ctrl_state;
    wire                                        pu_done;
    wire                                        pu_inst_wr_ready;
  // PU -> OBUF addr
    wire                                        ld_obuf_req;
    wire                                        ld_obuf_ready;
    wire [ PU_OBUF_ADDR_WIDTH   -1 : 0 ]        ld_obuf_addr;
  // OBUF -> PU addr
    wire                                        obuf_ld_stream_write_req;
    wire [ OBUF_AXI_DATA_WIDTH  -1 : 0 ]        obuf_ld_stream_write_data;


  // PU Instructions
    wire                                        cfg_pu_inst_v;
    wire [ INST_DATA_WIDTH      -1 : 0 ]        cfg_pu_inst;
    wire                                        pu_block_start;
    wire                                        pu_block_end;

wire [ OP_SPEC_W            -1 : 0 ]        cfg_systolic_precision;

//wire permit;
  // ST tie-offs
    assign wbuf_st_addr_v = 1'b0;
    assign wbuf_st_addr = 'b0;
    assign bias_st_addr_v = 1'b0;
    assign bias_st_addr = 'b0;
    assign acc_clear = compute_done;

  // Address tie-off
    assign tie_ibuf_buf_base_addr = {IBUF_ADDR_WIDTH{1'b0}};
    assign tie_wbuf_buf_base_addr = {WBUF_ADDR_WIDTH{1'b0}};
    assign tie_obuf_buf_base_addr = {OBUF_ADDR_WIDTH{1'b0}};
    assign tie_bias_buf_base_addr = {BBUF_ADDR_WIDTH{1'b0}};

    assign compute_req = ibuf_compute_ready && wbuf_compute_ready && obuf_compute_ready && bias_compute_ready;


  base_addr_gen #(
    .BASE_ID                        ( 0                              ),
    .MEM_REQ_W                      ( MEM_REQ_W                      ),
    .IBUF_ADDR_WIDTH                ( IBUF_ADDR_WIDTH                ),
    .WBUF_ADDR_WIDTH                ( WBUF_ADDR_WIDTH                ),
    .OBUF_ADDR_WIDTH                ( OBUF_ADDR_WIDTH                ),
    .BBUF_ADDR_WIDTH                ( BBUF_ADDR_WIDTH                ),
    .LOOP_ITER_W                    ( LOOP_ITER_W                    ),
    .LOOP_ID_W                      ( LOOP_ID_W                      ),
    .ADDR_STRIDE_W                  ( ADDR_STRIDE_W                  )     
  ) compute_ctrl (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input

    .start                          ( compute_req                    ), //input
    .done                           ( compute_done                   ), //output

    //TODO
    .tag_req                        (                                ), //output
    .tag_ready                      ( 1'b1                           ), //input

    .cfg_loop_iter_v                ( cfg_loop_iter_v                ), //input
    .cfg_loop_iter                  ( cfg_loop_iter                  ), //input
    .cfg_loop_iter_loop_id          ( cfg_loop_iter_loop_id          ), //input

    .cfg_loop_stride_v              ( cfg_loop_stride_v              ), //input
    .cfg_loop_stride                ( cfg_loop_stride             ), //input
    .cfg_loop_stride_loop_id        ( cfg_loop_stride_loop_id        ), //input
    .cfg_loop_stride_type           ( cfg_loop_stride_type           ), //input
    .cfg_loop_stride_id             ( cfg_loop_stride_id             ), //input

    .ibuf_base_addr                 ( tie_ibuf_buf_base_addr         ), //input
    .wbuf_base_addr                 ( tie_wbuf_buf_base_addr         ), //input
    .obuf_base_addr                 ( tie_obuf_buf_base_addr         ), //input
    .bias_base_addr                 ( tie_bias_buf_base_addr         ), //input

    .obuf_ld_addr                   ( obuf_read_addr                 ), //output
    .obuf_ld_addr_v                 ( obuf_read_req                  ), //output
    .obuf_st_addr                   ( obuf_write_addr                ), //output
    .obuf_st_addr_v                 ( obuf_write_req                 ), //output
    .ibuf_ld_addr                   ( ibuf_read_addr                 ), //output
    .ibuf_ld_addr_v                 ( ibuf_read_req                  ), //output
    .wbuf_ld_addr                   ( wbuf_read_addr                 ), //output
    .wbuf_ld_addr_v                 ( wbuf_read_req                  ), //output

    .bias_ld_addr                   ( bias_read_addr                 ), //output
    .bias_ld_addr_v                 ( bias_read_req                  ), //output

    .bias_prev_sw                   ( rd_bias_prev_sw                ), //output
    .ddr_pe_sw                      (                                ) //output
    );
  
  wire fc;
  wire fc1;
  wire noneed;
  assign noneed=~tag_bias_prev_sw_o;
 wire init_complete;
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        ddr_data_awaddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        ddr_data_awlen;
 wire  [ 3                    -1 : 0 ]        ddr_data_awsize;
 wire  [ 2                    -1 : 0 ]        ddr_data_awburst;
 wire                                         ddr_data_awvalid;
reg                                        ddr_data_awready;
  // Master Interface Write Data
wire  [ OBUF_AXI_DATA_WIDTH  -1 : 0 ]        ddr_data_wdata;
wire  [ OBUF_WSTRB_W         -1 : 0 ]       ddr_data_wstrb;
 wire                                       ddr_data_wlast;
 wire                                         ddr_data_wvalid;
reg                                        ddr_data_wready;
  // Master Interface Write Response
reg  [ 2                    -1 : 0 ]        ddr_data_bresp;
reg                                         ddr_data_bvalid;
 wire                                         ddr_data_bready;
  // Master Interface Read Address
 wire  [ AXI_ADDR_WIDTH       -1 : 0 ]        ddr_data_araddr;
 wire  [ AXI_BURST_WIDTH      -1 : 0 ]        ddr_data_arlen;
wire  [ 3                    -1 : 0 ]        ddr_data_arsize;
wire  [ 2                    -1 : 0 ]        ddr_data_arburst;
 wire                                        ddr_data_arvalid;
 wire  [ AXI_ID_WIDTH         -1 : 0 ]       ddr_data_arid;
reg                                      ddr_data_arready;
  // Master Interface Read Data
reg  [ OBUF_AXI_DATA_WIDTH  -1 : 0 ]       ddr_data_rdata;
reg  [ AXI_ID_WIDTH         -1 : 0 ]      ddr_data_rid;
reg  [ 2                    -1 : 0 ]       ddr_data_rresp;
reg                                         ddr_data_rlast;
reg                                      ddr_data_rvalid;
wire                                        ddr_data_rready;
wire  [ 4                    -1 : 0 ]        stmem_state;
wire  [ 1               -1 : 0 ]        stmem_tag;
wire                                         stmem_ddr_pe_sw;
  controller #(
    .CTRL_ADDR_WIDTH                ( CTRL_ADDR_WIDTH                ),
    .CTRL_DATA_WIDTH                ( CTRL_DATA_WIDTH                ),
    .INST_ADDR_WIDTH                ( INST_ADDR_WIDTH                )
/*    .IBUF_ADDR_WIDTH                ( IBUF_ADDR_WIDTH                ),
    .WBUF_ADDR_WIDTH                ( WBUF_ADDR_WIDTH                ),
    .OBUF_ADDR_WIDTH                ( OBUF_ADDR_WIDTH                )*/
  ) u_ctrl (
    .start(decoder_start),
    .decoder_start                  (init_complete),
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input

    .tag_flush                      ( tag_flush                      ), //output
    .tag_req                        ( tag_req                        ), //output
    .tag_ready                      ( tag_ready                      ), //input

    .compute_done                   ( compute_done                   ), //input
    .pu_compute_start               ( pu_compute_start_d               ), //input
    .pu_compute_done                ( pu_compute_done                ), //input
    .pu_write_done                  ( pu_write_done                  ), //input
    .pu_ctrl_state                  ( pu_ctrl_state                  ), //input

    //DEBUG

    .ibuf_tag_reuse                 ( ibuf_tag_reuse                 ), //output
    .obuf_tag_reuse                 ( obuf_tag_reuse                 ), //output
    .wbuf_tag_reuse                 ( wbuf_tag_reuse                 ), //output
    .bias_tag_reuse                 ( bias_tag_reuse                 ), //output

    .ibuf_tag_done                  ( ibuf_tag_done                  ), //input
    .wbuf_tag_done                  ( wbuf_tag_done                  ), //input
    .obuf_tag_done                  ( obuf_tag_done                  ), //input
    .bias_tag_done                  ( bias_tag_done                  ), //input

    .tag_bias_prev_sw               ( tag_bias_prev_sw               ), //output
    .tag_ddr_pe_sw                  ( tag_ddr_pe_sw                  ), //output
    .bias_ld_addr                   ( bias_ld_addr                   ), //output
    .bias_ld_addr_v                 ( bias_ld_addr_v                 ), //output
    .ibuf_ld_addr                   ( ibuf_ld_addr                   ), //output
    .ibuf_ld_addr_v                 ( ibuf_ld_addr_v                 ), //output
    .wbuf_ld_addr                   ( wbuf_ld_addr                   ), //output
    .wbuf_ld_addr_v                 ( wbuf_ld_addr_v                 ), //output
    .obuf_ld_addr                   ( obuf_ld_addr                   ), //output
    .obuf_ld_addr_v                 ( obuf_ld_addr_v                 ), //output
    .obuf_st_addr                   ( obuf_st_addr                   ), //output
    .obuf_st_addr_v                 ( obuf_st_addr_v                 ), //output

    .stmem_state                    ( stmem_state                    ), //input
    .stmem_tag                      ( stmem_tag                      ), //input
    .stmem_ddr_pe_sw                ( stmem_ddr_pe_sw                ), //input

    .ibuf_compute_ready             ( ibuf_compute_ready             ), //input
    .wbuf_compute_ready             ( wbuf_compute_ready             ), //input
    .obuf_compute_ready             ( obuf_compute_ready             ), //input
    .bias_compute_ready             ( bias_compute_ready             ), //input

    .cfg_loop_iter                  ( cfg_loop_iter                  ), //output
    .cfg_loop_iter_loop_id          ( cfg_loop_iter_loop_id          ), //output
    .cfg_loop_iter_v                ( cfg_loop_iter_v                ), //output
    .cfg_loop_stride                ( cfg_loop_stride                ), //output
    .cfg_loop_stride_v              ( cfg_loop_stride_v              ), //output
    .cfg_loop_stride_id             ( cfg_loop_stride_id             ), //output
    .cfg_loop_stride_type           ( cfg_loop_stride_type           ), //output
    .cfg_loop_stride_loop_id        ( cfg_loop_stride_loop_id        ), //output
    .cfg_mem_req_size               ( cfg_mem_req_size               ), //output
    .cfg_mem_req_v                  ( cfg_mem_req_v                  ), //output
    .cfg_mem_req_type               ( cfg_mem_req_type               ), //output
    .cfg_mem_req_id                 ( cfg_mem_req_id                 ), //output
    .cfg_mem_req_loop_id            ( cfg_mem_req_loop_id            ), //output
    .cfg_buf_req_size               ( cfg_buf_req_size               ), //output
    .cfg_buf_req_v                  ( cfg_buf_req_v                  ), //output
    .cfg_buf_req_type               ( cfg_buf_req_type               ), //output
    .cfg_buf_req_loop_id            ( cfg_buf_req_loop_id            ), //output

    .cfg_pu_inst                    ( cfg_pu_inst                    ), //output
    .cfg_pu_inst_v                  ( cfg_pu_inst_v                  ), //output
    .pu_block_start                 ( pu_block_start                 ), //output


    .ld_obuf_req                    ( ld_obuf_req                    ), //input
    .ld_obuf_ready                  ( ld_obuf_ready                  ),  //input
 //   .inst_read_data(inst_read_data),
    .cfg_systolic_precision(cfg_systolic_precision),
     .dnnweaver2_done(dnnweaver2_done),
     .fc(fc),
     .fc1(fc1),
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
    .ddr_data_rid( ddr_data_rid)
     
  );

    wire [ARRAY_N-1:0] weight_req;
// Systolic Array
//=============================================================
    assign sys_array_c_sel = rd_bias_prev_sw || obuf_bias_prev_sw;
  systolic_array #(
    .OBUF_ADDR_WIDTH                ( OBUF_ADDR_WIDTH                ),
    .BBUF_ADDR_WIDTH                ( BBUF_ADDR_WIDTH                ),
    .WBUF_ADDR_WIDTH                ( WBUF_ADDR_WIDTH                ),
    .ACT_WIDTH                      ( DATA_WIDTH                     ),
    .WGT_WIDTH                      ( WEIGHT_WIDTH                     ),
    .BIAS_WIDTH                     ( BIAS_WIDTH                     ),
    .ACC_WIDTH                      ( ACC_WIDTH                      ),
    .ARRAY_N                        ( ARRAY_N                        ),
    .ARRAY_M                        ( ARRAY_M                        )
  ) sys_array (
    .clk                            ( clk                            ),
    .reset                          ( reset                          ),
    .acc_clear                      ( acc_clear                      ),

    .ibuf_read_data                 ( ibuf_read_data                 ),

    .wbuf_read_data                 ( wbuf_read_data                 ),

    .bbuf_read_data                 ( bbuf_read_data                 ),
    .bias_read_req                  ( bias_read_req                  ),
    .bias_read_addr                 ( bias_read_addr                 ),
    .sys_bias_read_req              ( sys_bias_read_req              ),
    .sys_bias_read_addr             ( sys_bias_read_addr             ),
    .bias_prev_sw                   ( sys_array_c_sel                ),

    .obuf_read_data                 ( obuf_read_data                 ),
    .obuf_read_addr                 ( obuf_read_addr                 ),
    .sys_obuf_read_req              ( sys_obuf_read_req              ),
    .sys_obuf_read_addr             ( sys_obuf_read_addr             ),
    .obuf_write_req                 ( obuf_write_req                 ),
    .obuf_write_addr                ( obuf_write_addr                ),
    .obuf_write_data                ( sys_obuf_write_data            ),
    .sys_obuf_write_req             ( sys_obuf_write_req             ),
    .sys_obuf_write_addr            ( sys_obuf_write_addr            ),
    .cfg_loop_iter_v(cfg_loop_iter_v),
    .cfg_loop_iter_loop_id(cfg_loop_iter_loop_id),
    .cfg_systolic_precision(cfg_systolic_precision),
    .fc(fc),
    .fc1(fc1),
    .wbuf_read_addr(wbuf_read_addr),
    .noneed(noneed),
 //   .wldvalid(wbuf_read_req),
   .weight_req(weight_req)
  );


wire ibuf_reuse;
wire wbuf_reuse;
wire bbuf_reuse;
wire obuf_reuse;
    reg  [ 4                    -1 : 0 ]        ld_state_d;
//    reg  [ 4                    -1 : 0 ]        ld_state_q;


  ibuf_mem_wrapper #(
    // Internal Parameters
    .AXI_DATA_WIDTH                 ( IBUF_AXI_DATA_WIDTH            ),
    .AXI_BURST_WIDTH                ( AXI_BURST_WIDTH                ),
    .MEM_ID                         ( 0                              ),
    .NUM_TAGS                       ( NUM_TAGS                       ),
    .ARRAY_N                        ( ARRAY_N                        ),
    .DATA_WIDTH                     ( DATA_WIDTH                     ),
    .MEM_REQ_W                      ( MEM_REQ_W                      ),
    .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH                     ),
    .ADDR_WIDTH                     ( AXI_ADDR_WIDTH                     ),
    .BUF_ADDR_W                     ( IBUF_ADDR_WIDTH                ),
    .LOOP_ITER_W                    ( LOOP_ITER_W                    ),
    .LOOP_ID_W                      ( LOOP_ID_W                      )
  ) ibuf_mem (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input

    .compute_done                   ( compute_done                   ), //input
    .compute_ready                  ( ibuf_compute_ready             ), //input
    .compute_bias_prev_sw           (                                ), //output

    .block_done                     ( tag_flush                      ), //input
    .tag_req                        ( sync_tag_req_ldi                   ), //input
    .tag_reuse                      ( /*ibuf_reuse && sync_tag_req_ldi_d*/ibuf_tag_reuse                ), //input
    .tag_bias_prev_sw               ( tag_bias_prev_sw               ), //input
    .tag_ddr_pe_sw                  ( tag_ddr_pe_sw                ), //input
    .tag_ready                      ( ibuf_tag_ready                 ), //output
    .tag_done                       ( ibuf_tag_done                  ), //output

    .tag_base_ld_addr               ( ibuf_ld_addr                   ), //input

    .cfg_loop_iter_v                ( cfg_loop_iter_v                ), //input
    .cfg_loop_iter                  ( cfg_loop_iter                  ), //input
    .cfg_loop_iter_loop_id          ( cfg_loop_iter_loop_id          ), //input

    .cfg_loop_stride_v              ( cfg_loop_stride_v              ), //input
    .cfg_loop_stride                ( cfg_loop_stride                ), //input
    .cfg_loop_stride_loop_id        ( cfg_loop_stride_loop_id        ), //input
    .cfg_loop_stride_type           ( cfg_loop_stride_type           ), //input
    .cfg_loop_stride_id             ( cfg_loop_stride_id             ), //input

    .cfg_mem_req_v                  ( cfg_mem_req_v                  ),
    .cfg_mem_req_size               ( cfg_mem_req_size               ),
    .cfg_mem_req_type               ( cfg_mem_req_type               ), // 0: RD, 1:WR
    .cfg_mem_req_id                 ( cfg_mem_req_id                 ), // specify which scratchpad
    .cfg_mem_req_loop_id            ( cfg_mem_req_loop_id            ), // specify which loop

    .buf_read_data                  ( ibuf_read_data                 ),
    .buf_read_req                   ( ibuf_read_req                  ),
    .buf_read_addr                  ( ibuf_read_addr                 ),

    .mws_awaddr                     ( cl_ddr0_awaddr                 ),
    .mws_awlen                      ( cl_ddr0_awlen                  ),
    .mws_awsize                     ( cl_ddr0_awsize                 ),
    .mws_awburst                    ( cl_ddr0_awburst                ),
    .mws_awvalid                    ( cl_ddr0_awvalid                ),
    .mws_awready                    ( cl_ddr0_awready                ),
    .mws_wdata                      ( cl_ddr0_wdata                  ),
    .mws_wstrb                      ( cl_ddr0_wstrb                  ),
    .mws_wlast                      ( cl_ddr0_wlast                  ),
    .mws_wvalid                     ( cl_ddr0_wvalid                 ),
    .mws_wready                     ( cl_ddr0_wready                 ),
    .mws_bresp                      ( cl_ddr0_bresp                  ),
    .mws_bvalid                     ( cl_ddr0_bvalid                 ),
    .mws_bready                     ( cl_ddr0_bready                 ),
    .mws_araddr                     ( cl_ddr0_araddr                 ),
    .mws_arid                       ( cl_ddr0_arid                   ),
    .mws_arlen                      ( cl_ddr0_arlen                  ),
    .mws_arsize                     ( cl_ddr0_arsize                 ),
    .mws_arburst                    ( cl_ddr0_arburst                ),
    .mws_arvalid                    ( cl_ddr0_arvalid                ),
    .mws_arready                    ( cl_ddr0_arready                ),
    .mws_rdata                      ( cl_ddr0_rdata                  ),
    .mws_rid                        ( cl_ddr0_rid                    ),
    .mws_rresp                      ( cl_ddr0_rresp                  ),
    .mws_rlast                      ( cl_ddr0_rlast                  ),
    .mws_rvalid                     ( cl_ddr0_rvalid                 ),
    .mws_rready                     ( cl_ddr0_rready                 ),
    .ldmem_tag_done(ibuf_ld_done),
   .wrapperldstate(ld_state_q)
 
    );
   wbuf_mem_wrapper #(
    // Internal Parameters
    .AXI_DATA_WIDTH                 ( WBUF_AXI_DATA_WIDTH            ),
    .AXI_BURST_WIDTH                ( AXI_BURST_WIDTH                ),
    .MEM_ID                         ( 2                              ),
    .NUM_TAGS                       ( NUM_TAGS                       ),
    .ARRAY_N                        ( ARRAY_N                        ),
    .DATA_WIDTH                     ( WEIGHT_WIDTH                     ),
    .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH                     ),
    .MEM_REQ_W                      ( MEM_REQ_W                      ),
    .ADDR_WIDTH                     ( AXI_ADDR_WIDTH                     ),
    .BUF_ADDR_W                     ( WBUF_ADDR_WIDTH                ),
    .LOOP_ITER_W                    ( LOOP_ITER_W                    ),
    .LOOP_ID_W                      ( LOOP_ID_W                      )
  ) wbuf_mem (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input

    .compute_done                   ( compute_done                   ), //input
    .compute_ready                  ( wbuf_compute_ready             ), //input
    .compute_bias_prev_sw           (                                ), //output
    .block_done                     ( tag_flush_w                      ), //input
    .tag_req                        ( sync_tag_req_ldw_d                   ), //input
    .tag_reuse                      ( wbuf_reuse && sync_tag_req_ldw_d                 ), //input
    .tag_bias_prev_sw               ( tag_bias_prev_sw_w               ), //input
    .tag_ddr_pe_sw                  ( tag_ddr_pe_sw                  ), //input
    .tag_ready                      ( wbuf_tag_ready                 ), //output
    .tag_done                       ( wbuf_tag_done                  ), //output

    .tag_base_ld_addr               ( wbuf_ld_addr                   ), //input
    .wbuf_ld_addr_v                 ( wbuf_ld_addr_v                 ), //output

    .cfg_loop_iter_v                ( cfg_loop_iter_v                ), //input
    .cfg_loop_iter                  ( cfg_loop_iter                  ), //input
    .cfg_loop_iter_loop_id          ( cfg_loop_iter_loop_id          ), //input

    .cfg_loop_stride_v              ( cfg_loop_stride_v              ), //input
    .cfg_loop_stride                ( cfg_loop_stride                ), //input
    .cfg_loop_stride_loop_id        ( cfg_loop_stride_loop_id        ), //input
    .cfg_loop_stride_type           ( cfg_loop_stride_type           ), //input
    .cfg_loop_stride_id             ( cfg_loop_stride_id             ), //input

    .cfg_mem_req_v                  ( cfg_mem_req_v                  ),
    .cfg_mem_req_size               ( cfg_mem_req_size               ),
    .cfg_mem_req_type               ( cfg_mem_req_type               ), // 0: RD, 1:WR
    .cfg_mem_req_id                 ( cfg_mem_req_id                 ), // specify which scratchpad
    .cfg_mem_req_loop_id            ( cfg_mem_req_loop_id            ), // specify which loop

    .buf_read_data                  ( wbuf_read_data                 ),
    .buf_read_req                   ( wbuf_read_req                  ),
    .buf_read_addr                  ( wbuf_read_addr                 ),

    .mws_awaddr                     ( cl_ddr2_awaddr                 ),
    .mws_awlen                      ( cl_ddr2_awlen                  ),
    .mws_awsize                     ( cl_ddr2_awsize                 ),
    .mws_awburst                    ( cl_ddr2_awburst                ),
    .mws_awvalid                    ( cl_ddr2_awvalid                ),
    .mws_awready                    ( cl_ddr2_awready                ),
    .mws_wdata                      ( cl_ddr2_wdata                  ),
    .mws_wstrb                      ( cl_ddr2_wstrb                  ),
    .mws_wlast                      ( cl_ddr2_wlast                  ),
    .mws_wvalid                     ( cl_ddr2_wvalid                 ),
    .mws_wready                     ( cl_ddr2_wready                 ),
    .mws_bresp                      ( cl_ddr2_bresp                  ),
    .mws_bvalid                     ( cl_ddr2_bvalid                 ),
    .mws_bready                     ( cl_ddr2_bready                 ),
    .mws_araddr                     ( cl_ddr2_araddr                 ),
    .mws_arid                       ( cl_ddr2_arid                   ),
    .mws_arlen                      ( cl_ddr2_arlen                  ),
    .mws_arsize                     ( cl_ddr2_arsize                 ),
    .mws_arburst                    ( cl_ddr2_arburst                ),
    .mws_arvalid                    ( cl_ddr2_arvalid                ),
    .mws_arready                    ( cl_ddr2_arready                ),
    .mws_rdata                      ( cl_ddr2_rdata                  ),
    .mws_rid                        ( cl_ddr2_rid                    ),
    .mws_rresp                      ( cl_ddr2_rresp                  ),
    .mws_rlast                      ( cl_ddr2_rlast                  ),
    .mws_rvalid                     ( cl_ddr2_rvalid                 ),
    .mws_rready                     ( cl_ddr2_rready                 ),
    .ldmem_tag_done(wbuf_ld_done),
   .wrapperldstate(ld_state_q),
   .fc(fc),
   .weight_req(weight_req)
    );

 wire ddr_pe;
  obuf_mem_wrapper #(
    // Internal Parameters
    .AXI_DATA_WIDTH                 ( OBUF_AXI_DATA_WIDTH            ),
    .AXI_BURST_WIDTH                ( AXI_BURST_WIDTH                ),
    .MEM_ID                         ( 1                              ),
    .NUM_TAGS                       ( NUM_TAGS                       ),
    .ARRAY_N                        ( ARRAY_N                        ),
    .ARRAY_M                        ( ARRAY_M                        ),
    .DATA_WIDTH                     ( ACC_WIDTH                             ),
    .MEM_REQ_W                      ( MEM_REQ_W                      ),
    .ADDR_WIDTH                     ( AXI_ADDR_WIDTH                     ),
    .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH                     ),
   .BUF_ADDR_W                     ( OBUF_ADDR_WIDTH                ),
    .LOOP_ITER_W                    ( LOOP_ITER_W                    ),
    .LOOP_ID_W                      ( LOOP_ID_W                      )
  ) obuf_mem (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input

    .compute_done                   ( compute_done                   ), //input
    .compute_ready                  ( obuf_compute_ready             ), //output
    .compute_bias_prev_sw           ( obuf_bias_prev_sw              ), //output
    .block_done                     ( tag_flush_o                      ), //input
    .tag_req                        ( sync_tag_req_ldo_d                   ), //input
    .tag_reuse                      ( obuf_reuse && sync_tag_req_ldo_d                ), //input
    .tag_bias_prev_sw               ( tag_bias_prev_sw_o               ), //input
    .tag_ddr_pe_sw                  ( /*tag_ddr_pe_sw*/ddr_pe                  ), //input
    .tag_ready                      ( obuf_tag_ready                 ), //output
    .tag_done                       ( obuf_tag_done                  ), //output

    .tag_base_ld_addr               ( obuf_ld_addr                   ), //input
    .tag_base_st_addr               ( obuf_st_addr                   ), //input
       .obuf_ld_addr_v                 ( obuf_ld_addr_v                 ), 
       .obuf_st_addr_v                 ( obuf_st_addr_v                 ),
    .cfg_loop_iter_v                ( cfg_loop_iter_v                ), //input
    .cfg_loop_iter                  ( cfg_loop_iter                  ), //input
    .cfg_loop_iter_loop_id          ( cfg_loop_iter_loop_id          ), //input

    .cfg_loop_stride_v              ( cfg_loop_stride_v              ), //input
    .cfg_loop_stride                ( cfg_loop_stride                ), //input
    .cfg_loop_stride_loop_id        ( cfg_loop_stride_loop_id        ), //input
    .cfg_loop_stride_type           ( cfg_loop_stride_type           ), //input
    .cfg_loop_stride_id             ( cfg_loop_stride_id             ), //input

    .cfg_mem_req_v                  ( cfg_mem_req_v                  ),
    .cfg_mem_req_size               ( cfg_mem_req_size               ),
    .cfg_mem_req_type               ( cfg_mem_req_type               ), // 0: RD, 1:WR
    .cfg_mem_req_id                 ( cfg_mem_req_id                 ), // specify which scratchpad
    .cfg_mem_req_loop_id            ( cfg_mem_req_loop_id            ), // specify which loop

    .buf_write_data                 ( sys_obuf_write_data                ),
    .buf_write_req                  ( sys_obuf_write_req             ),
    .buf_write_addr                 ( sys_obuf_write_addr            ),
    .buf_read_data                  ( obuf_read_data                 ),
    .buf_read_req                   ( sys_obuf_read_req              ),
    .buf_read_addr                  ( sys_obuf_read_addr             ),

    .pu_buf_read_ready              ( ld_obuf_ready                  ),
    .pu_buf_read_req                ( ld_obuf_req                    ),
    .pu_buf_read_addr               ( ld_obuf_addr                   ),

    .pu_compute_start               ( pu_compute_start               ), //output
    .pu_compute_done                ( pu_compute_done                ), //input
    .pu_compute_ready               ( pu_compute_ready               ), //input

    .obuf_ld_stream_write_req       ( obuf_ld_stream_write_req       ),
    .obuf_ld_stream_write_data      ( obuf_ld_stream_write_data      ),

    .stmem_state                    ( stmem_state                    ), //output
    .stmem_tag                      ( stmem_tag                      ), //output
    .stmem_ddr_pe_sw                ( stmem_ddr_pe_sw                ), //output

    .mws_awaddr                     ( cl_ddr1_awaddr                 ),
    .mws_awlen                      ( cl_ddr1_awlen                  ),
    .mws_awsize                     ( cl_ddr1_awsize                 ),
    .mws_awburst                    ( cl_ddr1_awburst                ),
    .mws_awvalid                    ( cl_ddr1_awvalid                ),
    .mws_awready                    ( cl_ddr1_awready                ),
    .mws_wdata                      ( cl_ddr1_wdata                  ),
    .mws_wstrb                      ( cl_ddr1_wstrb                  ),
    .mws_wlast                      ( cl_ddr1_wlast                  ),
    .mws_wvalid                     ( cl_ddr1_wvalid                 ),
    .mws_wready                     ( cl_ddr1_wready                 ),
    .mws_bresp                      ( cl_ddr1_bresp                  ),
    .mws_bvalid                     ( cl_ddr1_bvalid                 ),
    .mws_bready                     ( cl_ddr1_bready                 ),
    .mws_araddr                     ( cl_ddr1_araddr                 ),
    .mws_arid                       ( cl_ddr1_arid                   ),
    .mws_arlen                      ( cl_ddr1_arlen                  ),
    .mws_arsize                     ( cl_ddr1_arsize                 ),
    .mws_arburst                    ( cl_ddr1_arburst                ),
    .mws_arvalid                    ( cl_ddr1_arvalid                ),
    .mws_arready                    ( cl_ddr1_arready                ),
    .mws_rdata                      ( cl_ddr1_rdata                  ),
    .mws_rid                        ( cl_ddr1_rid                    ),
    .mws_rresp                      ( cl_ddr1_rresp                  ),
    .mws_rlast                      ( cl_ddr1_rlast                  ),
    .mws_rvalid                     ( cl_ddr1_rvalid                 ),
    .mws_rready                     ( cl_ddr1_rready                 ),
    .ldmem_tag_done(obuf_ld_done),
    .stmem_tag_done(obuf_st_done),
    .stmem_tag_ready(stmem_tag_ready),
  //  .permit(permit),
   .mws_ld_start(obuf_ld_start),
   .wrapperldstate(ld_state_q),
   .noneed(noneed)
    );

  bbuf_mem_wrapper #(
    // Internal Parameters
    .AXI_DATA_WIDTH                 ( BBUF_AXI_DATA_WIDTH            ),
    .AXI_BURST_WIDTH                ( AXI_BURST_WIDTH                ),
    .MEM_ID                         ( 3                              ),
    .NUM_TAGS                       ( NUM_TAGS                       ),
    .ARRAY_N                        ( ARRAY_N                        ),
    .ARRAY_M                        ( ARRAY_M                        ),
    .DATA_WIDTH                     ( BIAS_WIDTH                             ),
    .MEM_REQ_W                      ( MEM_REQ_W                      ),
    .ADDR_WIDTH                     ( AXI_ADDR_WIDTH                     ),
    .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH                     ),
    .BUF_ADDR_W                     ( BBUF_ADDR_WIDTH                ),
    .LOOP_ITER_W                    ( LOOP_ITER_W                    ),
    .LOOP_ID_W                      ( LOOP_ID_W                      )
  ) bbuf_mem (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input

    .compute_done                   ( compute_done                   ), //input
    .compute_ready                  ( bias_compute_ready             ), //input
    .compute_bias_prev_sw           (                                ), //output
    .block_done                     ( tag_flush_b                      ), //input
    .tag_req                        ( sync_tag_req_ldb_d                   ), //input
    .tag_reuse                      ( bbuf_reuse && sync_tag_req_ldb_d                 ), //input
    .tag_bias_prev_sw               ( tag_bias_prev_sw_b               ), //input
    .tag_ddr_pe_sw                  ( tag_ddr_pe_sw                  ), //input
    .tag_ready                      ( bbuf_tag_ready                 ), //output
    .tag_done                       ( bias_tag_done                  ), //output

    .tag_base_ld_addr               ( bias_ld_addr                   ), //input
    .bias_ld_addr_v                 (bias_ld_addr_v),

    .cfg_loop_iter_v                ( cfg_loop_iter_v                ), //input
    .cfg_loop_iter                  ( cfg_loop_iter                  ), //input
    .cfg_loop_iter_loop_id          ( cfg_loop_iter_loop_id          ), //input

    .cfg_loop_stride_v              ( cfg_loop_stride_v              ), //input
    .cfg_loop_stride                ( cfg_loop_stride                ), //input
    .cfg_loop_stride_loop_id        ( cfg_loop_stride_loop_id        ), //input
    .cfg_loop_stride_type           ( cfg_loop_stride_type           ), //input
    .cfg_loop_stride_id             ( cfg_loop_stride_id             ), //input

    .cfg_mem_req_v                  ( cfg_mem_req_v                  ),
    .cfg_mem_req_size               ( cfg_mem_req_size               ),
    .cfg_mem_req_type               ( cfg_mem_req_type               ), // 0: RD, 1:WR
    .cfg_mem_req_id                 ( cfg_mem_req_id                 ), // specify which scratchpad
    .cfg_mem_req_loop_id            ( cfg_mem_req_loop_id            ), // specify which loop

    .buf_read_data                  ( bbuf_read_data                 ),
    .buf_read_req                   ( sys_bias_read_req              ),
    .buf_read_addr                  ( sys_bias_read_addr             ),

    .mws_awaddr                     ( cl_ddr3_awaddr                 ),
    .mws_awlen                      ( cl_ddr3_awlen                  ),
    .mws_awsize                     ( cl_ddr3_awsize                 ),
    .mws_awburst                    ( cl_ddr3_awburst                ),
    .mws_awvalid                    ( cl_ddr3_awvalid                ),
    .mws_awready                    ( cl_ddr3_awready                ),
    .mws_wdata                      ( cl_ddr3_wdata                  ),
    .mws_wstrb                      ( cl_ddr3_wstrb                  ),
    .mws_wlast                      ( cl_ddr3_wlast                  ),
    .mws_wvalid                     ( cl_ddr3_wvalid                 ),
    .mws_wready                     ( cl_ddr3_wready                 ),
    .mws_bresp                      ( cl_ddr3_bresp                  ),
    .mws_bvalid                     ( cl_ddr3_bvalid                 ),
    .mws_bready                     ( cl_ddr3_bready                 ),
    .mws_araddr                     ( cl_ddr3_araddr                 ),
    .mws_arid                       ( cl_ddr3_arid                   ),
    .mws_arlen                      ( cl_ddr3_arlen                  ),
    .mws_arsize                     ( cl_ddr3_arsize                 ),
    .mws_arburst                    ( cl_ddr3_arburst                ),
    .mws_arvalid                    ( cl_ddr3_arvalid                ),
    .mws_arready                    ( cl_ddr3_arready                ),
    .mws_rdata                      ( cl_ddr3_rdata                  ),
    .mws_rid                        ( cl_ddr3_rid                    ),
    .mws_rresp                      ( cl_ddr3_rresp                  ),
    .mws_rlast                      ( cl_ddr3_rlast                  ),
    .mws_rvalid                     ( cl_ddr3_rvalid                 ),
    .mws_rready                     ( cl_ddr3_rready                 ),
    .ldmem_tag_done(bbuf_ld_done),
   .wrapperldstate(ld_state_q)
    );
// reg areset;

 /* AXI4_RAM_v1_0  # ( 
		.C_S00_AXI_ID_WIDTH(C_S00_AXI_ID_WIDTH),
		.C_S00_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S00_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH),
		.C_S00_AXI_AWUSER_WIDTH(C_S00_AXI_AWUSER_WIDTH),
		.C_S00_AXI_ARUSER_WIDTH(C_S00_AXI_ARUSER_WIDTH),
		.C_S00_AXI_WUSER_WIDTH(C_S00_AXI_WUSER_WIDTH),
		.C_S00_AXI_RUSER_WIDTH(C_S00_AXI_RUSER_WIDTH),
		.C_S00_AXI_BUSER_WIDTH(C_S00_AXI_BUSER_WIDTH)
	) AXI4_RAM_v1_0_inst0 (
		.s00_axi_aclk(clk),
		.s00_axi_aresetn(areset),
		.s00_axi_awid(s00_axi_awid),
		.s00_axi_awaddr(s00_axi_awaddr),
		.s00_axi_awlen(s00_axi_awlen),
		.s00_axi_awsize(s00_axi_awsize),
		.s00_axi_awburst(s00_axi_awburst),
		.s00_axi_awlock(s00_axi_awlock),
		.s00_axi_awcache(s00_axi_awcache),
		.s00_axi_awprot(s00_axi_awprot),
		.s00_axi_awqos(),
		.s00_axi_awregion(),
		.s00_axi_awuser(),
		.s00_axi_awvalid(s00_axi_awvalid),
		.s00_axi_awready(s00_axi_awready),
		.s00_axi_wdata(s00_axi_wdata),
		.s00_axi_wstrb(s00_axi_wstrb),
		.s00_axi_wlast(s00_axi_wlast),
		.s00_axi_wuser(),
		.s00_axi_wvalid(s00_axi_wvalid),
		.s00_axi_wready(s00_axi_wready),
		.s00_axi_bid(1'b0),
		.s00_axi_bresp(s00_axi_bresp),
		.s00_axi_buser(),
		.s00_axi_bvalid(s00_axi_bvalid),
		.s00_axi_bready(s00_axi_bready),
		.s00_axi_arid(s00_axi_arid),
		.s00_axi_araddr(s00_axi_araddr),
		.s00_axi_arlen(s00_axi_arlen),
		.s00_axi_arsize(s00_axi_arsize),
		.s00_axi_arburst(s00_axi_arburst),
		.s00_axi_arlock(s00_axi_arlock),
		.s00_axi_arcache(s00_axi_arcache),
		.s00_axi_arprot(s00_axi_arprot),
		.s00_axi_arqos(),
		.s00_axi_arregion(),
		.s00_axi_aruser(),
		.s00_axi_arvalid(s00_axi_arvalid),
		.s00_axi_arready(s00_axi_arready),
		.s00_axi_rid(s00_axi_rid),
		.s00_axi_rdata(s00_axi_rdata),
		.s00_axi_rresp(s00_axi_rresp),
		.s00_axi_rlast(s00_axi_rlast),
		.s00_axi_ruser(),
		.s00_axi_rvalid(s00_axi_rvalid),
		.s00_axi_rready(s00_axi_rready)
  );*/



  gen_pu #(
    .INST_WIDTH                     ( INST_DATA_WIDTH                ),
    .DATA_WIDTH                     ( DATA_WIDTH                     ),
    .ACC_DATA_WIDTH                 ( ACC_WIDTH                             ),
    .SIMD_LANES                     ( ARRAY_M                        ),
    .OBUF_AXI_DATA_WIDTH            ( OBUF_AXI_DATA_WIDTH            ),
    .AXI_DATA_WIDTH                 ( PU_AXI_DATA_WIDTH              ),
    .AXI_ADDR_WIDTH                 ( AXI_ADDR_WIDTH                 ),
    .OBUF_ADDR_WIDTH                ( PU_OBUF_ADDR_WIDTH             ),
    .AXI_BURST_WIDTH                ( AXI_BURST_WIDTH                )
  ) u_pu
  (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .done                           ( pu_done                        ), //output
    //DEBUG
    .pu_ctrl_state                  ( pu_ctrl_state                  ), //output
    .obuf_ld_stream_write_req       ( obuf_ld_stream_write_req       ), //input
    .obuf_ld_stream_write_data      ( obuf_ld_stream_write_data      ), //input
    .inst_wr_req                    ( cfg_pu_inst_v                  ), //input
    .inst_wr_data                   ( cfg_pu_inst                    ), //input
    .pu_block_start                 ( pu_block_start                 ), //input
    .pu_compute_start               ( pu_compute_start_d               ), //input
    .pu_compute_ready               ( pu_compute_ready               ), //output
    .pu_compute_done                ( pu_compute_done                ), //output
    .pu_write_done                  ( pu_write_done                  ), //output
    .inst_wr_ready                  ( pu_inst_wr_ready               ), //output
    .ld_obuf_req                    ( ld_obuf_req                    ), //output
    .ld_obuf_addr                   ( ld_obuf_addr                   ), //output
    .ld_obuf_ready                  ( ld_obuf_ready                  ), //input
    .pu_ddr_awaddr                  ( cl_ddr4_awaddr                 ), //output
    .pu_ddr_awlen                   ( cl_ddr4_awlen                  ), //output
    .pu_ddr_awsize                  ( cl_ddr4_awsize                 ), //output
    .pu_ddr_awburst                 ( cl_ddr4_awburst                ), //output
    .pu_ddr_awvalid                 ( cl_ddr4_awvalid                ), //output
    .pu_ddr_awready                 ( cl_ddr4_awready                ), //input
    .pu_ddr_wdata                   ( cl_ddr4_wdata                  ), //output
    .pu_ddr_wstrb                   ( cl_ddr4_wstrb                  ), //output
    .pu_ddr_wlast                   ( cl_ddr4_wlast                  ), //output
    .pu_ddr_wvalid                  ( cl_ddr4_wvalid                 ), //output
    .pu_ddr_wready                  ( cl_ddr4_wready                 ), //input
    .pu_ddr_bresp                   ( cl_ddr4_bresp                  ), //input
    .pu_ddr_bvalid                  ( cl_ddr4_bvalid                 ), //input
    .pu_ddr_bready                  ( cl_ddr4_bready                 ), //output
    .pu_ddr_araddr                  ( cl_ddr4_araddr                 ), //output
    .pu_ddr_arid                    ( cl_ddr4_arid                   ), //output
    .pu_ddr_arlen                   ( cl_ddr4_arlen                  ), //output
    .pu_ddr_arsize                  ( cl_ddr4_arsize                 ), //output
    .pu_ddr_arburst                 ( cl_ddr4_arburst                ), //output
    .pu_ddr_arvalid                 ( cl_ddr4_arvalid                ), //output
    .pu_ddr_arready                 ( cl_ddr4_arready                ), //input
    .pu_ddr_rdata                   ( cl_ddr4_rdata                  ), //input
    .pu_ddr_rid                     ( cl_ddr4_rid                    ), //input
    .pu_ddr_rresp                   ( cl_ddr4_rresp                  ), //input
    .pu_ddr_rlast                   ( cl_ddr4_rlast                  ), //input
    .pu_ddr_rvalid                  ( cl_ddr4_rvalid                 ), //input
    .pu_ddr_rready                  ( cl_ddr4_rready                 ), //output
    .wrapperldstate(ld_state_q)
  );
///////////////////////////////////////////////////////////////////////////////////////////////////////
/* always @(posedge clk)
  begin if (reset)
   begin
if_start<=1'b0;
  end
  else if(tag_req)
begin
if_start<=1'b1;
end
end
*/









    localparam integer  LD_IDLE                   = 0;
    localparam integer  LDIBUF                   = 1;
    localparam integer  LDWBUF                 = 2;
    localparam integer  LDBBUF                = 3;
    localparam integer  LDOBUF                = 4;
    localparam integer  STOBUF                = 5;
    localparam integer  STPU                = 6;
    localparam integer  LD_WAIT                = 7;
    localparam integer  LD_INST                = 8;

//    assign sync_tag_req_ldi = base_ctrl_tag_req && ibuf_tag_ready && wbuf_tag_ready && bbuf_tag_ready &&ld_state_q ==LD_IDLE;
    assign tag_ready = ibuf_tag_ready && wbuf_tag_ready && bbuf_tag_ready && obuf_tag_ready &&ld_state_q ==LD_IDLE /*||ld_state_q ==LD_IDLE)*/;
//    register_sync #(1) tagready (clk, reset, tag_ready, tag_ready_d);
register_sync #(1) pustart (clk, reset, pu_compute_start, pu_compute_start_d);

/*wire tag_req_d;
wire tag_req_dd;
wire tag_req_ddd;
wire tag_flush_d;
register_sync #(1) tagreq (clk, reset, tag_req, tag_req_d);

register_sync #(1) tagreqd (clk, reset, tag_req_d, tag_req_dd);
register_sync #(1) tagreqdd (clk, reset, tag_req_dd, tag_req_ddd);*/
register_sync #(1) tagflushd (clk, reset, tag_flush, tag_flush_d);
   reg ireuse;
   reg wreuse;
   reg breuse;
   reg oreuse;

 always @(negedge clk)
  begin if (reset)
   begin
    ireuse<=1'b0;
   wreuse<=1'b0;
   breuse<=1'b0;
  oreuse<=1'b0;
  end
   else if(bias_tag_reuse ||wbuf_tag_reuse ||ibuf_tag_reuse ||obuf_tag_reuse)
begin
   breuse<=bias_tag_reuse;
   wreuse<=wbuf_tag_reuse;
   ireuse<=ibuf_tag_reuse;
   oreuse<=obuf_tag_reuse;
end
   else if (ld_state_q == LD_WAIT)
   begin
    ireuse<=1'b0;
   wreuse<=1'b0;
   breuse<=1'b0;
  oreuse<=1'b0;
  end
end

 always @(posedge clk)
  begin if (reset)
   begin
base_ctrl_tag_req<=1'b0;
  end

else if(tag_req)
begin
base_ctrl_tag_req<=tag_req;
end
 else if (ld_state_q == LD_WAIT)
  begin
base_ctrl_tag_req<=1'b0;
  end
end


/*  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) ld_i_buf (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( tag_req       ), //input
    .s_write_data                   ( ireuse      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( sync_tag_req_ldi        ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( ibuf_reuse       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );*/

  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) ld_w_buf (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( tag_req       ), //input
    .s_write_data                   ( wreuse      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( sync_tag_req_ldw        ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( wbuf_reuse       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );
  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) ld_o_buf (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( tag_req       ), //input
    .s_write_data                   ( oreuse      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( sync_tag_req_ldo        ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( obuf_reuse       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );
  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) ld_b_buf (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( tag_req       ), //input
    .s_write_data                   ( breuse      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( sync_tag_req_ldb        ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( bbuf_reuse       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );

  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) ddr_pe_d (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( tag_req       ), //input
    .s_write_data                   ( tag_ddr_pe_sw      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( sync_tag_req_ldo        ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( ddr_pe       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );
/*  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) bias_sw_i (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( tag_req       ), //input
    .s_write_data                   ( tag_bias_prev_sw      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( sync_tag_req_ldi        ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( tag_bias_prev_sw_i       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );*/
  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) bias_sw_o (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( tag_req       ), //input
    .s_write_data                   ( tag_bias_prev_sw      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( sync_tag_req_ldo        ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( tag_bias_prev_sw_o       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );
  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) bias_sw_w (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( tag_req       ), //input
    .s_write_data                   ( tag_bias_prev_sw      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( sync_tag_req_ldw        ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( tag_bias_prev_sw_w       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );
  fifo_asymmetric #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) bias_sw_b (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( tag_req       ), //input
    .s_write_data                   ( tag_bias_prev_sw      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( sync_tag_req_ldb        ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( tag_bias_prev_sw_b       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );
  fifo_asymmetric1 #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) flush_b (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( /*tag_req_ddd*/ tag_flush      ), //input
    .s_write_data                   ( tag_flush      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( compute_done  && ~base_ctrl_tag_req      ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( tag_flush_b       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );
  fifo_asymmetric1 #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) flush_w (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( /*tag_req_ddd*/ tag_flush      ), //input
    .s_write_data                   ( tag_flush      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( compute_done && ~base_ctrl_tag_req       ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( tag_flush_w       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );
  fifo_asymmetric1 #(
    .WR_DATA_WIDTH                  ( 1            ),
    .RD_DATA_WIDTH                  ( 1             ),
    .WR_ADDR_WIDTH                  ( 2                              )
  ) flush_o (
    .clk                            ( clk                            ), //input
    .reset                          ( reset                          ), //input
    .s_write_req                    ( /*tag_req_ddd*/  tag_flush     ), //input
    .s_write_data                   ( tag_flush      ), //input
    .s_write_ready                  (                                ), //output
    .s_read_req                     ( compute_done && ~base_ctrl_tag_req       ), //input
    .s_read_ready                   (       ), //output
    .s_read_data                    ( tag_flush_o       ), //output
    .almost_full                    (          ), //output
    .almost_empty                   (         )  //output
  );
///////////////////////////////////////fsm buffer ld order

    reg  [ WAIT_CYCLE_WIDTH        : 0 ]        wait_cycles_d;
    reg  [ WAIT_CYCLE_WIDTH        : 0 ]        wait_cycles_q;

  always @(posedge clk)
  begin
    if (reset)
      wait_cycles_q <= 0;
    else
      wait_cycles_q <= wait_cycles_d;
  end
  always @(posedge clk)
  begin
    if (reset)
      begin
      ld_state_q <= LD_INST;
      if_start<=0;
      end
    else begin
      ld_state_q <= ld_state_d;
      if_start<=1;
  end
  end

//assign permit=ld_state_q ==LD_IDLE;

/* always @(posedge clk)
  begin
    if (reset)
begin
sync_tag_req_ldi<=1'b0;
sync_tag_req_ldo<=1'b0;
sync_tag_req_ldw<=1'b0;
sync_tag_req_ldb<=1'b0;
end
else 
begin
sync_tag_req_ldi<=sync_tag_req_ldi;
sync_tag_req_ldo<=sync_tag_req_ldo;
sync_tag_req_ldw<=sync_tag_req_ldw;
sync_tag_req_ldb<=sync_tag_req_ldb;
end
end*/

assign s00_axi_awaddr_0 =(if_start==0)? 'b0:s00_axi_awaddr;
assign s00_axi_awlen_0 =(if_start==0)? 'b0:s00_axi_awlen;
assign s00_axi_awsize_0 =(if_start==0)? 'b0:s00_axi_awsize;
assign s00_axi_awburst_0 =(if_start==0)? 'b0:s00_axi_awburst;
assign s00_axi_awvalid_0 =(if_start==0)? 'b0:s00_axi_awvalid;
assign s00_axi_wdata_0 =(if_start==0)? 'b0:s00_axi_wdata;
assign s00_axi_wstrb_0 =(if_start==0)? 'b0:s00_axi_wstrb;
assign s00_axi_wlast_0 =(if_start==0)? 'b0:s00_axi_wlast;
assign s00_axi_wvalid_0 =(if_start==0)? 'b0:s00_axi_wvalid;


assign s00_axi_bready_0 =(if_start==0)? 'b0:s00_axi_bready;
assign s00_axi_araddr_0 =(if_start==0)? 'b0:s00_axi_araddr;
assign s00_axi_arlen_0 =(if_start==0)? 'b0:s00_axi_arlen;
assign s00_axi_arsize_0 =(if_start==0)? 'b0:s00_axi_arsize;
assign s00_axi_arburst_0 =(if_start==0)? 'b0:s00_axi_arburst;
assign s00_axi_arvalid_0 =(if_start==0)? 'b0:s00_axi_arvalid;
assign s00_axi_arid_0 =(if_start==0)? 'b0:s00_axi_arid;
assign s00_axi_rready_0 =(if_start==0)? 'b0:s00_axi_rready;



 always @(*)
  begin
    ld_state_d = ld_state_q;
  wait_cycles_d = wait_cycles_q;
sync_tag_req_ldi = 1'b0;
sync_tag_req_ldo = 1'b0;
sync_tag_req_ldw = 1'b0;
sync_tag_req_ldb = 1'b0;

    case(ld_state_q)
      LD_IDLE: begin
   if(stmem_tag_ready && ~pu_compute_start)
   begin
   ld_state_d = STOBUF;
   wait_cycles_d = ARRAY_N;
   end
   else if(pu_compute_start)
   ld_state_d = STPU;
   else if(tag_req && tag_ready)
begin
         sync_tag_req_ldi = 1'b1;
        if (sync_tag_req_ldi && ibuf_tag_ready) begin
            ld_state_d = LDIBUF;
           // areset=1'b0;
        end
end
      end
      LDIBUF: begin
       sync_tag_req_ldi=1'b0;
          // areset=1'b1;
        if (ireuse) begin 
          if (base_ctrl_tag_req && wbuf_tag_ready)
          begin
          sync_tag_req_ldw =1'b1;
        ld_state_d = LDWBUF;
         end
     end
      else  if (~ibuf_ld_done)
          begin
          sync_tag_req_ldw =1'b0;
s00_axi_awaddr =    cl_ddr0_awaddr;
s00_axi_awlen =  cl_ddr0_awlen;
s00_axi_awsize =  cl_ddr0_awsize;
s00_axi_awburst =  cl_ddr0_awburst;
s00_axi_awvalid =   cl_ddr0_awvalid;
cl_ddr0_awready = s00_axi_awready ;
  // Master Interface Write Data
s00_axi_wdata=cl_ddr0_wdata;
s00_axi_wstrb= cl_ddr0_wstrb;
s00_axi_wlast=  cl_ddr0_wlast;
s00_axi_wvalid=    cl_ddr0_wvalid;
 cl_ddr0_wready = s00_axi_wready;
  // Master Interface Write Response
cl_ddr0_bresp =s00_axi_bresp;
cl_ddr0_bvalid = s00_axi_bvalid;
s00_axi_bready=  cl_ddr0_bready;
  // Master Interface Read Address
s00_axi_araddr=   cl_ddr0_araddr;
s00_axi_arlen=    cl_ddr0_arlen;
s00_axi_arsize=  cl_ddr0_arsize;
s00_axi_arburst= cl_ddr0_arburst;
s00_axi_arvalid= cl_ddr0_arvalid;
s00_axi_arid=  cl_ddr0_arid;
 cl_ddr0_arready = s00_axi_arready ;
  // Master Interface Read Data
 cl_ddr0_rdata = s00_axi_rdata ;
 cl_ddr0_rid= s00_axi_rid;
cl_ddr0_rresp = s00_axi_rresp    ;
 cl_ddr0_rlast = s00_axi_rlast ;
cl_ddr0_rvalid =s00_axi_rvalid ;
s00_axi_rready =    cl_ddr0_rready;
         end
           else      if (ibuf_ld_done )
          begin 
if (base_ctrl_tag_req && wbuf_tag_ready)
          begin
          sync_tag_req_ldw =1'b1;
        ld_state_d = LDWBUF;
         end
          end
      end
      LDWBUF: begin
          sync_tag_req_ldw =1'b0;
    if (wreuse)
          begin if (base_ctrl_tag_req  && bbuf_tag_ready)
          begin
          sync_tag_req_ldb =1'b1;
        ld_state_d = LDBBUF;
         end
     end
         else if (~wbuf_ld_done)
          begin
          sync_tag_req_ldb =1'b0;
s00_axi_awaddr =    cl_ddr2_awaddr;
s00_axi_awlen =  cl_ddr2_awlen;
s00_axi_awsize =  cl_ddr2_awsize;
s00_axi_awburst =  cl_ddr2_awburst;
s00_axi_awvalid =   cl_ddr2_awvalid;
cl_ddr2_awready = s00_axi_awready ;
  // Master Interface Write Data
s00_axi_wdata=cl_ddr2_wdata;
s00_axi_wstrb= cl_ddr2_wstrb;
s00_axi_wlast=  cl_ddr2_wlast;
s00_axi_wvalid=    cl_ddr2_wvalid;
 cl_ddr2_wready = s00_axi_wready;
  // Master Interface Write Response
cl_ddr2_bresp =s00_axi_bresp;
cl_ddr2_bvalid = s00_axi_bvalid;
s00_axi_bready=  cl_ddr2_bready;
  // Master Interface Read Address
s00_axi_araddr=   cl_ddr2_araddr;
s00_axi_arlen=    cl_ddr2_arlen;
s00_axi_arsize=  cl_ddr2_arsize;
s00_axi_arburst= cl_ddr2_arburst;
s00_axi_arvalid= cl_ddr2_arvalid;
s00_axi_arid=  cl_ddr2_arid;
 cl_ddr2_arready = s00_axi_arready ;
  // Master Interface Read Data
 cl_ddr2_rdata = s00_axi_rdata ;
 cl_ddr2_rid= s00_axi_rid;
cl_ddr2_rresp = s00_axi_rresp    ;
 cl_ddr2_rlast = s00_axi_rlast ;
cl_ddr2_rvalid =s00_axi_rvalid ;
s00_axi_rready =    cl_ddr2_rready;
         end
           else      if (wbuf_ld_done )
          begin if (base_ctrl_tag_req  && bbuf_tag_ready)
          begin

          sync_tag_req_ldb =1'b1;
        ld_state_d = LDBBUF;
         end
          end
      end
      LDBBUF: begin
          sync_tag_req_ldb =1'b0;
      if (breuse)
          begin if (base_ctrl_tag_req && obuf_tag_ready )
          begin
        sync_tag_req_ldo =1'b1;
        ld_state_d = LDOBUF;
         end
          end
       else if (~bbuf_ld_done)
          begin
          sync_tag_req_ldo =1'b0;
s00_axi_awaddr =    cl_ddr3_awaddr;
s00_axi_awlen =  cl_ddr3_awlen;
s00_axi_awsize =  cl_ddr3_awsize;
s00_axi_awburst =  cl_ddr3_awburst;
s00_axi_awvalid =   cl_ddr3_awvalid;
cl_ddr3_awready = s00_axi_awready ;
  // Master Interface Write Data
s00_axi_wdata=cl_ddr3_wdata;
s00_axi_wstrb= cl_ddr3_wstrb;
s00_axi_wlast=  cl_ddr3_wlast;
s00_axi_wvalid=    cl_ddr3_wvalid;
 cl_ddr3_wready = s00_axi_wready;
  // Master Interface Write Response
cl_ddr3_bresp =s00_axi_bresp;
cl_ddr3_bvalid = s00_axi_bvalid;
s00_axi_bready=  cl_ddr3_bready;
  // Master Interface Read Address
s00_axi_araddr=   cl_ddr3_araddr;
s00_axi_arlen=    cl_ddr3_arlen;
s00_axi_arsize=  cl_ddr3_arsize;
s00_axi_arburst= cl_ddr3_arburst;
s00_axi_arvalid= cl_ddr3_arvalid;
s00_axi_arid=  cl_ddr3_arid;
 cl_ddr3_arready = s00_axi_arready ;
  // Master Interface Read Data
 cl_ddr3_rdata = s00_axi_rdata ;
 cl_ddr3_rid= s00_axi_rid;
cl_ddr3_rresp = s00_axi_rresp    ;
 cl_ddr3_rlast = s00_axi_rlast ;
cl_ddr3_rvalid =s00_axi_rvalid ;
s00_axi_rready =    cl_ddr3_rready;
         end
           else      if (bbuf_ld_done)
          begin if (base_ctrl_tag_req && obuf_tag_ready )
          begin
        sync_tag_req_ldo =1'b1;
        ld_state_d = LDOBUF;
         end
          end
      end

      LDOBUF: begin
          sync_tag_req_ldo =1'b0;
      if (oreuse)
          begin if (base_ctrl_tag_req )
          begin
        ld_state_d = LD_WAIT;
         end
          end
       else if ((~obuf_ld_done) && (~obuf_st_done)&& (pu_compute_start))
        ld_state_d = STPU;
       else if ((~obuf_ld_done) && (~obuf_st_done)&& (~pu_compute_start))
          begin
s00_axi_awaddr =    cl_ddr1_awaddr;
s00_axi_awlen =  cl_ddr1_awlen;
s00_axi_awsize =  cl_ddr1_awsize;
s00_axi_awburst =  cl_ddr1_awburst;
s00_axi_awvalid =   cl_ddr1_awvalid;
cl_ddr1_awready = s00_axi_awready ;
  // Master Interface Write Data
s00_axi_wdata=cl_ddr1_wdata;
s00_axi_wstrb= cl_ddr1_wstrb;
s00_axi_wlast=  cl_ddr1_wlast;
s00_axi_wvalid=    cl_ddr1_wvalid;
 cl_ddr1_wready = s00_axi_wready;
  // Master Interface Write Response
cl_ddr1_bresp =s00_axi_bresp;
cl_ddr1_bvalid = s00_axi_bvalid;
s00_axi_bready=  cl_ddr1_bready;
  // Master Interface Read Address
s00_axi_araddr=   cl_ddr1_araddr;
s00_axi_arlen=    cl_ddr1_arlen;
s00_axi_arsize=  cl_ddr1_arsize;
s00_axi_arburst= cl_ddr1_arburst;
s00_axi_arvalid= cl_ddr1_arvalid;
s00_axi_arid=  cl_ddr1_arid;
 cl_ddr1_arready = s00_axi_arready ;
  // Master Interface Read Data
 cl_ddr1_rdata = s00_axi_rdata ;
 cl_ddr1_rid= s00_axi_rid;
cl_ddr1_rresp = s00_axi_rresp    ;
 cl_ddr1_rlast = s00_axi_rlast ;
cl_ddr1_rvalid =s00_axi_rvalid ;
s00_axi_rready =    cl_ddr1_rready;
         end
           else      if (obuf_ld_done )/*|| obuf_st_done)*/
          begin if (base_ctrl_tag_req && (~obuf_ld_start) && (~stmem_tag_ready) )
          begin
        ld_state_d = LD_WAIT;
         end
          end
          else      if (obuf_st_done)
          begin if (base_ctrl_tag_req && (~obuf_ld_start))
          begin
        ld_state_d = LD_WAIT;
         end
          end

      end
STOBUF:begin
s00_axi_awaddr =    cl_ddr1_awaddr;
s00_axi_awlen =  cl_ddr1_awlen;
s00_axi_awsize =  cl_ddr1_awsize;
s00_axi_awburst =  cl_ddr1_awburst;
s00_axi_awvalid =   cl_ddr1_awvalid;
cl_ddr1_awready = s00_axi_awready ;
  // Master Interface Write Data
s00_axi_wdata=cl_ddr1_wdata;
s00_axi_wstrb= cl_ddr1_wstrb;
s00_axi_wlast=  cl_ddr1_wlast;
s00_axi_wvalid=    cl_ddr1_wvalid;
 cl_ddr1_wready = s00_axi_wready;
  // Master Interface Write Response
cl_ddr1_bresp =s00_axi_bresp;
cl_ddr1_bvalid = s00_axi_bvalid;
s00_axi_bready=  cl_ddr1_bready;
  // Master Interface Read Address
s00_axi_araddr=   cl_ddr1_araddr;
s00_axi_arlen=    cl_ddr1_arlen;
s00_axi_arsize=  cl_ddr1_arsize;
s00_axi_arburst= cl_ddr1_arburst;
s00_axi_arvalid= cl_ddr1_arvalid;
s00_axi_arid=  cl_ddr1_arid;
 cl_ddr1_arready = s00_axi_arready ;
  // Master Interface Read Data
 cl_ddr1_rdata = s00_axi_rdata ;
 cl_ddr1_rid= s00_axi_rid;
cl_ddr1_rresp = s00_axi_rresp    ;
 cl_ddr1_rlast = s00_axi_rlast ;
cl_ddr1_rvalid =s00_axi_rvalid ;
s00_axi_rready =    cl_ddr1_rready;
  if (wait_cycles_q != 0) begin
   wait_cycles_d=wait_cycles_q-1'b1;
   end
   else if(wait_cycles_q==0)
begin
    if(pu_compute_start)
   ld_state_d = STPU;
   else if(obuf_st_done)
   ld_state_d = LD_WAIT;
end
end

STPU:begin
s00_axi_awaddr =    cl_ddr4_awaddr;
s00_axi_awlen =  cl_ddr4_awlen;
s00_axi_awsize =  cl_ddr4_awsize;
s00_axi_awburst =  cl_ddr4_awburst;
s00_axi_awvalid =   cl_ddr4_awvalid;
cl_ddr4_awready = s00_axi_awready ;
  // Master Interface Write Data
s00_axi_wdata=cl_ddr4_wdata;
s00_axi_wstrb= cl_ddr4_wstrb;
s00_axi_wlast=  cl_ddr4_wlast;
s00_axi_wvalid=    cl_ddr4_wvalid;
 cl_ddr4_wready = s00_axi_wready;
  // Master Interface Write Response
cl_ddr4_bresp =s00_axi_bresp;
cl_ddr4_bvalid = s00_axi_bvalid;
s00_axi_bready=  cl_ddr4_bready;
  // Master Interface Read Address
s00_axi_araddr=   cl_ddr4_araddr;
s00_axi_arlen=    cl_ddr4_arlen;
s00_axi_arsize=  cl_ddr4_arsize;
s00_axi_arburst= cl_ddr4_arburst;
s00_axi_arvalid= cl_ddr4_arvalid;
s00_axi_arid=  cl_ddr4_arid;
 cl_ddr4_arready = s00_axi_arready ;
  // Master Interface Read Data
 cl_ddr4_rdata = s00_axi_rdata ;
 cl_ddr4_rid= s00_axi_rid;
cl_ddr4_rresp = s00_axi_rresp    ;
 cl_ddr4_rlast = s00_axi_rlast ;
cl_ddr4_rvalid =s00_axi_rvalid ;
s00_axi_rready =    cl_ddr4_rready;
    if(pu_write_done)
   ld_state_d = LD_WAIT;

end
      LD_WAIT: begin
        ld_state_d = LD_IDLE;
      end
   LD_INST:begin
s00_axi_awaddr =    ddr_data_awaddr;
s00_axi_awlen =  ddr_data_awlen;
s00_axi_awsize =  ddr_data_awsize;
s00_axi_awburst =  ddr_data_awburst;
s00_axi_awvalid =   ddr_data_awvalid;
ddr_data_awready = s00_axi_awready ;
  // Master Interface Write Data
s00_axi_wdata=ddr_data_wdata;
s00_axi_wstrb= ddr_data_wstrb;
s00_axi_wlast=  ddr_data_wlast;
s00_axi_wvalid=    ddr_data_wvalid;
ddr_data_wready = s00_axi_wready;
  // Master Interface Write Response
ddr_data_bresp =s00_axi_bresp;
ddr_data_bvalid = s00_axi_bvalid;
s00_axi_bready=  ddr_data_bready;
  // Master Interface Read Address
s00_axi_araddr=   ddr_data_araddr;
s00_axi_arlen=    ddr_data_arlen;
s00_axi_arsize=  ddr_data_arsize;
s00_axi_arburst= ddr_data_arburst;
s00_axi_arvalid= ddr_data_arvalid;
s00_axi_arid=  ddr_data_arid;
ddr_data_arready = s00_axi_arready ;
  // Master Interface Read Data
ddr_data_rdata = s00_axi_rdata ;
ddr_data_rid= s00_axi_rid;
ddr_data_rresp = s00_axi_rresp    ;
ddr_data_rlast = s00_axi_rlast ;
ddr_data_rvalid =s00_axi_rvalid ;
s00_axi_rready =    ddr_data_rready;
if(init_complete)
        ld_state_d = LD_IDLE;
     end
    endcase
  end

endmodule


