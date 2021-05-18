`timescale 1ns/1ps
module wbuf_new #(
    parameter integer  TAG_W                        = 2,  // Log number of banks
    parameter integer  MEM_DATA_WIDTH               = 64,
    parameter integer  ARRAY_N                      = 64,
    parameter integer  ARRAY_M                      = 64,
    parameter integer  DATA_WIDTH                   = 16,
    parameter integer  BUF_ADDR_WIDTH               = 9,

    parameter integer  GROUP_SIZE                   = 2,
    parameter integer  NUM_GROUPS                   = MEM_DATA_WIDTH / DATA_WIDTH,
    parameter integer  GROUP_ID_W                   = GROUP_SIZE == 1 ? 0 : $clog2(GROUP_SIZE),
    parameter integer  BUF_ID_N_W                   = $clog2(ARRAY_N),
    parameter integer  BUF_ID_W                     = BUF_ID_N_W-1 ,

    parameter integer  MEM_ADDR_WIDTH               = BUF_ADDR_WIDTH + BUF_ID_W,
    parameter integer  BUF_DATA_WIDTH               = ARRAY_N *ARRAY_M*  DATA_WIDTH
)
(
    input  wire                                         clk,
    input  wire                                         reset,

    input  wire                                         mem_write_req,
    input  wire  [ MEM_ADDR_WIDTH       -1 : 0 ]        mem_write_addr,
    input  wire  [ MEM_DATA_WIDTH       -1 : 0 ]        mem_write_data,

    input  wire                                         buf_read_req,
    input  wire  [ BUF_ADDR_WIDTH       -1 : 0 ]        buf_read_addr,
    output reg  [ BUF_DATA_WIDTH       -1 : 0 ]        buf_read_data,
    input wire fc,
    output wire [ARRAY_N-1:0] weight_req
  );


    wire [ARRAY_N-1:0] weight_reqq;


/*
genvar m,n;
reg num;
always@(posedge clk)
if(reset)
num<=0;

wire  [ BUF_DATA_WIDTH*2       -1 : 0 ]        buf_read_data_d;

assign buf_read_data=num?buf_read_data_d[BUF_DATA_WIDTH*2       -1 : BUF_DATA_WIDTH]:buf_read_data_d[BUF_DATA_WIDTH       -1 : 0];
generate
for (m=0; m<GROUP_SIZE; m=m+1)
begin: LOOP_M
for (n=0; n<ARRAY_N; n=n+1)
begin: LOOP_N
   localparam integer  LOCAL_BUF_ID                 = m*ARRAY_M+ n;
    localparam integer  LOCAL_ADDR_W                 = BUF_ADDR_WIDTH;
wire [MEM_DATA_WIDTH/2-1:0]data_in;
wire [MEM_DATA_WIDTH/2-1:0]data_o;
wire [MEM_ADDR_WIDTH]addr;

  wire  we;/////////////////////////read
  wire  ce;////////////////////////////write
assign we=mem_write_req;
assign ce=mem_write_req|buf_read_req;
assign addr=mem_write_addr;
//always@(posedge clk)
assign  data_in=mem_write_data[m*ARRAY_N*64+n*64+:64];
assign buf_read_data_d[m*ARRAY_N*64+n*64+:64]=data_o;
*/

genvar m,n,j;
generate
for (n=0; n<ARRAY_N/2; n=n+1)
begin: LOOP_N
    localparam integer  LOCAL_ADDR_W                 = BUF_ADDR_WIDTH;
    localparam integer  LOCAL_BUF_ID                 = n;
    


for (j=0; j<2; j=j+1)
begin: LOOP_NN


/*
  if (n == 0) begin
      register_sync #(1) read_req_fwd (clk, reset, local_buf_read_req, buf_read_req_fwd);
      register_sync #(LOCAL_ADDR_W) read_addr_fwd (clk, reset, local_buf_read_addr, buf_read_addr_fwd);
      register_sync #(1) read_req_fwd_dd (clk, reset, buf_read_req_fwd, buf_read_req_fwd_d);
      register_sync #(LOCAL_ADDR_W) read_addr_fwd_d (clk, reset, buf_read_addr_fwd, buf_read_addr_fwd_d);
  end else begin
      assign buf_read_req_fwd = local_buf_read_req;
      assign buf_read_req_fwd_d = local_buf_read_req;
      assign buf_read_addr_fwd = local_buf_read_addr;
      assign buf_read_addr_fwd_d = local_buf_read_addr;
  end
*/
/*
    wire                                        local_buf_read_req;
    wire [ LOCAL_ADDR_W         -1 : 0 ]        local_buf_read_addr;

   assign weight_req[j+n*GROUP_SIZE]=local_buf_read_req;

    wire                                        buf_read_req_fwd;
    wire                                        buf_read_req_fwd_d;
    wire [ LOCAL_ADDR_W         -1 : 0 ]        buf_read_addr_fwd;
    wire [ LOCAL_ADDR_W         -1 : 0 ]        buf_read_addr_fwd_d;

      register_sync #(1) read_req_fwd (clk, reset, local_buf_read_req, buf_read_req_fwd);
      register_sync #(LOCAL_ADDR_W) read_addr_fwd (clk, reset, local_buf_read_addr, buf_read_addr_fwd);
      register_sync #(1) read_req_fwd_dd (clk, reset, buf_read_req_fwd, buf_read_req_fwd_d);
      register_sync #(LOCAL_ADDR_W) read_addr_fwd_d (clk, reset, buf_read_addr_fwd, buf_read_addr_fwd_d);

  if (n == 0 && j==0) begin
    assign local_buf_read_req = buf_read_req;
    assign local_buf_read_addr = buf_read_addr;
  end
  else if (j == 0)
  begin
    assign local_buf_read_req = LOOP_N[n-1].LOOP_NN[1].buf_read_req_fwd;
    assign local_buf_read_addr =fc?  LOOP_N[n-1].LOOP_NN[1].buf_read_addr_fwd_d:LOOP_N[n-1].LOOP_NN[1].buf_read_addr_fwd;
  end
    else if (j == 1)
  begin
    assign local_buf_read_req = LOOP_N[n].LOOP_NN[0].buf_read_req_fwd;
    assign local_buf_read_addr =fc?  LOOP_N[n].LOOP_NN[0].buf_read_addr_fwd_d:LOOP_N[n].LOOP_NN[0].buf_read_addr_fwd;
  end
*/




for (m=0; m<GROUP_SIZE; m=m+1)
    begin: LOOP_M

    wire [ MEM_DATA_WIDTH       -1 : 0 ]        local_buf_read_data;
    wire ce;
    wire we;
    wire [ LOCAL_ADDR_W         -1 : 0 ] addr;
    wire [MEM_DATA_WIDTH/4-1:0]data_in;
    wire [MEM_DATA_WIDTH/4-1:0]data_o;

    wire [ BUF_ID_W             -1 : 0 ]        local_mem_write_buf_id;
   // wire [ BUF_ID_W             -1 : 0 ]        k;
    wire                                        local_mem_write_req;
    wire [ LOCAL_ADDR_W         -1 : 0 ]        local_mem_write_addr;
    wire [ MEM_DATA_WIDTH       -1 : 0 ]        local_mem_write_data;

    wire [ BUF_ID_W             -1 : 0 ]        buf_id;
    wire [ BUF_ID_W             +1  : 0 ]       buf_id_fc;
    


    wire                                        local_buf_read_req;
    wire [ LOCAL_ADDR_W         -1 : 0 ]        local_buf_read_addr;
    wire req_first;
    wire req_second;



   
 //  assign weight_req[j+n*GROUP_SIZE] = local_buf_read_req ;
    if(n <= 3)
//    assign weight_req[n*GROUP_SIZE + j*GROUP_SIZE] = LOOP_N[n].LOOP_NN[j].LOOP_M[1].local_buf_read_req || LOOP_N[n].LOOP_NN[j].LOOP_M[0].local_buf_read_req;
       assign req_first = LOOP_N[n].LOOP_NN[j].LOOP_M[1].local_buf_read_req || LOOP_N[n].LOOP_NN[j].LOOP_M[0].local_buf_read_req;
    else if(n > 3)
       assign req_second = LOOP_N[n-4].LOOP_NN[j].LOOP_M[1].local_buf_read_req || LOOP_N[n-4].LOOP_NN[j].LOOP_M[0].local_buf_read_req;
/*
    if(n <= 3)
      assign weight_reqq[n*GROUP_SIZE*GROUP_SIZE + j*GROUP_SIZE +m] = req_first;
    else
      assign weight_reqq[n*GROUP_SIZE*GROUP_SIZE + j*GROUP_SIZE +m] = req_second;*/
  
//   if(n <= 3)
       assign weight_reqq[n*GROUP_SIZE*GROUP_SIZE + j*GROUP_SIZE +m] = (req_first == 1) || (req_second == 1) ;
//   else
       //assign weight_reqq[(n-4)*GROUP_SIZE*GROUP_SIZE + j*GROUP_SIZE +m] = req_second;  

     

  
    wire                                        buf_read_req_fwd;
    wire                                        buf_read_req_fwd_d;
    wire [ LOCAL_ADDR_W         -1 : 0 ]        buf_read_addr_fwd;
    wire [ LOCAL_ADDR_W         -1 : 0 ]        buf_read_addr_fwd_d;

      register_sync #(1) read_req_fwd (clk, reset, local_buf_read_req, buf_read_req_fwd);
      register_sync #(LOCAL_ADDR_W) read_addr_fwd (clk, reset, local_buf_read_addr, buf_read_addr_fwd);
      register_sync #(1) read_req_fwd_dd (clk, reset, buf_read_req_fwd, buf_read_req_fwd_d);
      register_sync #(LOCAL_ADDR_W) read_addr_fwd_d (clk, reset, buf_read_addr_fwd, buf_read_addr_fwd_d);


  if (n == 0 && j == 0 && m == 0) begin
    assign local_buf_read_req = buf_read_req;
    assign local_buf_read_addr = buf_read_addr;
  end
  else if( n <= 3 ) begin
  
  if (j == 0 && m == 0)
  begin
    assign local_buf_read_req = LOOP_N[n-1].LOOP_NN[1].LOOP_M[1].buf_read_req_fwd;
    assign local_buf_read_addr = LOOP_N[n-1].LOOP_NN[1].LOOP_M[1].buf_read_addr_fwd;
  end
    else if (j == 1 && m == 0)
  begin
    assign local_buf_read_req = LOOP_N[n].LOOP_NN[0].LOOP_M[1].buf_read_req_fwd;
    assign local_buf_read_addr =LOOP_N[n].LOOP_NN[0].LOOP_M[1].buf_read_addr_fwd;
  end
    else if (m == 1) begin
      assign local_buf_read_req = (fc == 0)? LOOP_N[n].LOOP_NN[j].LOOP_M[0].local_buf_read_req:LOOP_N[n].LOOP_NN[j].LOOP_M[0].buf_read_req_fwd;
      assign local_buf_read_addr = (fc == 0)? LOOP_N[n].LOOP_NN[j].LOOP_M[0].local_buf_read_addr:LOOP_N[n].LOOP_NN[j].LOOP_M[0].buf_read_addr_fwd;
  end
  end

  else if(n > 3) begin
  if (j == 0 && m == 0)
  begin
    assign local_buf_read_req = (fc == 0)? LOOP_N[n-1].LOOP_NN[1].LOOP_M[1].buf_read_req_fwd:LOOP_N[n-4].LOOP_NN[j].LOOP_M[m].buf_read_req_fwd;
    assign local_buf_read_addr = (fc == 0)? LOOP_N[n-1].LOOP_NN[1].LOOP_M[1].buf_read_addr_fwd:LOOP_N[n-4].LOOP_NN[j].LOOP_M[m].buf_read_addr_fwd;
  end
    else if (j == 1 && m == 0)
  begin
    assign local_buf_read_req = (fc == 0)? LOOP_N[n].LOOP_NN[0].LOOP_M[1].buf_read_req_fwd:LOOP_N[n-4].LOOP_NN[j].LOOP_M[m].buf_read_req_fwd;
    assign local_buf_read_addr =(fc == 0)? LOOP_N[n].LOOP_NN[0].LOOP_M[1].buf_read_addr_fwd:LOOP_N[n-4].LOOP_NN[j].LOOP_M[m].buf_read_addr_fwd;
  end
    else if (m == 1) begin
      assign local_buf_read_req = (fc == 0)? LOOP_N[n].LOOP_NN[j].LOOP_M[0].local_buf_read_req:LOOP_N[n-4].LOOP_NN[j].LOOP_M[0].buf_read_req_fwd;
      assign local_buf_read_addr = (fc == 0)? LOOP_N[n].LOOP_NN[j].LOOP_M[0].local_buf_read_addr:LOOP_N[n-4].LOOP_NN[j].LOOP_M[0].buf_read_addr_fwd;
  end
  end




/*
   if (n == 0 && j == 0 && m == 0) begin
    assign local_buf_read_req = buf_read_req;
    assign local_buf_read_addr = buf_read_addr;
   end
  else if (j == 0 && m == 0) begin
    assign local_buf_read_req = LOOP_N[n+3].LOOP_NN[1].LOOP_M[1].buf_read_req_fwd;
    assign local_buf_read_addr = LOOP_N[n+3].LOOP_NN[1].LOOP_M[1].buf_read_addr_fwd;
   end

  else if (j == 0 && m == 1) begin
    assign local_buf_read_req = LOOP_N[n+4].LOOP_NN[0].LOOP_M[0].buf_read_req_fwd;
    assign local_buf_read_addr = LOOP_N[n+4].LOOP_NN[0].LOOP_M[0].buf_read_addr_fwd;
   end

  else if (j == 1 && m == 0) begin
    assign local_buf_read_req = LOOP_N[n+4].LOOP_NN[0].LOOP_M[1].buf_read_req_fwd;
    assign local_buf_read_addr = LOOP_N[n+4].LOOP_NN[0].LOOP_M[1].buf_read_addr_fwd;
   end

  else if (j == 1 && m == 1) begin
    assign local_buf_read_req = LOOP_N[n+4].LOOP_NN[1].LOOP_M[0].buf_read_req_fwd;
    assign local_buf_read_addr = LOOP_N[n+4].LOOP_NN[1].LOOP_M[0].buf_read_addr_fwd;
   end


   else if (n > 3) begin
    assign local_buf_read_req = LOOP_N[n-4].LOOP_NN[j].LOOP_M[m].buf_read_req_fwd;
    assign local_buf_read_addr = LOOP_N[n-4].LOOP_NN[j].LOOP_M[m].buf_read_addr_fwd;
   end
*/
    assign buf_id = LOCAL_BUF_ID;
    assign buf_id_fc = LOCAL_BUF_ID * GROUP_SIZE * GROUP_SIZE + j * GROUP_SIZE + m;

  if (BUF_ID_W == 0) begin
    assign local_mem_write_addr = mem_write_addr;
    assign local_mem_write_req = mem_write_req;
    assign local_mem_write_data = mem_write_data;
  end
  else 
    begin
    assign {local_mem_write_addr, local_mem_write_buf_id} = mem_write_addr;
 /*  assign local_mem_write_req = (fc == 0)? mem_write_req && local_mem_write_buf_id[BUF_ID_W             -1 : 0 ] == buf_id[BUF_ID_W             -1 : 0 ]
             :  mem_write_req && (({local_mem_write_addr[3], local_mem_write_buf_id[BUF_ID_W             -1 : 0 ]} == {buf_id_fc[BUF_ID_W],buf_id_fc[2], ~buf_id_fc[1], buf_id_fc[0]}) || ({local_mem_write_addr[3], local_mem_write_buf_id[BUF_ID_W             -1 : 0 ]} == {buf_id_fc[BUF_ID_W],buf_id_fc[2], buf_id_fc[1], buf_id_fc[0]}));*/
    assign local_mem_write_req = mem_write_req && local_mem_write_buf_id[BUF_ID_W             -1 : 0 ] == buf_id[BUF_ID_W             -1 : 0 ];
  end

/*
    if (BUF_ID_W == 0) begin
    assign local_mem_write_addr = mem_write_addr;
    assign local_mem_write_req = mem_write_req;
    assign local_mem_write_data = mem_write_data;
  end
  else 
    begin
    assign {local_mem_write_addr, local_mem_write_buf_id} = mem_write_addr;
    assign local_mem_write_req = mem_write_req && {local_mem_write_addr[0], local_mem_write_buf_id[BUF_ID_W             -1 : 0 ]} == buf_id_fc[BUF_ID_W             -1 : 0 ];
  end
*/



  //  assign addr=local_mem_write_req?local_mem_write_addr:local_buf_read_addr;
   // assign buf_read_data[((m+GROUP_SIZE*j)+n*GROUP_SIZE*GROUP_SIZE)*64+:64] = data_o;
      always @(posedge clk)
        if(buf_read_req_fwd)
           buf_read_data[((m+GROUP_SIZE*j)+n*GROUP_SIZE*GROUP_SIZE)*64+:64] <= data_o;
        else
           buf_read_data[((m+GROUP_SIZE*j)+n*GROUP_SIZE*GROUP_SIZE)*64+:64] <= buf_read_data[((m+GROUP_SIZE*j)+n*GROUP_SIZE*GROUP_SIZE)*64+:64];

    assign data_in=mem_write_data[(m+GROUP_SIZE*j)*64+:64];


    assign ce=local_mem_write_req|local_buf_read_req;
    assign we=local_mem_write_req;

  wire cenya,cenyb,gwenya,gwenyb;


  wire  wenya;
  wire  wenyb;


  wire [1:0] soa;
  wire [1:0] sob;
  wire [MEM_DATA_WIDTH/4-1:0]d_a;

  wire [MEM_DATA_WIDTH/4-1:0]q_b;

  wire [LOCAL_ADDR_W         -1 : 0 ] aya;
  wire [LOCAL_ADDR_W         -1 : 0 ] ayb;
 // reg en_a_x,en_b_x;
  wire [LOCAL_ADDR_W         -1 : 0 ] addr_a;
  wire [LOCAL_ADDR_W         -1 : 0 ] addr_b;

sram_dp_hde_wbuf synch_sram_u1_64(
.CENYA(cenya), 
.WENYA(wenya), 
.AYA(aya), 
.CENYB(cenyb), 
.WENYB(wenyb), 
.AYB(ayb),  
.QA(data_o), 
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
.DB(data_in), 
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
.TDB(data_in), 
.RET1N(1'b1), 
.SIA(2'b00), 
.SEA(1'b0), 
.DFTRAMBYP(1'b0), 
.SIB(2'b00), 
.SEB(1'b0), 
.COLLDISN(1'b0)

   );
end
    assign weight_req[n*GROUP_SIZE + j] = (fc == 1)?weight_reqq[n*GROUP_SIZE + j]:LOOP_N[n].LOOP_NN[j].LOOP_M[1].local_buf_read_req; 
end
  
end
endgenerate

endmodule

