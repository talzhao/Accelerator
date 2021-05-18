`timescale 1ns/1ps
module ibuf_new #(
    parameter integer  TAG_W                        = 2,  // Log number of banks
    parameter integer  MEM_DATA_WIDTH               = 64,
    parameter integer  ARRAY_N                      = 1,
    parameter integer  DATA_WIDTH                   = 32,
    parameter integer  BUF_ADDR_WIDTH               = 10,

    parameter integer  GROUP_SIZE                   = MEM_DATA_WIDTH / DATA_WIDTH,
    parameter integer  GROUP_ID_W                   = GROUP_SIZE == 1 ? 0 : $clog2(GROUP_SIZE),
    parameter integer  BUF_ID_W                     = $clog2(ARRAY_N) - GROUP_ID_W,

    parameter integer  MEM_ADDR_WIDTH               = BUF_ADDR_WIDTH + BUF_ID_W,
    parameter integer  BUF_DATA_WIDTH               = ARRAY_N * DATA_WIDTH
)
(
    input  wire                                         clk,
    input  wire                                         reset,

    input  wire                                         mem_write_req,
    input  wire  [ MEM_ADDR_WIDTH       -1 : 0 ]        mem_write_addr,
    input  wire  [ MEM_DATA_WIDTH       -1 : 0 ]        mem_write_data,

    input  wire                                         buf_read_req,
    input  wire  [ BUF_ADDR_WIDTH       -1 : 0 ]        buf_read_addr,
    output reg  [ BUF_DATA_WIDTH       -1 : 0 ]        buf_read_data
  );
 genvar n;
  generate
    for (n=0; n<ARRAY_N; n=n+1)
    begin: LOOP_N

      localparam integer  LOCAL_ADDR_W                 = BUF_ADDR_WIDTH;
      localparam integer  LOCAL_BUF_ID                 = n/GROUP_SIZE;

      wire                                        local_buf_read_req;
      wire [ LOCAL_ADDR_W         -1 : 0 ]        local_buf_read_addr;
      wire [ DATA_WIDTH           -1 : 0 ]        local_buf_read_data;



      wire                                        buf_read_req_fwd;
      wire [ LOCAL_ADDR_W         -1 : 0 ]        buf_read_addr_fwd;
      register_sync #(1) read_req_fwd (clk, reset, local_buf_read_req, buf_read_req_fwd);
      register_sync #(LOCAL_ADDR_W) read_addr_fwd (clk, reset, local_buf_read_addr, buf_read_addr_fwd);

      always @(posedge clk)
        if(buf_read_req_fwd)
           buf_read_data[(n)*DATA_WIDTH+:DATA_WIDTH] <= local_buf_read_data;
        else
           buf_read_data[(n)*DATA_WIDTH+:DATA_WIDTH] <= buf_read_data[(n)*DATA_WIDTH+:DATA_WIDTH];

      if (n == 0) begin
        assign local_buf_read_req = buf_read_req;
        assign local_buf_read_addr = buf_read_addr;
      end
      else begin
        assign local_buf_read_req = LOOP_N[n-1].buf_read_req_fwd;
        assign local_buf_read_addr = LOOP_N[n-1].buf_read_addr_fwd;
      end

      wire [ BUF_ID_W             -1 : 0 ]        local_mem_write_buf_id;
      wire                                        local_mem_write_req;
      wire [ LOCAL_ADDR_W         -1 : 0 ]        local_mem_write_addr;
      wire [ DATA_WIDTH           -1 : 0 ]        local_mem_write_data;

      wire [ BUF_ID_W             -1 : 0 ]        buf_id;
      assign buf_id = LOCAL_BUF_ID;

      if (BUF_ID_W == 0) begin
        assign local_mem_write_addr = mem_write_addr;
        assign local_mem_write_req = mem_write_req;
        assign local_mem_write_data = mem_write_data[(n%GROUP_SIZE)*DATA_WIDTH+:DATA_WIDTH];
      end
      else begin
        assign {local_mem_write_addr, local_mem_write_buf_id} = mem_write_addr;
        assign local_mem_write_req = mem_write_req && local_mem_write_buf_id == buf_id;
        assign local_mem_write_data = mem_write_data[(n%GROUP_SIZE)*DATA_WIDTH+:DATA_WIDTH];
      end
  wire cenya,cenyb,gwenya,gwenyb;
  wire [9:0] aya;
  wire [9:0] ayb;

  wire  wenya;
  wire  wenyb;


  wire [1:0] soa;
  wire [1:0] sob;
  wire [DATA_WIDTH  -1 : 0]d_a;
  wire [DATA_WIDTH  -1 : 0]d_b;
  wire [DATA_WIDTH  -1 : 0]q_a;
  wire [DATA_WIDTH  -1 : 0]q_b;


 




sram_dp_hde_ibuf synch_sram_u1_304(
.CENYA(cenya), 
.WENYA(wenya), 
.AYA(aya), 
.CENYB(cenyb), 
.WENYB(wenyb), 
.AYB(ayb),  
.QA(local_buf_read_data), 
.QB(q_b),  
.SOA(soa), 
.SOB(sob), 
.CLKA(clk), 
.CENA(~local_buf_read_req), 
.WENA(local_buf_read_req), 
.AA(local_buf_read_addr), 
.DA(d_a), 
.CLKB(clk), 
.CENB(~local_mem_write_req), 
.WENB(~local_mem_write_req), 
.AB(local_mem_write_addr), 
.DB(local_mem_write_data), 
.EMAA(3'b010), 
.EMAWA(2'b00), 
.EMAB(3'b010),
.EMAWB(2'b00), 
.TENA(1'b1), 
.TCENA(1'b1), 
.TWENA(1'b1), 
.TAA(local_buf_read_addr), 
.TDA(d_a), 
.TENB(1'b1), 
.TCENB(1'b1), 
.TWENB(1'b1), 
.TAB(local_mem_write_addr), 
.TDB(local_mem_write_data), 
.RET1N(1'b1), 
.SIA(2'b00), 
.SEA(1'b0), 
.DFTRAMBYP(1'b0), 
.SIB(2'b00), 
.SEB(1'b0), 
.COLLDISN(1'b0)

   );

    end
  endgenerate
endmodule
