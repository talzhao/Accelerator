/* verilog_memcomp Version: 4.0.5-EAC1 */
/* common_memcomp Version: 4.0.5-beta22 */
/* lang compiler Version: 4.1.6-beta1 Jul 19 2012 13:55:19 */
//
//       CONFIDENTIAL AND PROPRIETARY SOFTWARE OF ARM PHYSICAL IP, INC.
//      
//       Copyright (c) 1993 - 2020 ARM Physical IP, Inc.  All Rights Reserved.
//      
//       Use of this Software is subject to the terms and conditions of the
//       applicable license agreement with ARM Physical IP, Inc.
//       In addition, this Software is protected by patents, copyright law 
//       and international treaties.
//      
//       The copyright notice(s) in this Software does not indicate actual or
//       intended publication of this Software.
//
//      Verilog model for Synchronous Dual-Port Ram
//
//       Instance Name:              sram_dp_hde_ibuf
//       Words:                      800
//       Bits:                       16
//       Mux:                        8
//       Drive:                      6
//       Write Mask:                 Off
//       Write Thru:                 Off
//       Extra Margin Adjustment:    On
//       Redundant Columns:          0
//       Test Muxes                  On
//       Power Gating:               Off
//       Retention:                  On
//       Pipeline:                   Off
//       Read Disturb Test:	        Off
//       
//       Creation Date:  Thu Aug 27 13:49:59 2020
//       Version: 	r1p1
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v3.0 or v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All buses are modeled [MSB:LSB].  All 
//          ports are padded with Verilog primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`define ARM_MEM_PROP 1.000
`define ARM_MEM_RETAIN 1.000
`define ARM_MEM_PERIOD 3.000
`define ARM_MEM_WIDTH 1.000
`define ARM_MEM_SETUP 1.000
`define ARM_MEM_HOLD 0.500
`define ARM_MEM_COLLISION 3.000
// If ARM_HVM_MODEL is defined at Simulator Command Line, it Selects the Hierarchical Verilog Model
`ifdef ARM_HVM_MODEL


module datapath_latch_sram_dp_hde_ibuf (CLK,Q_update,D_update,SE,SI,D,DFTRAMBYP,mem_path,XQ,Q);
	input CLK,Q_update,D_update,SE,SI,D,DFTRAMBYP,mem_path,XQ;
	output Q;

	reg    D_int;
	reg    Q;

   //  Model PHI2 portion
   always @(CLK or SE or SI or D) begin
      if (CLK === 1'b0) begin
         if (SE===1'b1)
           D_int=SI;
         else if (SE===1'bx)
           D_int=1'bx;
         else
           D_int=D;
      end
   end

   // model output side of RAM latch
   always @(posedge Q_update or posedge D_update or mem_path or posedge XQ) begin
      if (XQ===1'b0) begin
         if (DFTRAMBYP===1'b1)
           Q=D_int;
         else
           Q=mem_path;
      end
      else
        Q=1'bx;
   end
endmodule // datapath_latch_sram_dp_hde_ibuf

// If ARM_UD_MODEL is defined at Simulator Command Line, it Selects the Fast Functional Model
`ifdef ARM_UD_MODEL

// Following parameter Values can be overridden at Simulator Command Line.

// ARM_UD_DP Defines the delay through Data Paths, for Memory Models it represents BIST MUX output delays.
`ifdef ARM_UD_DP
`else
`define ARM_UD_DP #0.001
`endif
// ARM_UD_CP Defines the delay through Clock Path Cells, for Memory Models it is not used.
`ifdef ARM_UD_CP
`else
`define ARM_UD_CP
`endif
// ARM_UD_SEQ Defines the delay through the Memory, for Memory Models it is used for CLK->Q delays.
`ifdef ARM_UD_SEQ
`else
`define ARM_UD_SEQ #0.01
`endif

`celldefine
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
module sram_dp_hde_ibuf (VDDCE, VDDPE, VSSE, CENYA, WENYA, AYA, CENYB, WENYB, AYB,
    QA, QB, SOA, SOB, CLKA, CENA, WENA, AA, DA, CLKB, CENB, WENB, AB, DB, EMAA, EMAWA,
    EMAB, EMAWB, TENA, TCENA, TWENA, TAA, TDA, TENB, TCENB, TWENB, TAB, TDB, RET1N,
    SIA, SEA, DFTRAMBYP, SIB, SEB, COLLDISN);
`else
module sram_dp_hde_ibuf (CENYA, WENYA, AYA, CENYB, WENYB, AYB, QA, QB, SOA, SOB, CLKA,
    CENA, WENA, AA, DA, CLKB, CENB, WENB, AB, DB, EMAA, EMAWA, EMAB, EMAWB, TENA, TCENA,
    TWENA, TAA, TDA, TENB, TCENB, TWENB, TAB, TDB, RET1N, SIA, SEA, DFTRAMBYP, SIB,
    SEB, COLLDISN);
`endif

  parameter ASSERT_PREFIX = "";
  parameter BITS = 16;
  parameter WORDS = 800;
  parameter MUX = 8;
  parameter MEM_WIDTH = 128; // redun block size 4, 64 on left, 64 on right
  parameter MEM_HEIGHT = 100;
  parameter WP_SIZE = 16 ;
  parameter UPM_WIDTH = 3;
  parameter UPMW_WIDTH = 2;
  parameter UPMS_WIDTH = 0;

  output  CENYA;
  output  WENYA;
  output [9:0] AYA;
  output  CENYB;
  output  WENYB;
  output [9:0] AYB;
  output [15:0] QA;
  output [15:0] QB;
  output [1:0] SOA;
  output [1:0] SOB;
  input  CLKA;
  input  CENA;
  input  WENA;
  input [9:0] AA;
  input [15:0] DA;
  input  CLKB;
  input  CENB;
  input  WENB;
  input [9:0] AB;
  input [15:0] DB;
  input [2:0] EMAA;
  input [1:0] EMAWA;
  input [2:0] EMAB;
  input [1:0] EMAWB;
  input  TENA;
  input  TCENA;
  input  TWENA;
  input [9:0] TAA;
  input [15:0] TDA;
  input  TENB;
  input  TCENB;
  input  TWENB;
  input [9:0] TAB;
  input [15:0] TDB;
  input  RET1N;
  input [1:0] SIA;
  input  SEA;
  input  DFTRAMBYP;
  input [1:0] SIB;
  input  SEB;
  input  COLLDISN;
`ifdef POWER_PINS
  inout VDDCE;
  inout VDDPE;
  inout VSSE;
`endif

  reg pre_charge_st;
  reg pre_charge_st_a;
  reg pre_charge_st_b;
  integer row_address;
  integer mux_address;
  reg [127:0] mem [0:99];
  reg [127:0] row, row_t;
  reg LAST_CLKA;
  reg [127:0] row_mask;
  reg [127:0] new_data;
  reg [127:0] data_out;
  reg [31:0] readLatch0;
  reg [31:0] shifted_readLatch0;
  reg  read_mux_sel0;
  reg  read_mux_sel0_p2;
  reg [31:0] readLatch1;
  reg [31:0] shifted_readLatch1;
  reg  read_mux_sel1;
  reg  read_mux_sel1_p2;
  reg LAST_CLKB;
  wire [15:0] QA_int;
  reg XQA, QA_update;
  reg XDA_sh, DA_sh_update;
  wire [15:0] DA_int_bmux;
  reg [15:0] mem_path_A;
  wire [15:0] QB_int;
  reg XQB, QB_update;
  reg XDB_sh, DB_sh_update;
  wire [15:0] DB_int_bmux;
  reg [15:0] mem_path_B;
  reg [15:0] writeEnable;
  real previous_CLKA;
  real previous_CLKB;
  initial previous_CLKA = 0;
  initial previous_CLKB = 0;
  reg READ_WRITE, WRITE_WRITE, READ_READ, ROW_CC, COL_CC;
  reg READ_WRITE_1, WRITE_WRITE_1, READ_READ_1;
  reg  cont_flag0_int;
  reg  cont_flag1_int;
  initial cont_flag0_int = 1'b0;
  initial cont_flag1_int = 1'b0;
  reg clk0_int;
  reg clk1_int;

  wire  CENYA_;
  wire  WENYA_;
  wire [9:0] AYA_;
  wire  CENYB_;
  wire  WENYB_;
  wire [9:0] AYB_;
  wire [15:0] QA_;
  wire [15:0] QB_;
  wire [1:0] SOA_;
  wire [1:0] SOB_;
 wire  CLKA_;
  wire  CENA_;
  reg  CENA_int;
  reg  CENA_p2;
  wire  WENA_;
  reg  WENA_int;
  wire [9:0] AA_;
  reg [9:0] AA_int;
  wire [15:0] DA_;
  reg [15:0] DA_int;
 wire  CLKB_;
  wire  CENB_;
  reg  CENB_int;
  reg  CENB_p2;
  wire  WENB_;
  reg  WENB_int;
  wire [9:0] AB_;
  reg [9:0] AB_int;
  wire [15:0] DB_;
  reg [15:0] DB_int;
  wire [2:0] EMAA_;
  reg [2:0] EMAA_int;
  wire [1:0] EMAWA_;
  reg [1:0] EMAWA_int;
  wire [2:0] EMAB_;
  reg [2:0] EMAB_int;
  wire [1:0] EMAWB_;
  reg [1:0] EMAWB_int;
  wire  TENA_;
  reg  TENA_int;
  wire  TCENA_;
  reg  TCENA_int;
  reg  TCENA_p2;
  wire  TWENA_;
  reg  TWENA_int;
  wire [9:0] TAA_;
  reg [9:0] TAA_int;
  wire [15:0] TDA_;
  reg [15:0] TDA_int;
  wire  TENB_;
  reg  TENB_int;
  wire  TCENB_;
  reg  TCENB_int;
  reg  TCENB_p2;
  wire  TWENB_;
  reg  TWENB_int;
  wire [9:0] TAB_;
  reg [9:0] TAB_int;
  wire [15:0] TDB_;
  reg [15:0] TDB_int;
  wire  RET1N_;
  reg  RET1N_int;
  wire [1:0] SIA_;
  wire [1:0] SIA_int;
  wire  SEA_;
  reg  SEA_int;
  wire  DFTRAMBYP_;
  reg  DFTRAMBYP_int;
  reg  DFTRAMBYP_p2;
  wire [1:0] SIB_;
  wire [1:0] SIB_int;
  wire  SEB_;
  reg  SEB_int;
  wire  COLLDISN_;
  reg  COLLDISN_int;

  assign CENYA = CENYA_; 
  assign WENYA = WENYA_; 
  assign AYA[0] = AYA_[0]; 
  assign AYA[1] = AYA_[1]; 
  assign AYA[2] = AYA_[2]; 
  assign AYA[3] = AYA_[3]; 
  assign AYA[4] = AYA_[4]; 
  assign AYA[5] = AYA_[5]; 
  assign AYA[6] = AYA_[6]; 
  assign AYA[7] = AYA_[7]; 
  assign AYA[8] = AYA_[8]; 
  assign AYA[9] = AYA_[9]; 
  assign CENYB = CENYB_; 
  assign WENYB = WENYB_; 
  assign AYB[0] = AYB_[0]; 
  assign AYB[1] = AYB_[1]; 
  assign AYB[2] = AYB_[2]; 
  assign AYB[3] = AYB_[3]; 
  assign AYB[4] = AYB_[4]; 
  assign AYB[5] = AYB_[5]; 
  assign AYB[6] = AYB_[6]; 
  assign AYB[7] = AYB_[7]; 
  assign AYB[8] = AYB_[8]; 
  assign AYB[9] = AYB_[9]; 
  assign QA[0] = QA_[0]; 
  assign QA[1] = QA_[1]; 
  assign QA[2] = QA_[2]; 
  assign QA[3] = QA_[3]; 
  assign QA[4] = QA_[4]; 
  assign QA[5] = QA_[5]; 
  assign QA[6] = QA_[6]; 
  assign QA[7] = QA_[7]; 
  assign QA[8] = QA_[8]; 
  assign QA[9] = QA_[9]; 
  assign QA[10] = QA_[10]; 
  assign QA[11] = QA_[11]; 
  assign QA[12] = QA_[12]; 
  assign QA[13] = QA_[13]; 
  assign QA[14] = QA_[14]; 
  assign QA[15] = QA_[15]; 
  assign QB[0] = QB_[0]; 
  assign QB[1] = QB_[1]; 
  assign QB[2] = QB_[2]; 
  assign QB[3] = QB_[3]; 
  assign QB[4] = QB_[4]; 
  assign QB[5] = QB_[5]; 
  assign QB[6] = QB_[6]; 
  assign QB[7] = QB_[7]; 
  assign QB[8] = QB_[8]; 
  assign QB[9] = QB_[9]; 
  assign QB[10] = QB_[10]; 
  assign QB[11] = QB_[11]; 
  assign QB[12] = QB_[12]; 
  assign QB[13] = QB_[13]; 
  assign QB[14] = QB_[14]; 
  assign QB[15] = QB_[15]; 
  assign SOA[0] = SOA_[0]; 
  assign SOA[1] = SOA_[1]; 
  assign SOB[0] = SOB_[0]; 
  assign SOB[1] = SOB_[1]; 
  assign CLKA_ = CLKA;
  assign CENA_ = CENA;
  assign WENA_ = WENA;
  assign AA_[0] = AA[0];
  assign AA_[1] = AA[1];
  assign AA_[2] = AA[2];
  assign AA_[3] = AA[3];
  assign AA_[4] = AA[4];
  assign AA_[5] = AA[5];
  assign AA_[6] = AA[6];
  assign AA_[7] = AA[7];
  assign AA_[8] = AA[8];
  assign AA_[9] = AA[9];
  assign DA_[0] = DA[0];
  assign DA_[1] = DA[1];
  assign DA_[2] = DA[2];
  assign DA_[3] = DA[3];
  assign DA_[4] = DA[4];
  assign DA_[5] = DA[5];
  assign DA_[6] = DA[6];
  assign DA_[7] = DA[7];
  assign DA_[8] = DA[8];
  assign DA_[9] = DA[9];
  assign DA_[10] = DA[10];
  assign DA_[11] = DA[11];
  assign DA_[12] = DA[12];
  assign DA_[13] = DA[13];
  assign DA_[14] = DA[14];
  assign DA_[15] = DA[15];
  assign CLKB_ = CLKB;
  assign CENB_ = CENB;
  assign WENB_ = WENB;
  assign AB_[0] = AB[0];
  assign AB_[1] = AB[1];
  assign AB_[2] = AB[2];
  assign AB_[3] = AB[3];
  assign AB_[4] = AB[4];
  assign AB_[5] = AB[5];
  assign AB_[6] = AB[6];
  assign AB_[7] = AB[7];
  assign AB_[8] = AB[8];
  assign AB_[9] = AB[9];
  assign DB_[0] = DB[0];
  assign DB_[1] = DB[1];
  assign DB_[2] = DB[2];
  assign DB_[3] = DB[3];
  assign DB_[4] = DB[4];
  assign DB_[5] = DB[5];
  assign DB_[6] = DB[6];
  assign DB_[7] = DB[7];
  assign DB_[8] = DB[8];
  assign DB_[9] = DB[9];
  assign DB_[10] = DB[10];
  assign DB_[11] = DB[11];
  assign DB_[12] = DB[12];
  assign DB_[13] = DB[13];
  assign DB_[14] = DB[14];
  assign DB_[15] = DB[15];
  assign EMAA_[0] = EMAA[0];
  assign EMAA_[1] = EMAA[1];
  assign EMAA_[2] = EMAA[2];
  assign EMAWA_[0] = EMAWA[0];
  assign EMAWA_[1] = EMAWA[1];
  assign EMAB_[0] = EMAB[0];
  assign EMAB_[1] = EMAB[1];
  assign EMAB_[2] = EMAB[2];
  assign EMAWB_[0] = EMAWB[0];
  assign EMAWB_[1] = EMAWB[1];
  assign TENA_ = TENA;
  assign TCENA_ = TCENA;
  assign TWENA_ = TWENA;
  assign TAA_[0] = TAA[0];
  assign TAA_[1] = TAA[1];
  assign TAA_[2] = TAA[2];
  assign TAA_[3] = TAA[3];
  assign TAA_[4] = TAA[4];
  assign TAA_[5] = TAA[5];
  assign TAA_[6] = TAA[6];
  assign TAA_[7] = TAA[7];
  assign TAA_[8] = TAA[8];
  assign TAA_[9] = TAA[9];
  assign TDA_[0] = TDA[0];
  assign TDA_[1] = TDA[1];
  assign TDA_[2] = TDA[2];
  assign TDA_[3] = TDA[3];
  assign TDA_[4] = TDA[4];
  assign TDA_[5] = TDA[5];
  assign TDA_[6] = TDA[6];
  assign TDA_[7] = TDA[7];
  assign TDA_[8] = TDA[8];
  assign TDA_[9] = TDA[9];
  assign TDA_[10] = TDA[10];
  assign TDA_[11] = TDA[11];
  assign TDA_[12] = TDA[12];
  assign TDA_[13] = TDA[13];
  assign TDA_[14] = TDA[14];
  assign TDA_[15] = TDA[15];
  assign TENB_ = TENB;
  assign TCENB_ = TCENB;
  assign TWENB_ = TWENB;
  assign TAB_[0] = TAB[0];
  assign TAB_[1] = TAB[1];
  assign TAB_[2] = TAB[2];
  assign TAB_[3] = TAB[3];
  assign TAB_[4] = TAB[4];
  assign TAB_[5] = TAB[5];
  assign TAB_[6] = TAB[6];
  assign TAB_[7] = TAB[7];
  assign TAB_[8] = TAB[8];
  assign TAB_[9] = TAB[9];
  assign TDB_[0] = TDB[0];
  assign TDB_[1] = TDB[1];
  assign TDB_[2] = TDB[2];
  assign TDB_[3] = TDB[3];
  assign TDB_[4] = TDB[4];
  assign TDB_[5] = TDB[5];
  assign TDB_[6] = TDB[6];
  assign TDB_[7] = TDB[7];
  assign TDB_[8] = TDB[8];
  assign TDB_[9] = TDB[9];
  assign TDB_[10] = TDB[10];
  assign TDB_[11] = TDB[11];
  assign TDB_[12] = TDB[12];
  assign TDB_[13] = TDB[13];
  assign TDB_[14] = TDB[14];
  assign TDB_[15] = TDB[15];
  assign RET1N_ = RET1N;
  assign SIA_[0] = SIA[0];
  assign SIA_[1] = SIA[1];
  assign SEA_ = SEA;
  assign DFTRAMBYP_ = DFTRAMBYP;
  assign SIB_[0] = SIB[0];
  assign SIB_[1] = SIB[1];
  assign SEB_ = SEB;
  assign COLLDISN_ = COLLDISN;

  assign `ARM_UD_DP CENYA_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENA_ ? CENA_ : TCENA_)) : 1'bx;
  assign `ARM_UD_DP WENYA_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENA_ ? WENA_ : TWENA_)) : 1'bx;
  assign `ARM_UD_DP AYA_ = (RET1N_ | pre_charge_st) ? ({10{DFTRAMBYP_}} & (TENA_ ? AA_ : TAA_)) : {10{1'bx}};
  assign `ARM_UD_DP CENYB_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENB_ ? CENB_ : TCENB_)) : 1'bx;
  assign `ARM_UD_DP WENYB_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENB_ ? WENB_ : TWENB_)) : 1'bx;
  assign `ARM_UD_DP AYB_ = (RET1N_ | pre_charge_st) ? ({10{DFTRAMBYP_}} & (TENB_ ? AB_ : TAB_)) : {10{1'bx}};
  assign `ARM_UD_SEQ QA_ = (RET1N_ | pre_charge_st) ? ((QA_int)) : {16{1'bx}};
  assign `ARM_UD_SEQ QB_ = (RET1N_ | pre_charge_st) ? ((QB_int)) : {16{1'bx}};
  assign `ARM_UD_DP SOA_ = (RET1N_ | pre_charge_st) ? ({QA_[8], QA_[7]}) : {2{1'bx}};
  assign `ARM_UD_DP SOB_ = (RET1N_ | pre_charge_st) ? ({QB_[8], QB_[7]}) : {2{1'bx}};

// If INITIALIZE_MEMORY is defined at Simulator Command Line, it Initializes the Memory with all ZEROS.
`ifdef INITIALIZE_MEMORY
  integer i;
  initial begin
    #0;
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'b0}};
  end
`endif
  always @ (EMAA_) begin
  	if(EMAA_ < 2) 
   	$display("Warning: Set Value for EMAA doesn't match Default value 2 in %m at %0t", $time);
  end
  always @ (EMAWA_) begin
  	if(EMAWA_ < 0) 
   	$display("Warning: Set Value for EMAWA doesn't match Default value 0 in %m at %0t", $time);
  end
  always @ (EMAB_) begin
  	if(EMAB_ < 2) 
   	$display("Warning: Set Value for EMAB doesn't match Default value 2 in %m at %0t", $time);
  end
  always @ (EMAWB_) begin
  	if(EMAWB_ < 0) 
   	$display("Warning: Set Value for EMAWB doesn't match Default value 0 in %m at %0t", $time);
  end

  task failedWrite;
  input port_f;
  integer i;
  begin
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'bx}};
  end
  endtask

  function isBitX;
    input bitval;
    begin
      isBitX = ( bitval===1'bx || bitval==1'bz ) ? 1'b1 : 1'b0;
    end
  endfunction

  function isBit1;
    input bitval;
    begin
      isBit1 = ( bitval===1'b1 ) ? 1'b1 : 1'b0;
    end
  endfunction



  task readWriteA;
  begin
    if (WENA_int !== 1'b1 && DFTRAMBYP_int=== 1'b0 && SEA_int === 1'bx) begin
      failedWrite(0);
    end else if (DFTRAMBYP_int=== 1'b0 && SEA_int === 1'b1) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (RET1N_int === 1'bx || RET1N_int === 1'bz) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (RET1N_int === 1'b0 && (CENA_int === 1'b0 || DFTRAMBYP_int === 1'b1)) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (RET1N_int === 1'b0) begin
      // no cycle in retention mode
    end else if (^{(EMAA_int & isBit1(DFTRAMBYP_int)), (EMAWA_int & isBit1(DFTRAMBYP_int))} === 1'bx) begin
        XQA = 1'b1; QA_update = 1'b1;
    end else if (^{(CENA_int & !isBit1(DFTRAMBYP_int)), EMAA_int, EMAWA_int, RET1N_int} === 1'bx) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if ((AA_int >= WORDS) && (CENA_int === 1'b0) && DFTRAMBYP_int === 1'b0) begin
        XQA = WENA_int !== 1'b1 ? 1'b0 : 1'b1; QA_update = WENA_int !== 1'b1 ? 1'b0 : 1'b1;
    end else if (CENA_int === 1'b0 && (^AA_int) === 1'bx && DFTRAMBYP_int === 1'b0) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (CENA_int === 1'b0 || DFTRAMBYP_int === 1'b1) begin
      if(isBitX(DFTRAMBYP_int) || isBitX(SEA_int))
        DA_int = {16{1'bx}};

      mux_address = (AA_int & 3'b111);
      row_address = (AA_int >> 3);
      if (DFTRAMBYP_int !== 1'b1) begin
      if (row_address > 99)
        row = {128{1'bx}};
      else
        row = mem[row_address];
      end
      if(isBitX(DFTRAMBYP_int) || (isBitX(WENA_int) && DFTRAMBYP_int!==1)) begin
        writeEnable = {16{1'bx}};
        DA_int = {16{1'bx}};
      end else
          writeEnable = ~ {16{WENA_int}};
      if (WENA_int !== 1'b1 || DFTRAMBYP_int === 1'b1 || DFTRAMBYP_int === 1'bx) begin
        row_mask =  ( {7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14], 7'b0000000, writeEnable[13],
          7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11], 7'b0000000, writeEnable[10],
          7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8], 7'b0000000, writeEnable[7],
          7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5], 7'b0000000, writeEnable[4],
          7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2], 7'b0000000, writeEnable[1],
          7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, DA_int[15], 7'b0000000, DA_int[14], 7'b0000000, DA_int[13],
          7'b0000000, DA_int[12], 7'b0000000, DA_int[11], 7'b0000000, DA_int[10], 7'b0000000, DA_int[9],
          7'b0000000, DA_int[8], 7'b0000000, DA_int[7], 7'b0000000, DA_int[6], 7'b0000000, DA_int[5],
          7'b0000000, DA_int[4], 7'b0000000, DA_int[3], 7'b0000000, DA_int[2], 7'b0000000, DA_int[1],
          7'b0000000, DA_int[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        if (DFTRAMBYP_int === 1'b1 && SEA_int === 1'b0) begin
        end else if (WENA_int !== 1'b1 && DFTRAMBYP_int === 1'b1 && SEA_int === 1'bx) begin
        	XQA = 1'b1; QA_update = 1'b1;
        end else begin
        mem[row_address] = row;
        end
      end else begin
        data_out = (row >> (mux_address%4));
        readLatch0 = {data_out[124], data_out[120], data_out[116], data_out[112], data_out[108],
          data_out[104], data_out[100], data_out[96], data_out[92], data_out[88], data_out[84],
          data_out[80], data_out[76], data_out[72], data_out[68], data_out[64], data_out[60],
          data_out[56], data_out[52], data_out[48], data_out[44], data_out[40], data_out[36],
          data_out[32], data_out[28], data_out[24], data_out[20], data_out[16], data_out[12],
          data_out[8], data_out[4], data_out[0]};
        shifted_readLatch0 = (readLatch0 >> AA_int[2]);
        mem_path_A = {shifted_readLatch0[30], shifted_readLatch0[28], shifted_readLatch0[26],
          shifted_readLatch0[24], shifted_readLatch0[22], shifted_readLatch0[20], shifted_readLatch0[18],
          shifted_readLatch0[16], shifted_readLatch0[14], shifted_readLatch0[12], shifted_readLatch0[10],
          shifted_readLatch0[8], shifted_readLatch0[6], shifted_readLatch0[4], shifted_readLatch0[2],
          shifted_readLatch0[0]};
        	XQA = 1'b0; QA_update = 1'b1;
      end
      if (DFTRAMBYP_int === 1'b1) begin
        	XQA = 1'b0; QA_update = 1'b1;
      end
      if( isBitX(WENA_int) && DFTRAMBYP_int !== 1'b1) begin
        XQA = 1'b1; QA_update = 1'b1;
      end
      if( isBitX(DFTRAMBYP_int) ) begin
        XQA = 1'b1; QA_update = 1'b1;
      end
      if( isBitX(SEA_int) && DFTRAMBYP_int === 1'b1 ) begin
        XQA = 1'b1; QA_update = 1'b1;
      end
    end
  end
  endtask
  always @ (CENA_ or TCENA_ or TENA_ or DFTRAMBYP_ or CLKA_) begin
  	if(CLKA_ == 1'b0) begin
  		CENA_p2 = CENA_;
  		TCENA_p2 = TCENA_;
  		DFTRAMBYP_p2 = DFTRAMBYP_;
  	end
  end

`ifdef POWER_PINS
  always @ (VDDCE) begin
      if (VDDCE != 1'b1) begin
       if (VDDPE == 1'b1) begin
        $display("VDDCE should be powered down after VDDPE, Illegal power down sequencing in %m at %0t", $time);
       end
        $display("In PowerDown Mode in %m at %0t", $time);
        failedWrite(0);
      end
      if (VDDCE == 1'b1) begin
       if (VDDPE == 1'b1) begin
        $display("VDDPE should be powered up after VDDCE in %m at %0t", $time);
        $display("Illegal power up sequencing in %m at %0t", $time);
       end
        failedWrite(0);
      end
  end
`endif
`ifdef POWER_PINS
  always @ (RET1N_ or VDDPE or VDDCE) begin
`else     
  always @ RET1N_ begin
`endif
`ifdef POWER_PINS
    if (RET1N_ == 1'b1 && RET1N_int == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 && pre_charge_st_a == 1'b1 && (CENA_ === 1'bx || TCENA_ === 1'bx || DFTRAMBYP_ === 1'bx || CLKA_ === 1'bx)) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end
`else     
`endif
`ifdef POWER_PINS
`else     
      pre_charge_st_a = 0;
      pre_charge_st = 0;
`endif
    if (RET1N_ === 1'bx || RET1N_ === 1'bz) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (RET1N_ === 1'b0 && RET1N_int === 1'b1 && (CENA_p2 === 1'b0 || TCENA_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (RET1N_ === 1'b1 && RET1N_int === 1'b0 && (CENA_p2 === 1'b0 || TCENA_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end
`ifdef POWER_PINS
    if (RET1N_ == 1'b0 && VDDCE == 1'b1 && VDDPE == 1'b1) begin
      pre_charge_st_a = 1;
      pre_charge_st = 1;
    end else if (RET1N_ == 1'b0 && VDDPE == 1'b0) begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
      if (VDDCE != 1'b1) begin
        failedWrite(0);
      end
`else     
    if (RET1N_ == 1'b0) begin
`endif
        XQA = 1'b1; QA_update = 1'b1;
      CENA_int = 1'bx;
      WENA_int = 1'bx;
      AA_int = {10{1'bx}};
      DA_int = {16{1'bx}};
      EMAA_int = {3{1'bx}};
      EMAWA_int = {2{1'bx}};
      TENA_int = 1'bx;
      TCENA_int = 1'bx;
      TWENA_int = 1'bx;
      TAA_int = {10{1'bx}};
      TDA_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SEA_int = 1'bx;
      DFTRAMBYP_int = 1'bx;
      COLLDISN_int = 1'bx;
`ifdef POWER_PINS
    end else if (RET1N_ == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 &&  pre_charge_st_a == 1'b1) begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
    end else begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
`else     
    end else begin
`endif
        XQA = 1'b1; QA_update = 1'b1;
      CENA_int = 1'bx;
      WENA_int = 1'bx;
      AA_int = {10{1'bx}};
      DA_int = {16{1'bx}};
      EMAA_int = {3{1'bx}};
      EMAWA_int = {2{1'bx}};
      TENA_int = 1'bx;
      TCENA_int = 1'bx;
      TWENA_int = 1'bx;
      TAA_int = {10{1'bx}};
      TDA_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SEA_int = 1'bx;
      DFTRAMBYP_int = 1'bx;
      COLLDISN_int = 1'bx;
    end
    RET1N_int = RET1N_;
    #0;
        QA_update = 1'b0;
  end


  always @ CLKA_ begin
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
`endif
`ifdef POWER_PINS
  if (RET1N_ == 1'b0) begin
`else     
  if (RET1N_ == 1'b0) begin
`endif
      // no cycle in retention mode
  end else begin
    if ((CLKA_ === 1'bx || CLKA_ === 1'bz) && RET1N_ !== 1'b0) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if ((CLKA_ === 1'b1 || CLKA_ === 1'b0) && LAST_CLKA === 1'bx) begin
       DA_sh_update = 1'b0;  XDA_sh = 1'b0;
       XQA = 1'b0; QA_update = 1'b0; 
    end else if (CLKA_ === 1'b1 && LAST_CLKA === 1'b0) begin
      SEA_int = SEA_;
      DFTRAMBYP_int = DFTRAMBYP_;
      CENA_int = TENA_ ? CENA_ : TCENA_;
      EMAA_int = EMAA_;
      EMAWA_int = EMAWA_;
      TENA_int = TENA_;
      TWENA_int = TWENA_;
      RET1N_int = RET1N_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENA_int != 1'b1) begin
        WENA_int = TENA_ ? WENA_ : TWENA_;
        AA_int = TENA_ ? AA_ : TAA_;
        DA_int = TENA_ ? DA_ : TDA_;
        TCENA_int = TCENA_;
        TAA_int = TAA_;
        TDA_int = TDA_;
        DFTRAMBYP_int = DFTRAMBYP_;
        if (WENA_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
          read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
        end
      end
      clk0_int = 1'b0;
      if (DFTRAMBYP_=== 1'b1 && SEA_ === 1'b1) begin
         read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
         read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
        XQA = 1'b0; QA_update = 1'b1;
      end else begin
      CENA_int = TENA_ ? CENA_ : TCENA_;
      EMAA_int = EMAA_;
      EMAWA_int = EMAWA_;
      TENA_int = TENA_;
      TWENA_int = TWENA_;
      RET1N_int = RET1N_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENA_int != 1'b1) begin
        WENA_int = TENA_ ? WENA_ : TWENA_;
        AA_int = TENA_ ? AA_ : TAA_;
        DA_int = TENA_ ? DA_ : TDA_;
        TCENA_int = TCENA_;
        TAA_int = TAA_;
        TDA_int = TDA_;
        DFTRAMBYP_int = DFTRAMBYP_;
        if (WENA_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
          read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
        end
      end
      clk0_int = 1'b0;
      if (CENA_int === 1'b0) previous_CLKA = $realtime;
    readWriteA;
      end
    #0;
      if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && COLLDISN_int === 1'b1 && row_contention(AA_int,
        AB_int, WENA_int, WENB_int)) begin
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQB = 1'b1; QB_update = 1'b1;
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQA = 1'b1; QA_update = 1'b1;
		end
        end else begin
          readWriteB;
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteB;
          readWriteA;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
      end else if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && (COLLDISN_int === 1'b0 || COLLDISN_int 
       === 1'bx)  && row_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
        XQB = 1'b1; QB_update = 1'b1;
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE_1 = 1;
          READ_READ_1 = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
        XQA = 1'b1; QA_update = 1'b1;
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
      end
    end else if (CLKA_ === 1'b0 && LAST_CLKA === 1'b1) begin
      QA_update = 1'b0;
      DA_sh_update = 1'b0;
      XQA = 1'b0;
         read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
    end
  end
    LAST_CLKA = CLKA_;
  end

  assign SIA_int = SEA_ ? SIA_ : {2{1'b0}};
  assign DA_int_bmux = TENA_ ? DA_ : TDA_;

  datapath_latch_sram_dp_hde_ibuf uDQA0 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(SIA_int[0]), .D(DA_int_bmux[0]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[0]), .XQ(XQA), .Q(QA_int[0]));
  datapath_latch_sram_dp_hde_ibuf uDQA1 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[0]), .D(DA_int_bmux[1]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[1]), .XQ(XQA), .Q(QA_int[1]));
  datapath_latch_sram_dp_hde_ibuf uDQA2 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[1]), .D(DA_int_bmux[2]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[2]), .XQ(XQA), .Q(QA_int[2]));
  datapath_latch_sram_dp_hde_ibuf uDQA3 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[2]), .D(DA_int_bmux[3]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[3]), .XQ(XQA), .Q(QA_int[3]));
  datapath_latch_sram_dp_hde_ibuf uDQA4 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[3]), .D(DA_int_bmux[4]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[4]), .XQ(XQA), .Q(QA_int[4]));
  datapath_latch_sram_dp_hde_ibuf uDQA5 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[4]), .D(DA_int_bmux[5]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[5]), .XQ(XQA), .Q(QA_int[5]));
  datapath_latch_sram_dp_hde_ibuf uDQA6 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[5]), .D(DA_int_bmux[6]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[6]), .XQ(XQA), .Q(QA_int[6]));
  datapath_latch_sram_dp_hde_ibuf uDQA7 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[6]), .D(DA_int_bmux[7]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[7]), .XQ(XQA), .Q(QA_int[7]));
  datapath_latch_sram_dp_hde_ibuf uDQA8 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[9]), .D(DA_int_bmux[8]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[8]), .XQ(XQA), .Q(QA_int[8]));
  datapath_latch_sram_dp_hde_ibuf uDQA9 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[10]), .D(DA_int_bmux[9]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[9]), .XQ(XQA), .Q(QA_int[9]));
  datapath_latch_sram_dp_hde_ibuf uDQA10 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[11]), .D(DA_int_bmux[10]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[10]), .XQ(XQA), .Q(QA_int[10]));
  datapath_latch_sram_dp_hde_ibuf uDQA11 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[12]), .D(DA_int_bmux[11]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[11]), .XQ(XQA), .Q(QA_int[11]));
  datapath_latch_sram_dp_hde_ibuf uDQA12 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[13]), .D(DA_int_bmux[12]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[12]), .XQ(XQA), .Q(QA_int[12]));
  datapath_latch_sram_dp_hde_ibuf uDQA13 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[14]), .D(DA_int_bmux[13]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[13]), .XQ(XQA), .Q(QA_int[13]));
  datapath_latch_sram_dp_hde_ibuf uDQA14 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[15]), .D(DA_int_bmux[14]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[14]), .XQ(XQA), .Q(QA_int[14]));
  datapath_latch_sram_dp_hde_ibuf uDQA15 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(SIA_int[1]), .D(DA_int_bmux[15]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[15]), .XQ(XQA), .Q(QA_int[15]));



  task readWriteB;
  begin
    if (WENB_int !== 1'b1 && DFTRAMBYP_int=== 1'b0 && SEB_int === 1'bx) begin
      failedWrite(1);
    end else if (DFTRAMBYP_int=== 1'b0 && SEB_int === 1'b1) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (RET1N_int === 1'bx || RET1N_int === 1'bz) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (RET1N_int === 1'b0 && (CENB_int === 1'b0 || DFTRAMBYP_int === 1'b1)) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (RET1N_int === 1'b0) begin
      // no cycle in retention mode
    end else if (^{(EMAB_int & isBit1(DFTRAMBYP_int)), (EMAWB_int & isBit1(DFTRAMBYP_int))} === 1'bx) begin
        XQB = 1'b1; QB_update = 1'b1;
    end else if (^{(CENB_int & !isBit1(DFTRAMBYP_int)), EMAB_int, EMAWB_int, RET1N_int} === 1'bx) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if ((AB_int >= WORDS) && (CENB_int === 1'b0) && DFTRAMBYP_int === 1'b0) begin
        XQB = WENB_int !== 1'b1 ? 1'b0 : 1'b1; QB_update = WENB_int !== 1'b1 ? 1'b0 : 1'b1;
    end else if (CENB_int === 1'b0 && (^AB_int) === 1'bx && DFTRAMBYP_int === 1'b0) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (CENB_int === 1'b0 || DFTRAMBYP_int === 1'b1) begin
      if(isBitX(DFTRAMBYP_int) || isBitX(SEB_int))
        DB_int = {16{1'bx}};

      mux_address = (AB_int & 3'b111);
      row_address = (AB_int >> 3);
      if (DFTRAMBYP_int !== 1'b1) begin
      if (row_address > 99)
        row = {128{1'bx}};
      else
        row = mem[row_address];
      end
      if(isBitX(DFTRAMBYP_int) || (isBitX(WENB_int) && DFTRAMBYP_int!==1)) begin
        writeEnable = {16{1'bx}};
        DB_int = {16{1'bx}};
      end else
          writeEnable = ~ {16{WENB_int}};
      if (WENB_int !== 1'b1 || DFTRAMBYP_int === 1'b1 || DFTRAMBYP_int === 1'bx) begin
        row_mask =  ( {7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14], 7'b0000000, writeEnable[13],
          7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11], 7'b0000000, writeEnable[10],
          7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8], 7'b0000000, writeEnable[7],
          7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5], 7'b0000000, writeEnable[4],
          7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2], 7'b0000000, writeEnable[1],
          7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, DB_int[15], 7'b0000000, DB_int[14], 7'b0000000, DB_int[13],
          7'b0000000, DB_int[12], 7'b0000000, DB_int[11], 7'b0000000, DB_int[10], 7'b0000000, DB_int[9],
          7'b0000000, DB_int[8], 7'b0000000, DB_int[7], 7'b0000000, DB_int[6], 7'b0000000, DB_int[5],
          7'b0000000, DB_int[4], 7'b0000000, DB_int[3], 7'b0000000, DB_int[2], 7'b0000000, DB_int[1],
          7'b0000000, DB_int[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        if (DFTRAMBYP_int === 1'b1 && SEB_int === 1'b0) begin
        end else if (WENB_int !== 1'b1 && DFTRAMBYP_int === 1'b1 && SEB_int === 1'bx) begin
        	XQB = 1'b1; QB_update = 1'b1;
        end else begin
        mem[row_address] = row;
        end
      end else begin
        data_out = (row >> (mux_address%4));
        readLatch1 = {data_out[124], data_out[120], data_out[116], data_out[112], data_out[108],
          data_out[104], data_out[100], data_out[96], data_out[92], data_out[88], data_out[84],
          data_out[80], data_out[76], data_out[72], data_out[68], data_out[64], data_out[60],
          data_out[56], data_out[52], data_out[48], data_out[44], data_out[40], data_out[36],
          data_out[32], data_out[28], data_out[24], data_out[20], data_out[16], data_out[12],
          data_out[8], data_out[4], data_out[0]};
        shifted_readLatch1 = (readLatch1 >> AB_int[2]);
        mem_path_B = {shifted_readLatch1[30], shifted_readLatch1[28], shifted_readLatch1[26],
          shifted_readLatch1[24], shifted_readLatch1[22], shifted_readLatch1[20], shifted_readLatch1[18],
          shifted_readLatch1[16], shifted_readLatch1[14], shifted_readLatch1[12], shifted_readLatch1[10],
          shifted_readLatch1[8], shifted_readLatch1[6], shifted_readLatch1[4], shifted_readLatch1[2],
          shifted_readLatch1[0]};
        	XQB = 1'b0; QB_update = 1'b1;
      end
      if (DFTRAMBYP_int === 1'b1) begin
        	XQB = 1'b0; QB_update = 1'b1;
      end
      if( isBitX(WENB_int) && DFTRAMBYP_int !== 1'b1) begin
        XQB = 1'b1; QB_update = 1'b1;
      end
      if( isBitX(DFTRAMBYP_int) ) begin
        XQB = 1'b1; QB_update = 1'b1;
      end
      if( isBitX(SEB_int) && DFTRAMBYP_int === 1'b1 ) begin
        XQB = 1'b1; QB_update = 1'b1;
      end
    end
  end
  endtask
  always @ (CENB_ or TCENB_ or TENB_ or DFTRAMBYP_ or CLKB_) begin
  	if(CLKB_ == 1'b0) begin
  		CENB_p2 = CENB_;
  		TCENB_p2 = TCENB_;
  		DFTRAMBYP_p2 = DFTRAMBYP_;
  	end
  end

`ifdef POWER_PINS
  always @ (RET1N_ or VDDPE or VDDCE) begin
`else     
  always @ RET1N_ begin
`endif
`ifdef POWER_PINS
    if (RET1N_ == 1'b1 && RET1N_int == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 && pre_charge_st_b == 1'b1 && (CENB_ === 1'bx || TCENB_ === 1'bx || DFTRAMBYP_ === 1'bx || CLKB_ === 1'bx)) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end
`else     
`endif
`ifdef POWER_PINS
`else     
      pre_charge_st_b = 0;
      pre_charge_st = 0;
`endif
    if (RET1N_ === 1'bx || RET1N_ === 1'bz) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (RET1N_ === 1'b0 && RET1N_int === 1'b1 && (CENB_p2 === 1'b0 || TCENB_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (RET1N_ === 1'b1 && RET1N_int === 1'b0 && (CENB_p2 === 1'b0 || TCENB_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end
`ifdef POWER_PINS
    if (RET1N_ == 1'b0 && VDDCE == 1'b1 && VDDPE == 1'b1) begin
      pre_charge_st_b = 1;
      pre_charge_st = 1;
    end else if (RET1N_ == 1'b0 && VDDPE == 1'b0) begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
      if (VDDCE != 1'b1) begin
        failedWrite(1);
      end
`else     
    if (RET1N_ == 1'b0) begin
`endif
        XQB = 1'b1; QB_update = 1'b1;
      CENB_int = 1'bx;
      WENB_int = 1'bx;
      AB_int = {10{1'bx}};
      DB_int = {16{1'bx}};
      EMAB_int = {3{1'bx}};
      EMAWB_int = {2{1'bx}};
      TENB_int = 1'bx;
      TCENB_int = 1'bx;
      TWENB_int = 1'bx;
      TAB_int = {10{1'bx}};
      TDB_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SEB_int = 1'bx;
      COLLDISN_int = 1'bx;
`ifdef POWER_PINS
    end else if (RET1N_ == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 &&  pre_charge_st_b == 1'b1) begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
    end else begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
`else     
    end else begin
`endif
        XQB = 1'b1; QB_update = 1'b1;
      CENB_int = 1'bx;
      WENB_int = 1'bx;
      AB_int = {10{1'bx}};
      DB_int = {16{1'bx}};
      EMAB_int = {3{1'bx}};
      EMAWB_int = {2{1'bx}};
      TENB_int = 1'bx;
      TCENB_int = 1'bx;
      TWENB_int = 1'bx;
      TAB_int = {10{1'bx}};
      TDB_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SEB_int = 1'bx;
      COLLDISN_int = 1'bx;
    end
    RET1N_int = RET1N_;
    #0;
        QB_update = 1'b0;
  end


  always @ CLKB_ begin
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
`endif
`ifdef POWER_PINS
  if (RET1N_ == 1'b0) begin
`else     
  if (RET1N_ == 1'b0) begin
`endif
      // no cycle in retention mode
  end else begin
    if ((CLKB_ === 1'bx || CLKB_ === 1'bz) && RET1N_ !== 1'b0) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if ((CLKB_ === 1'b1 || CLKB_ === 1'b0) && LAST_CLKB === 1'bx) begin
       DB_sh_update = 1'b0;  XDB_sh = 1'b0;
       XQB = 1'b0; QB_update = 1'b0; 
    end else if (CLKB_ === 1'b1 && LAST_CLKB === 1'b0) begin
      DFTRAMBYP_int = DFTRAMBYP_;
      SEB_int = SEB_;
      CENB_int = TENB_ ? CENB_ : TCENB_;
      EMAB_int = EMAB_;
      EMAWB_int = EMAWB_;
      TENB_int = TENB_;
      TWENB_int = TWENB_;
      RET1N_int = RET1N_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENB_int != 1'b1) begin
        WENB_int = TENB_ ? WENB_ : TWENB_;
        AB_int = TENB_ ? AB_ : TAB_;
        DB_int = TENB_ ? DB_ : TDB_;
        TCENB_int = TCENB_;
        TAB_int = TAB_;
        TDB_int = TDB_;
        if (WENB_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
          read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
        end
      end
      clk1_int = 1'b0;
      if (DFTRAMBYP_=== 1'b1 && SEB_ === 1'b1) begin
         read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
         read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
        XQB = 1'b0; QB_update = 1'b1;
      end else begin
      CENB_int = TENB_ ? CENB_ : TCENB_;
      EMAB_int = EMAB_;
      EMAWB_int = EMAWB_;
      TENB_int = TENB_;
      TWENB_int = TWENB_;
      RET1N_int = RET1N_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENB_int != 1'b1) begin
        WENB_int = TENB_ ? WENB_ : TWENB_;
        AB_int = TENB_ ? AB_ : TAB_;
        DB_int = TENB_ ? DB_ : TDB_;
        TCENB_int = TCENB_;
        TAB_int = TAB_;
        TDB_int = TDB_;
        if (WENB_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
          read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
        end
      end
      clk1_int = 1'b0;
      if (CENB_int === 1'b0) previous_CLKB = $realtime;
    readWriteB;
      end
    #0;
      if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && COLLDISN_int === 1'b1 && row_contention(AA_int,
        AB_int, WENA_int, WENB_int)) begin
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQB = 1'b1; QB_update = 1'b1;
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQA = 1'b1; QA_update = 1'b1;
		end
        end else begin
          readWriteA;
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteA;
          readWriteB;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
      end else if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && (COLLDISN_int === 1'b0 || COLLDISN_int 
       === 1'bx)  && row_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
        XQA = 1'b1; QA_update = 1'b1;
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_READ_1 = 1;
          READ_WRITE_1 = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
        XQB = 1'b1; QB_update = 1'b1;
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
      end
    end else if (CLKB_ === 1'b0 && LAST_CLKB === 1'b1) begin
      QB_update = 1'b0;
      DB_sh_update = 1'b0;
      XQB = 1'b0;
         read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
    end
  end
    LAST_CLKB = CLKB_;
  end

  assign SIB_int = SEB_ ? SIB_ : {2{1'b0}};
  assign DB_int_bmux = TENB_ ? DB_ : TDB_;

  datapath_latch_sram_dp_hde_ibuf uDQB0 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(SIB_int[0]), .D(DB_int_bmux[0]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[0]), .XQ(XQB), .Q(QB_int[0]));
  datapath_latch_sram_dp_hde_ibuf uDQB1 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[0]), .D(DB_int_bmux[1]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[1]), .XQ(XQB), .Q(QB_int[1]));
  datapath_latch_sram_dp_hde_ibuf uDQB2 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[1]), .D(DB_int_bmux[2]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[2]), .XQ(XQB), .Q(QB_int[2]));
  datapath_latch_sram_dp_hde_ibuf uDQB3 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[2]), .D(DB_int_bmux[3]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[3]), .XQ(XQB), .Q(QB_int[3]));
  datapath_latch_sram_dp_hde_ibuf uDQB4 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[3]), .D(DB_int_bmux[4]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[4]), .XQ(XQB), .Q(QB_int[4]));
  datapath_latch_sram_dp_hde_ibuf uDQB5 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[4]), .D(DB_int_bmux[5]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[5]), .XQ(XQB), .Q(QB_int[5]));
  datapath_latch_sram_dp_hde_ibuf uDQB6 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[5]), .D(DB_int_bmux[6]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[6]), .XQ(XQB), .Q(QB_int[6]));
  datapath_latch_sram_dp_hde_ibuf uDQB7 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[6]), .D(DB_int_bmux[7]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[7]), .XQ(XQB), .Q(QB_int[7]));
  datapath_latch_sram_dp_hde_ibuf uDQB8 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[9]), .D(DB_int_bmux[8]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[8]), .XQ(XQB), .Q(QB_int[8]));
  datapath_latch_sram_dp_hde_ibuf uDQB9 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[10]), .D(DB_int_bmux[9]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[9]), .XQ(XQB), .Q(QB_int[9]));
  datapath_latch_sram_dp_hde_ibuf uDQB10 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[11]), .D(DB_int_bmux[10]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[10]), .XQ(XQB), .Q(QB_int[10]));
  datapath_latch_sram_dp_hde_ibuf uDQB11 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[12]), .D(DB_int_bmux[11]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[11]), .XQ(XQB), .Q(QB_int[11]));
  datapath_latch_sram_dp_hde_ibuf uDQB12 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[13]), .D(DB_int_bmux[12]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[12]), .XQ(XQB), .Q(QB_int[12]));
  datapath_latch_sram_dp_hde_ibuf uDQB13 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[14]), .D(DB_int_bmux[13]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[13]), .XQ(XQB), .Q(QB_int[13]));
  datapath_latch_sram_dp_hde_ibuf uDQB14 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[15]), .D(DB_int_bmux[14]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[14]), .XQ(XQB), .Q(QB_int[14]));
  datapath_latch_sram_dp_hde_ibuf uDQB15 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(SIB_int[1]), .D(DB_int_bmux[15]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[15]), .XQ(XQB), .Q(QB_int[15]));


// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
 always @ (VDDCE or VDDPE or VSSE) begin
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
 end
`endif

  function row_contention;
    input [9:0] aa;
    input [9:0] ab;
    input  wena;
    input  wenb;
    reg result;
    reg sameRow;
    reg sameMux;
    reg anyWrite;
  begin
    anyWrite = ((& wena) === 1'b1 && (& wenb) === 1'b1) ? 1'b0 : 1'b1;
    sameMux = (aa[2:0] == ab[2:0]) ? 1'b1 : 1'b0;
    if (aa[9:3] == ab[9:3]) begin
      sameRow = 1'b1;
    end else begin
      sameRow = 1'b0;
    end
    if (sameRow == 1'b1 && anyWrite == 1'b1)
      row_contention = 1'b1;
    else if (sameRow == 1'b1 && sameMux == 1'b1)
      row_contention = 1'b1;
    else
      row_contention = 1'b0;
  end
  endfunction

  function col_contention;
    input [9:0] aa;
    input [9:0] ab;
  begin
    if (aa[2:0] == ab[2:0])
      col_contention = 1'b1;
    else
      col_contention = 1'b0;
  end
  endfunction

  function is_contention;
    input [9:0] aa;
    input [9:0] ab;
    input  wena;
    input  wenb;
    reg result;
  begin
    if ((& wena) === 1'b1 && (& wenb) === 1'b1) begin
      result = 1'b0;
    end else if (aa == ab) begin
      result = 1'b1;
    end else begin
      result = 1'b0;
    end
    is_contention = result;
  end
  endfunction


endmodule
`endcelldefine
`else
`celldefine
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
module sram_dp_hde_ibuf (VDDCE, VDDPE, VSSE, CENYA, WENYA, AYA, CENYB, WENYB, AYB,
    QA, QB, SOA, SOB, CLKA, CENA, WENA, AA, DA, CLKB, CENB, WENB, AB, DB, EMAA, EMAWA,
    EMAB, EMAWB, TENA, TCENA, TWENA, TAA, TDA, TENB, TCENB, TWENB, TAB, TDB, RET1N,
    SIA, SEA, DFTRAMBYP, SIB, SEB, COLLDISN);
`else
module sram_dp_hde_ibuf (CENYA, WENYA, AYA, CENYB, WENYB, AYB, QA, QB, SOA, SOB, CLKA,
    CENA, WENA, AA, DA, CLKB, CENB, WENB, AB, DB, EMAA, EMAWA, EMAB, EMAWB, TENA, TCENA,
    TWENA, TAA, TDA, TENB, TCENB, TWENB, TAB, TDB, RET1N, SIA, SEA, DFTRAMBYP, SIB,
    SEB, COLLDISN);
`endif

  parameter ASSERT_PREFIX = "";
  parameter BITS = 16;
  parameter WORDS = 800;
  parameter MUX = 8;
  parameter MEM_WIDTH = 128; // redun block size 4, 64 on left, 64 on right
  parameter MEM_HEIGHT = 100;
  parameter WP_SIZE = 16 ;
  parameter UPM_WIDTH = 3;
  parameter UPMW_WIDTH = 2;
  parameter UPMS_WIDTH = 0;

  output  CENYA;
  output  WENYA;
  output [9:0] AYA;
  output  CENYB;
  output  WENYB;
  output [9:0] AYB;
  output [15:0] QA;
  output [15:0] QB;
  output [1:0] SOA;
  output [1:0] SOB;
  input  CLKA;
  input  CENA;
  input  WENA;
  input [9:0] AA;
  input [15:0] DA;
  input  CLKB;
  input  CENB;
  input  WENB;
  input [9:0] AB;
  input [15:0] DB;
  input [2:0] EMAA;
  input [1:0] EMAWA;
  input [2:0] EMAB;
  input [1:0] EMAWB;
  input  TENA;
  input  TCENA;
  input  TWENA;
  input [9:0] TAA;
  input [15:0] TDA;
  input  TENB;
  input  TCENB;
  input  TWENB;
  input [9:0] TAB;
  input [15:0] TDB;
  input  RET1N;
  input [1:0] SIA;
  input  SEA;
  input  DFTRAMBYP;
  input [1:0] SIB;
  input  SEB;
  input  COLLDISN;
`ifdef POWER_PINS
  inout VDDCE;
  inout VDDPE;
  inout VSSE;
`endif

  reg pre_charge_st;
  reg pre_charge_st_a;
  reg pre_charge_st_b;
  integer row_address;
  integer mux_address;
  reg [127:0] mem [0:99];
  reg [127:0] row, row_t;
  reg LAST_CLKA;
  reg [127:0] row_mask;
  reg [127:0] new_data;
  reg [127:0] data_out;
  reg [31:0] readLatch0;
  reg [31:0] shifted_readLatch0;
  reg  read_mux_sel0;
  reg  read_mux_sel0_p2;
  reg [31:0] readLatch1;
  reg [31:0] shifted_readLatch1;
  reg  read_mux_sel1;
  reg  read_mux_sel1_p2;
  reg LAST_CLKB;
  wire [15:0] QA_int;
  reg XQA, QA_update;
  reg XDA_sh, DA_sh_update;
  wire [15:0] DA_int_bmux;
  reg [15:0] mem_path_A;
  wire [15:0] QB_int;
  reg XQB, QB_update;
  reg XDB_sh, DB_sh_update;
  wire [15:0] DB_int_bmux;
  reg [15:0] mem_path_B;
  reg [15:0] writeEnable;
  real previous_CLKA;
  real previous_CLKB;
  initial previous_CLKA = 0;
  initial previous_CLKB = 0;
  reg READ_WRITE, WRITE_WRITE, READ_READ, ROW_CC, COL_CC;
  reg READ_WRITE_1, WRITE_WRITE_1, READ_READ_1;
  reg  cont_flag0_int;
  reg  cont_flag1_int;
  initial cont_flag0_int = 1'b0;
  initial cont_flag1_int = 1'b0;

  reg NOT_CENA, NOT_WENA, NOT_AA9, NOT_AA8, NOT_AA7, NOT_AA6, NOT_AA5, NOT_AA4, NOT_AA3;
  reg NOT_AA2, NOT_AA1, NOT_AA0, NOT_DA15, NOT_DA14, NOT_DA13, NOT_DA12, NOT_DA11;
  reg NOT_DA10, NOT_DA9, NOT_DA8, NOT_DA7, NOT_DA6, NOT_DA5, NOT_DA4, NOT_DA3, NOT_DA2;
  reg NOT_DA1, NOT_DA0, NOT_CENB, NOT_WENB, NOT_AB9, NOT_AB8, NOT_AB7, NOT_AB6, NOT_AB5;
  reg NOT_AB4, NOT_AB3, NOT_AB2, NOT_AB1, NOT_AB0, NOT_DB15, NOT_DB14, NOT_DB13, NOT_DB12;
  reg NOT_DB11, NOT_DB10, NOT_DB9, NOT_DB8, NOT_DB7, NOT_DB6, NOT_DB5, NOT_DB4, NOT_DB3;
  reg NOT_DB2, NOT_DB1, NOT_DB0, NOT_EMAA2, NOT_EMAA1, NOT_EMAA0, NOT_EMAWA1, NOT_EMAWA0;
  reg NOT_EMAB2, NOT_EMAB1, NOT_EMAB0, NOT_EMAWB1, NOT_EMAWB0, NOT_TENA, NOT_TCENA;
  reg NOT_TWENA, NOT_TAA9, NOT_TAA8, NOT_TAA7, NOT_TAA6, NOT_TAA5, NOT_TAA4, NOT_TAA3;
  reg NOT_TAA2, NOT_TAA1, NOT_TAA0, NOT_TDA15, NOT_TDA14, NOT_TDA13, NOT_TDA12, NOT_TDA11;
  reg NOT_TDA10, NOT_TDA9, NOT_TDA8, NOT_TDA7, NOT_TDA6, NOT_TDA5, NOT_TDA4, NOT_TDA3;
  reg NOT_TDA2, NOT_TDA1, NOT_TDA0, NOT_TENB, NOT_TCENB, NOT_TWENB, NOT_TAB9, NOT_TAB8;
  reg NOT_TAB7, NOT_TAB6, NOT_TAB5, NOT_TAB4, NOT_TAB3, NOT_TAB2, NOT_TAB1, NOT_TAB0;
  reg NOT_TDB15, NOT_TDB14, NOT_TDB13, NOT_TDB12, NOT_TDB11, NOT_TDB10, NOT_TDB9, NOT_TDB8;
  reg NOT_TDB7, NOT_TDB6, NOT_TDB5, NOT_TDB4, NOT_TDB3, NOT_TDB2, NOT_TDB1, NOT_TDB0;
  reg NOT_SIA1, NOT_SIA0, NOT_SEA, NOT_DFTRAMBYP_CLKA, NOT_DFTRAMBYP_CLKB, NOT_RET1N;
  reg NOT_SIB1, NOT_SIB0, NOT_SEB, NOT_COLLDISN;
  reg NOT_CONTA, NOT_CLKA_PER, NOT_CLKA_MINH, NOT_CLKA_MINL, NOT_CONTB, NOT_CLKB_PER;
  reg NOT_CLKB_MINH, NOT_CLKB_MINL;
  reg clk0_int;
  reg clk1_int;

  wire  CENYA_;
  wire  WENYA_;
  wire [9:0] AYA_;
  wire  CENYB_;
  wire  WENYB_;
  wire [9:0] AYB_;
  wire [15:0] QA_;
  wire [15:0] QB_;
  wire [1:0] SOA_;
  wire [1:0] SOB_;
 wire  CLKA_;
  wire  CENA_;
  reg  CENA_int;
  reg  CENA_p2;
  wire  WENA_;
  reg  WENA_int;
  wire [9:0] AA_;
  reg [9:0] AA_int;
  wire [15:0] DA_;
  reg [15:0] DA_int;
 wire  CLKB_;
  wire  CENB_;
  reg  CENB_int;
  reg  CENB_p2;
  wire  WENB_;
  reg  WENB_int;
  wire [9:0] AB_;
  reg [9:0] AB_int;
  wire [15:0] DB_;
  reg [15:0] DB_int;
  wire [2:0] EMAA_;
  reg [2:0] EMAA_int;
  wire [1:0] EMAWA_;
  reg [1:0] EMAWA_int;
  wire [2:0] EMAB_;
  reg [2:0] EMAB_int;
  wire [1:0] EMAWB_;
  reg [1:0] EMAWB_int;
  wire  TENA_;
  reg  TENA_int;
  wire  TCENA_;
  reg  TCENA_int;
  reg  TCENA_p2;
  wire  TWENA_;
  reg  TWENA_int;
  wire [9:0] TAA_;
  reg [9:0] TAA_int;
  wire [15:0] TDA_;
  reg [15:0] TDA_int;
  wire  TENB_;
  reg  TENB_int;
  wire  TCENB_;
  reg  TCENB_int;
  reg  TCENB_p2;
  wire  TWENB_;
  reg  TWENB_int;
  wire [9:0] TAB_;
  reg [9:0] TAB_int;
  wire [15:0] TDB_;
  reg [15:0] TDB_int;
  wire  RET1N_;
  reg  RET1N_int;
  wire [1:0] SIA_;
  wire [1:0] SIA_int;
  wire  SEA_;
  reg  SEA_int;
  wire  DFTRAMBYP_;
  reg  DFTRAMBYP_int;
  reg  DFTRAMBYP_p2;
  wire [1:0] SIB_;
  wire [1:0] SIB_int;
  wire  SEB_;
  reg  SEB_int;
  wire  COLLDISN_;
  reg  COLLDISN_int;

  buf B0(CENYA, CENYA_);
  buf B1(WENYA, WENYA_);
  buf B2(AYA[0], AYA_[0]);
  buf B3(AYA[1], AYA_[1]);
  buf B4(AYA[2], AYA_[2]);
  buf B5(AYA[3], AYA_[3]);
  buf B6(AYA[4], AYA_[4]);
  buf B7(AYA[5], AYA_[5]);
  buf B8(AYA[6], AYA_[6]);
  buf B9(AYA[7], AYA_[7]);
  buf B10(AYA[8], AYA_[8]);
  buf B11(AYA[9], AYA_[9]);
  buf B12(CENYB, CENYB_);
  buf B13(WENYB, WENYB_);
  buf B14(AYB[0], AYB_[0]);
  buf B15(AYB[1], AYB_[1]);
  buf B16(AYB[2], AYB_[2]);
  buf B17(AYB[3], AYB_[3]);
  buf B18(AYB[4], AYB_[4]);
  buf B19(AYB[5], AYB_[5]);
  buf B20(AYB[6], AYB_[6]);
  buf B21(AYB[7], AYB_[7]);
  buf B22(AYB[8], AYB_[8]);
  buf B23(AYB[9], AYB_[9]);
  buf B24(QA[0], QA_[0]);
  buf B25(QA[1], QA_[1]);
  buf B26(QA[2], QA_[2]);
  buf B27(QA[3], QA_[3]);
  buf B28(QA[4], QA_[4]);
  buf B29(QA[5], QA_[5]);
  buf B30(QA[6], QA_[6]);
  buf B31(QA[7], QA_[7]);
  buf B32(QA[8], QA_[8]);
  buf B33(QA[9], QA_[9]);
  buf B34(QA[10], QA_[10]);
  buf B35(QA[11], QA_[11]);
  buf B36(QA[12], QA_[12]);
  buf B37(QA[13], QA_[13]);
  buf B38(QA[14], QA_[14]);
  buf B39(QA[15], QA_[15]);
  buf B40(QB[0], QB_[0]);
  buf B41(QB[1], QB_[1]);
  buf B42(QB[2], QB_[2]);
  buf B43(QB[3], QB_[3]);
  buf B44(QB[4], QB_[4]);
  buf B45(QB[5], QB_[5]);
  buf B46(QB[6], QB_[6]);
  buf B47(QB[7], QB_[7]);
  buf B48(QB[8], QB_[8]);
  buf B49(QB[9], QB_[9]);
  buf B50(QB[10], QB_[10]);
  buf B51(QB[11], QB_[11]);
  buf B52(QB[12], QB_[12]);
  buf B53(QB[13], QB_[13]);
  buf B54(QB[14], QB_[14]);
  buf B55(QB[15], QB_[15]);
  buf B56(SOA[0], SOA_[0]);
  buf B57(SOA[1], SOA_[1]);
  buf B58(SOB[0], SOB_[0]);
  buf B59(SOB[1], SOB_[1]);
  buf B60(CLKA_, CLKA);
  buf B61(CENA_, CENA);
  buf B62(WENA_, WENA);
  buf B63(AA_[0], AA[0]);
  buf B64(AA_[1], AA[1]);
  buf B65(AA_[2], AA[2]);
  buf B66(AA_[3], AA[3]);
  buf B67(AA_[4], AA[4]);
  buf B68(AA_[5], AA[5]);
  buf B69(AA_[6], AA[6]);
  buf B70(AA_[7], AA[7]);
  buf B71(AA_[8], AA[8]);
  buf B72(AA_[9], AA[9]);
  buf B73(DA_[0], DA[0]);
  buf B74(DA_[1], DA[1]);
  buf B75(DA_[2], DA[2]);
  buf B76(DA_[3], DA[3]);
  buf B77(DA_[4], DA[4]);
  buf B78(DA_[5], DA[5]);
  buf B79(DA_[6], DA[6]);
  buf B80(DA_[7], DA[7]);
  buf B81(DA_[8], DA[8]);
  buf B82(DA_[9], DA[9]);
  buf B83(DA_[10], DA[10]);
  buf B84(DA_[11], DA[11]);
  buf B85(DA_[12], DA[12]);
  buf B86(DA_[13], DA[13]);
  buf B87(DA_[14], DA[14]);
  buf B88(DA_[15], DA[15]);
  buf B89(CLKB_, CLKB);
  buf B90(CENB_, CENB);
  buf B91(WENB_, WENB);
  buf B92(AB_[0], AB[0]);
  buf B93(AB_[1], AB[1]);
  buf B94(AB_[2], AB[2]);
  buf B95(AB_[3], AB[3]);
  buf B96(AB_[4], AB[4]);
  buf B97(AB_[5], AB[5]);
  buf B98(AB_[6], AB[6]);
  buf B99(AB_[7], AB[7]);
  buf B100(AB_[8], AB[8]);
  buf B101(AB_[9], AB[9]);
  buf B102(DB_[0], DB[0]);
  buf B103(DB_[1], DB[1]);
  buf B104(DB_[2], DB[2]);
  buf B105(DB_[3], DB[3]);
  buf B106(DB_[4], DB[4]);
  buf B107(DB_[5], DB[5]);
  buf B108(DB_[6], DB[6]);
  buf B109(DB_[7], DB[7]);
  buf B110(DB_[8], DB[8]);
  buf B111(DB_[9], DB[9]);
  buf B112(DB_[10], DB[10]);
  buf B113(DB_[11], DB[11]);
  buf B114(DB_[12], DB[12]);
  buf B115(DB_[13], DB[13]);
  buf B116(DB_[14], DB[14]);
  buf B117(DB_[15], DB[15]);
  buf B118(EMAA_[0], EMAA[0]);
  buf B119(EMAA_[1], EMAA[1]);
  buf B120(EMAA_[2], EMAA[2]);
  buf B121(EMAWA_[0], EMAWA[0]);
  buf B122(EMAWA_[1], EMAWA[1]);
  buf B123(EMAB_[0], EMAB[0]);
  buf B124(EMAB_[1], EMAB[1]);
  buf B125(EMAB_[2], EMAB[2]);
  buf B126(EMAWB_[0], EMAWB[0]);
  buf B127(EMAWB_[1], EMAWB[1]);
  buf B128(TENA_, TENA);
  buf B129(TCENA_, TCENA);
  buf B130(TWENA_, TWENA);
  buf B131(TAA_[0], TAA[0]);
  buf B132(TAA_[1], TAA[1]);
  buf B133(TAA_[2], TAA[2]);
  buf B134(TAA_[3], TAA[3]);
  buf B135(TAA_[4], TAA[4]);
  buf B136(TAA_[5], TAA[5]);
  buf B137(TAA_[6], TAA[6]);
  buf B138(TAA_[7], TAA[7]);
  buf B139(TAA_[8], TAA[8]);
  buf B140(TAA_[9], TAA[9]);
  buf B141(TDA_[0], TDA[0]);
  buf B142(TDA_[1], TDA[1]);
  buf B143(TDA_[2], TDA[2]);
  buf B144(TDA_[3], TDA[3]);
  buf B145(TDA_[4], TDA[4]);
  buf B146(TDA_[5], TDA[5]);
  buf B147(TDA_[6], TDA[6]);
  buf B148(TDA_[7], TDA[7]);
  buf B149(TDA_[8], TDA[8]);
  buf B150(TDA_[9], TDA[9]);
  buf B151(TDA_[10], TDA[10]);
  buf B152(TDA_[11], TDA[11]);
  buf B153(TDA_[12], TDA[12]);
  buf B154(TDA_[13], TDA[13]);
  buf B155(TDA_[14], TDA[14]);
  buf B156(TDA_[15], TDA[15]);
  buf B157(TENB_, TENB);
  buf B158(TCENB_, TCENB);
  buf B159(TWENB_, TWENB);
  buf B160(TAB_[0], TAB[0]);
  buf B161(TAB_[1], TAB[1]);
  buf B162(TAB_[2], TAB[2]);
  buf B163(TAB_[3], TAB[3]);
  buf B164(TAB_[4], TAB[4]);
  buf B165(TAB_[5], TAB[5]);
  buf B166(TAB_[6], TAB[6]);
  buf B167(TAB_[7], TAB[7]);
  buf B168(TAB_[8], TAB[8]);
  buf B169(TAB_[9], TAB[9]);
  buf B170(TDB_[0], TDB[0]);
  buf B171(TDB_[1], TDB[1]);
  buf B172(TDB_[2], TDB[2]);
  buf B173(TDB_[3], TDB[3]);
  buf B174(TDB_[4], TDB[4]);
  buf B175(TDB_[5], TDB[5]);
  buf B176(TDB_[6], TDB[6]);
  buf B177(TDB_[7], TDB[7]);
  buf B178(TDB_[8], TDB[8]);
  buf B179(TDB_[9], TDB[9]);
  buf B180(TDB_[10], TDB[10]);
  buf B181(TDB_[11], TDB[11]);
  buf B182(TDB_[12], TDB[12]);
  buf B183(TDB_[13], TDB[13]);
  buf B184(TDB_[14], TDB[14]);
  buf B185(TDB_[15], TDB[15]);
  buf B186(RET1N_, RET1N);
  buf B187(SIA_[0], SIA[0]);
  buf B188(SIA_[1], SIA[1]);
  buf B189(SEA_, SEA);
  buf B190(DFTRAMBYP_, DFTRAMBYP);
  buf B191(SIB_[0], SIB[0]);
  buf B192(SIB_[1], SIB[1]);
  buf B193(SEB_, SEB);
  buf B194(COLLDISN_, COLLDISN);

  assign CENYA_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENA_ ? CENA_ : TCENA_)) : 1'bx;
  assign WENYA_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENA_ ? WENA_ : TWENA_)) : 1'bx;
  assign AYA_ = (RET1N_ | pre_charge_st) ? ({10{DFTRAMBYP_}} & (TENA_ ? AA_ : TAA_)) : {10{1'bx}};
  assign CENYB_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENB_ ? CENB_ : TCENB_)) : 1'bx;
  assign WENYB_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENB_ ? WENB_ : TWENB_)) : 1'bx;
  assign AYB_ = (RET1N_ | pre_charge_st) ? ({10{DFTRAMBYP_}} & (TENB_ ? AB_ : TAB_)) : {10{1'bx}};
  assign QA_ = (RET1N_ | pre_charge_st) ? ((QA_int)) : {16{1'bx}};
  assign QB_ = (RET1N_ | pre_charge_st) ? ((QB_int)) : {16{1'bx}};
  assign SOA_ = (RET1N_ | pre_charge_st) ? ({QA_[8], QA_[7]}) : {2{1'bx}};
  assign SOB_ = (RET1N_ | pre_charge_st) ? ({QB_[8], QB_[7]}) : {2{1'bx}};

// If INITIALIZE_MEMORY is defined at Simulator Command Line, it Initializes the Memory with all ZEROS.
`ifdef INITIALIZE_MEMORY
  integer i;
  initial begin
    #0;
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'b0}};
  end
`endif
  always @ (EMAA_) begin
  	if(EMAA_ < 2) 
   	$display("Warning: Set Value for EMAA doesn't match Default value 2 in %m at %0t", $time);
  end
  always @ (EMAWA_) begin
  	if(EMAWA_ < 0) 
   	$display("Warning: Set Value for EMAWA doesn't match Default value 0 in %m at %0t", $time);
  end
  always @ (EMAB_) begin
  	if(EMAB_ < 2) 
   	$display("Warning: Set Value for EMAB doesn't match Default value 2 in %m at %0t", $time);
  end
  always @ (EMAWB_) begin
  	if(EMAWB_ < 0) 
   	$display("Warning: Set Value for EMAWB doesn't match Default value 0 in %m at %0t", $time);
  end

  task failedWrite;
  input port_f;
  integer i;
  begin
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'bx}};
  end
  endtask

  function isBitX;
    input bitval;
    begin
      isBitX = ( bitval===1'bx || bitval==1'bz ) ? 1'b1 : 1'b0;
    end
  endfunction

  function isBit1;
    input bitval;
    begin
      isBit1 = ( bitval===1'b1 ) ? 1'b1 : 1'b0;
    end
  endfunction



  task readWriteA;
  begin
    if (WENA_int !== 1'b1 && DFTRAMBYP_int=== 1'b0 && SEA_int === 1'bx) begin
      failedWrite(0);
    end else if (DFTRAMBYP_int=== 1'b0 && SEA_int === 1'b1) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (RET1N_int === 1'bx || RET1N_int === 1'bz) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (RET1N_int === 1'b0 && (CENA_int === 1'b0 || DFTRAMBYP_int === 1'b1)) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (RET1N_int === 1'b0) begin
      // no cycle in retention mode
    end else if (^{(EMAA_int & isBit1(DFTRAMBYP_int)), (EMAWA_int & isBit1(DFTRAMBYP_int))} === 1'bx) begin
        XQA = 1'b1; QA_update = 1'b1;
    end else if (^{(CENA_int & !isBit1(DFTRAMBYP_int)), EMAA_int, EMAWA_int, RET1N_int} === 1'bx) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if ((AA_int >= WORDS) && (CENA_int === 1'b0) && DFTRAMBYP_int === 1'b0) begin
        XQA = WENA_int !== 1'b1 ? 1'b0 : 1'b1; QA_update = WENA_int !== 1'b1 ? 1'b0 : 1'b1;
    end else if (CENA_int === 1'b0 && (^AA_int) === 1'bx && DFTRAMBYP_int === 1'b0) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (CENA_int === 1'b0 || DFTRAMBYP_int === 1'b1) begin
      if(isBitX(DFTRAMBYP_int) || isBitX(SEA_int))
        DA_int = {16{1'bx}};

      mux_address = (AA_int & 3'b111);
      row_address = (AA_int >> 3);
      if (DFTRAMBYP_int !== 1'b1) begin
      if (row_address > 99)
        row = {128{1'bx}};
      else
        row = mem[row_address];
      end
      if(isBitX(DFTRAMBYP_int) || (isBitX(WENA_int) && DFTRAMBYP_int!==1)) begin
        writeEnable = {16{1'bx}};
        DA_int = {16{1'bx}};
      end else
          writeEnable = ~ {16{WENA_int}};
      if (WENA_int !== 1'b1 || DFTRAMBYP_int === 1'b1 || DFTRAMBYP_int === 1'bx) begin
        row_mask =  ( {7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14], 7'b0000000, writeEnable[13],
          7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11], 7'b0000000, writeEnable[10],
          7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8], 7'b0000000, writeEnable[7],
          7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5], 7'b0000000, writeEnable[4],
          7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2], 7'b0000000, writeEnable[1],
          7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, DA_int[15], 7'b0000000, DA_int[14], 7'b0000000, DA_int[13],
          7'b0000000, DA_int[12], 7'b0000000, DA_int[11], 7'b0000000, DA_int[10], 7'b0000000, DA_int[9],
          7'b0000000, DA_int[8], 7'b0000000, DA_int[7], 7'b0000000, DA_int[6], 7'b0000000, DA_int[5],
          7'b0000000, DA_int[4], 7'b0000000, DA_int[3], 7'b0000000, DA_int[2], 7'b0000000, DA_int[1],
          7'b0000000, DA_int[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        if (DFTRAMBYP_int === 1'b1 && SEA_int === 1'b0) begin
        end else if (WENA_int !== 1'b1 && DFTRAMBYP_int === 1'b1 && SEA_int === 1'bx) begin
        	XQA = 1'b1; QA_update = 1'b1;
        end else begin
        mem[row_address] = row;
        end
      end else begin
        data_out = (row >> (mux_address%4));
        readLatch0 = {data_out[124], data_out[120], data_out[116], data_out[112], data_out[108],
          data_out[104], data_out[100], data_out[96], data_out[92], data_out[88], data_out[84],
          data_out[80], data_out[76], data_out[72], data_out[68], data_out[64], data_out[60],
          data_out[56], data_out[52], data_out[48], data_out[44], data_out[40], data_out[36],
          data_out[32], data_out[28], data_out[24], data_out[20], data_out[16], data_out[12],
          data_out[8], data_out[4], data_out[0]};
        shifted_readLatch0 = (readLatch0 >> AA_int[2]);
        mem_path_A = {shifted_readLatch0[30], shifted_readLatch0[28], shifted_readLatch0[26],
          shifted_readLatch0[24], shifted_readLatch0[22], shifted_readLatch0[20], shifted_readLatch0[18],
          shifted_readLatch0[16], shifted_readLatch0[14], shifted_readLatch0[12], shifted_readLatch0[10],
          shifted_readLatch0[8], shifted_readLatch0[6], shifted_readLatch0[4], shifted_readLatch0[2],
          shifted_readLatch0[0]};
        	XQA = 1'b0; QA_update = 1'b1;
      end
      if (DFTRAMBYP_int === 1'b1) begin
        	XQA = 1'b0; QA_update = 1'b1;
      end
      if( isBitX(WENA_int) && DFTRAMBYP_int !== 1'b1) begin
        XQA = 1'b1; QA_update = 1'b1;
      end
      if( isBitX(DFTRAMBYP_int) ) begin
        XQA = 1'b1; QA_update = 1'b1;
      end
      if( isBitX(SEA_int) && DFTRAMBYP_int === 1'b1 ) begin
        XQA = 1'b1; QA_update = 1'b1;
      end
    end
  end
  endtask
  always @ (CENA_ or TCENA_ or TENA_ or DFTRAMBYP_ or CLKA_) begin
  	if(CLKA_ == 1'b0) begin
  		CENA_p2 = CENA_;
  		TCENA_p2 = TCENA_;
  		DFTRAMBYP_p2 = DFTRAMBYP_;
  	end
  end

`ifdef POWER_PINS
  always @ (VDDCE) begin
      if (VDDCE != 1'b1) begin
       if (VDDPE == 1'b1) begin
        $display("VDDCE should be powered down after VDDPE, Illegal power down sequencing in %m at %0t", $time);
       end
        $display("In PowerDown Mode in %m at %0t", $time);
        failedWrite(0);
      end
      if (VDDCE == 1'b1) begin
       if (VDDPE == 1'b1) begin
        $display("VDDPE should be powered up after VDDCE in %m at %0t", $time);
        $display("Illegal power up sequencing in %m at %0t", $time);
       end
        failedWrite(0);
      end
  end
`endif
`ifdef POWER_PINS
  always @ (RET1N_ or VDDPE or VDDCE) begin
`else     
  always @ RET1N_ begin
`endif
`ifdef POWER_PINS
    if (RET1N_ == 1'b1 && RET1N_int == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 && pre_charge_st_a == 1'b1 && (CENA_ === 1'bx || TCENA_ === 1'bx || DFTRAMBYP_ === 1'bx || CLKA_ === 1'bx)) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end
`else     
`endif
`ifdef POWER_PINS
`else     
      pre_charge_st_a = 0;
      pre_charge_st = 0;
`endif
    if (RET1N_ === 1'bx || RET1N_ === 1'bz) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (RET1N_ === 1'b0 && RET1N_int === 1'b1 && (CENA_p2 === 1'b0 || TCENA_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if (RET1N_ === 1'b1 && RET1N_int === 1'b0 && (CENA_p2 === 1'b0 || TCENA_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end
`ifdef POWER_PINS
    if (RET1N_ == 1'b0 && VDDCE == 1'b1 && VDDPE == 1'b1) begin
      pre_charge_st_a = 1;
      pre_charge_st = 1;
    end else if (RET1N_ == 1'b0 && VDDPE == 1'b0) begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
      if (VDDCE != 1'b1) begin
        failedWrite(0);
      end
`else     
    if (RET1N_ == 1'b0) begin
`endif
        XQA = 1'b1; QA_update = 1'b1;
      CENA_int = 1'bx;
      WENA_int = 1'bx;
      AA_int = {10{1'bx}};
      DA_int = {16{1'bx}};
      EMAA_int = {3{1'bx}};
      EMAWA_int = {2{1'bx}};
      TENA_int = 1'bx;
      TCENA_int = 1'bx;
      TWENA_int = 1'bx;
      TAA_int = {10{1'bx}};
      TDA_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SEA_int = 1'bx;
      DFTRAMBYP_int = 1'bx;
      COLLDISN_int = 1'bx;
`ifdef POWER_PINS
    end else if (RET1N_ == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 &&  pre_charge_st_a == 1'b1) begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
    end else begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
`else     
    end else begin
`endif
        XQA = 1'b1; QA_update = 1'b1;
      CENA_int = 1'bx;
      WENA_int = 1'bx;
      AA_int = {10{1'bx}};
      DA_int = {16{1'bx}};
      EMAA_int = {3{1'bx}};
      EMAWA_int = {2{1'bx}};
      TENA_int = 1'bx;
      TCENA_int = 1'bx;
      TWENA_int = 1'bx;
      TAA_int = {10{1'bx}};
      TDA_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SEA_int = 1'bx;
      DFTRAMBYP_int = 1'bx;
      COLLDISN_int = 1'bx;
    end
    RET1N_int = RET1N_;
    #0;
        QA_update = 1'b0;
  end


  always @ CLKA_ begin
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
`endif
`ifdef POWER_PINS
  if (RET1N_ == 1'b0) begin
`else     
  if (RET1N_ == 1'b0) begin
`endif
      // no cycle in retention mode
  end else begin
    if ((CLKA_ === 1'bx || CLKA_ === 1'bz) && RET1N_ !== 1'b0) begin
      failedWrite(0);
        XQA = 1'b1; QA_update = 1'b1;
    end else if ((CLKA_ === 1'b1 || CLKA_ === 1'b0) && LAST_CLKA === 1'bx) begin
       DA_sh_update = 1'b0;  XDA_sh = 1'b0;
       XQA = 1'b0; QA_update = 1'b0; 
    end else if (CLKA_ === 1'b1 && LAST_CLKA === 1'b0) begin
      SEA_int = SEA_;
      DFTRAMBYP_int = DFTRAMBYP_;
      CENA_int = TENA_ ? CENA_ : TCENA_;
      EMAA_int = EMAA_;
      EMAWA_int = EMAWA_;
      TENA_int = TENA_;
      TWENA_int = TWENA_;
      RET1N_int = RET1N_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENA_int != 1'b1) begin
        WENA_int = TENA_ ? WENA_ : TWENA_;
        AA_int = TENA_ ? AA_ : TAA_;
        DA_int = TENA_ ? DA_ : TDA_;
        TCENA_int = TCENA_;
        TAA_int = TAA_;
        TDA_int = TDA_;
        DFTRAMBYP_int = DFTRAMBYP_;
        if (WENA_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
          read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
        end
      end
      clk0_int = 1'b0;
      if (DFTRAMBYP_=== 1'b1 && SEA_ === 1'b1) begin
         read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
         read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
        XQA = 1'b0; QA_update = 1'b1;
      end else begin
      CENA_int = TENA_ ? CENA_ : TCENA_;
      EMAA_int = EMAA_;
      EMAWA_int = EMAWA_;
      TENA_int = TENA_;
      TWENA_int = TWENA_;
      RET1N_int = RET1N_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENA_int != 1'b1) begin
        WENA_int = TENA_ ? WENA_ : TWENA_;
        AA_int = TENA_ ? AA_ : TAA_;
        DA_int = TENA_ ? DA_ : TDA_;
        TCENA_int = TCENA_;
        TAA_int = TAA_;
        TDA_int = TDA_;
        DFTRAMBYP_int = DFTRAMBYP_;
        if (WENA_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
          read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
        end
      end
      clk0_int = 1'b0;
      if (CENA_int === 1'b0) previous_CLKA = $realtime;
    readWriteA;
      end
    #0;
      if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && COLLDISN_int === 1'b1 && row_contention(AA_int,
        AB_int, WENA_int, WENB_int)) begin
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQB = 1'b1; QB_update = 1'b1;
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQA = 1'b1; QA_update = 1'b1;
		end
        end else begin
          readWriteB;
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteB;
          readWriteA;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
      end else if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && (COLLDISN_int === 1'b0 || COLLDISN_int 
       === 1'bx)  && row_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
        XQB = 1'b1; QB_update = 1'b1;
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE_1 = 1;
          READ_READ_1 = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
        XQA = 1'b1; QA_update = 1'b1;
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
      end
    end else if (CLKA_ === 1'b0 && LAST_CLKA === 1'b1) begin
      QA_update = 1'b0;
      DA_sh_update = 1'b0;
      XQA = 1'b0;
         read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
    end
  end
    LAST_CLKA = CLKA_;
  end

  reg globalNotifier0;
  initial globalNotifier0 = 1'b0;

  always @ globalNotifier0 begin
    if ($realtime == 0) begin
    end else if ((EMAA_int[0] === 1'bx & DFTRAMBYP_int === 1'b1) || (EMAA_int[1] === 1'bx & DFTRAMBYP_int === 1'b1) || 
      (EMAA_int[2] === 1'bx & DFTRAMBYP_int === 1'b1) || (EMAWA_int[0] === 1'bx & DFTRAMBYP_int === 1'b1) || 
      (EMAWA_int[1] === 1'bx & DFTRAMBYP_int === 1'b1)) begin
        XQA = 1'b1; QA_update = 1'b1;
    end else if ((CENA_int === 1'bx & DFTRAMBYP_int === 1'b0) || EMAA_int[0] === 1'bx || 
      EMAA_int[1] === 1'bx || EMAA_int[2] === 1'bx || EMAWA_int[0] === 1'bx || EMAWA_int[1] === 1'bx || 
      RET1N_int === 1'bx || clk0_int === 1'bx) begin
        XQA = 1'b1; QA_update = 1'b1;
      failedWrite(0);
    end else if (TENA_int === 1'bx) begin
      if(((CENA_ === 1'b1 & TCENA_ === 1'b1) & DFTRAMBYP_int === 1'b0) | (DFTRAMBYP_int === 1'b1 & SEA_int === 1'b1)) begin
      end else begin
        XQA = 1'b1; QA_update = 1'b1;
      if (DFTRAMBYP_int === 1'b0) begin
          failedWrite(0);
      end
      end
    end else if  (cont_flag0_int === 1'bx && COLLDISN_int === 1'b1 &&  (CENA_int !== 1'b1 && ((TENB_ ? CENB_ : TCENB_) !== 1'b1) && DFTRAMBYP_ !== 1'b1) 
     && row_contention(TENB_ ? AB_ : TAB_, AA_int, WENA_int, TENB_ ? WENB_ : TWENB_)) begin
      cont_flag0_int = 1'b0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQB = 1'b1; QB_update = 1'b1;
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQA = 1'b1; QA_update = 1'b1;
		end
        end else begin
          readWriteB;
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteB;
          readWriteA;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
    end else if  ((CENA_int !== 1'b1 && ((TENB_ ? CENB_ : TCENB_) !== 1'b1) && DFTRAMBYP_ !== 1'b1) && cont_flag0_int === 1'bx && (COLLDISN_int === 1'b0 
     || COLLDISN_int === 1'bx) && row_contention(TENB_ ? AB_ : TAB_, AA_int, WENA_int, TENB_ ? WENB_ : TWENB_)) begin
      cont_flag0_int = 1'b0;
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
        XQB = 1'b1; QB_update = 1'b1;
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE_1 = 1;
          READ_READ_1 = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
        XQA = 1'b1; QA_update = 1'b1;
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
    end else begin
      #0;
      readWriteA;
   end
      #0;
        XQA = 1'b0; QA_update = 1'b0;
    globalNotifier0 = 1'b0;
  end

  assign SIA_int = SEA_ ? SIA_ : {2{1'b0}};
  assign DA_int_bmux = TENA_ ? DA_ : TDA_;

  datapath_latch_sram_dp_hde_ibuf uDQA0 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(SIA_int[0]), .D(DA_int_bmux[0]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[0]), .XQ(XQA), .Q(QA_int[0]));
  datapath_latch_sram_dp_hde_ibuf uDQA1 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[0]), .D(DA_int_bmux[1]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[1]), .XQ(XQA), .Q(QA_int[1]));
  datapath_latch_sram_dp_hde_ibuf uDQA2 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[1]), .D(DA_int_bmux[2]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[2]), .XQ(XQA), .Q(QA_int[2]));
  datapath_latch_sram_dp_hde_ibuf uDQA3 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[2]), .D(DA_int_bmux[3]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[3]), .XQ(XQA), .Q(QA_int[3]));
  datapath_latch_sram_dp_hde_ibuf uDQA4 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[3]), .D(DA_int_bmux[4]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[4]), .XQ(XQA), .Q(QA_int[4]));
  datapath_latch_sram_dp_hde_ibuf uDQA5 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[4]), .D(DA_int_bmux[5]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[5]), .XQ(XQA), .Q(QA_int[5]));
  datapath_latch_sram_dp_hde_ibuf uDQA6 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[5]), .D(DA_int_bmux[6]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[6]), .XQ(XQA), .Q(QA_int[6]));
  datapath_latch_sram_dp_hde_ibuf uDQA7 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[6]), .D(DA_int_bmux[7]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[7]), .XQ(XQA), .Q(QA_int[7]));
  datapath_latch_sram_dp_hde_ibuf uDQA8 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[9]), .D(DA_int_bmux[8]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[8]), .XQ(XQA), .Q(QA_int[8]));
  datapath_latch_sram_dp_hde_ibuf uDQA9 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[10]), .D(DA_int_bmux[9]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[9]), .XQ(XQA), .Q(QA_int[9]));
  datapath_latch_sram_dp_hde_ibuf uDQA10 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[11]), .D(DA_int_bmux[10]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[10]), .XQ(XQA), .Q(QA_int[10]));
  datapath_latch_sram_dp_hde_ibuf uDQA11 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[12]), .D(DA_int_bmux[11]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[11]), .XQ(XQA), .Q(QA_int[11]));
  datapath_latch_sram_dp_hde_ibuf uDQA12 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[13]), .D(DA_int_bmux[12]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[12]), .XQ(XQA), .Q(QA_int[12]));
  datapath_latch_sram_dp_hde_ibuf uDQA13 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[14]), .D(DA_int_bmux[13]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[13]), .XQ(XQA), .Q(QA_int[13]));
  datapath_latch_sram_dp_hde_ibuf uDQA14 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(QA_int[15]), .D(DA_int_bmux[14]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[14]), .XQ(XQA), .Q(QA_int[14]));
  datapath_latch_sram_dp_hde_ibuf uDQA15 (.CLK(CLKA), .Q_update(QA_update), .D_update(DA_sh_update), .SE(SEA_), .SI(SIA_int[1]), .D(DA_int_bmux[15]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_A[15]), .XQ(XQA), .Q(QA_int[15]));



  task readWriteB;
  begin
    if (WENB_int !== 1'b1 && DFTRAMBYP_int=== 1'b0 && SEB_int === 1'bx) begin
      failedWrite(1);
    end else if (DFTRAMBYP_int=== 1'b0 && SEB_int === 1'b1) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (RET1N_int === 1'bx || RET1N_int === 1'bz) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (RET1N_int === 1'b0 && (CENB_int === 1'b0 || DFTRAMBYP_int === 1'b1)) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (RET1N_int === 1'b0) begin
      // no cycle in retention mode
    end else if (^{(EMAB_int & isBit1(DFTRAMBYP_int)), (EMAWB_int & isBit1(DFTRAMBYP_int))} === 1'bx) begin
        XQB = 1'b1; QB_update = 1'b1;
    end else if (^{(CENB_int & !isBit1(DFTRAMBYP_int)), EMAB_int, EMAWB_int, RET1N_int} === 1'bx) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if ((AB_int >= WORDS) && (CENB_int === 1'b0) && DFTRAMBYP_int === 1'b0) begin
        XQB = WENB_int !== 1'b1 ? 1'b0 : 1'b1; QB_update = WENB_int !== 1'b1 ? 1'b0 : 1'b1;
    end else if (CENB_int === 1'b0 && (^AB_int) === 1'bx && DFTRAMBYP_int === 1'b0) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (CENB_int === 1'b0 || DFTRAMBYP_int === 1'b1) begin
      if(isBitX(DFTRAMBYP_int) || isBitX(SEB_int))
        DB_int = {16{1'bx}};

      mux_address = (AB_int & 3'b111);
      row_address = (AB_int >> 3);
      if (DFTRAMBYP_int !== 1'b1) begin
      if (row_address > 99)
        row = {128{1'bx}};
      else
        row = mem[row_address];
      end
      if(isBitX(DFTRAMBYP_int) || (isBitX(WENB_int) && DFTRAMBYP_int!==1)) begin
        writeEnable = {16{1'bx}};
        DB_int = {16{1'bx}};
      end else
          writeEnable = ~ {16{WENB_int}};
      if (WENB_int !== 1'b1 || DFTRAMBYP_int === 1'b1 || DFTRAMBYP_int === 1'bx) begin
        row_mask =  ( {7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14], 7'b0000000, writeEnable[13],
          7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11], 7'b0000000, writeEnable[10],
          7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8], 7'b0000000, writeEnable[7],
          7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5], 7'b0000000, writeEnable[4],
          7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2], 7'b0000000, writeEnable[1],
          7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, DB_int[15], 7'b0000000, DB_int[14], 7'b0000000, DB_int[13],
          7'b0000000, DB_int[12], 7'b0000000, DB_int[11], 7'b0000000, DB_int[10], 7'b0000000, DB_int[9],
          7'b0000000, DB_int[8], 7'b0000000, DB_int[7], 7'b0000000, DB_int[6], 7'b0000000, DB_int[5],
          7'b0000000, DB_int[4], 7'b0000000, DB_int[3], 7'b0000000, DB_int[2], 7'b0000000, DB_int[1],
          7'b0000000, DB_int[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        if (DFTRAMBYP_int === 1'b1 && SEB_int === 1'b0) begin
        end else if (WENB_int !== 1'b1 && DFTRAMBYP_int === 1'b1 && SEB_int === 1'bx) begin
        	XQB = 1'b1; QB_update = 1'b1;
        end else begin
        mem[row_address] = row;
        end
      end else begin
        data_out = (row >> (mux_address%4));
        readLatch1 = {data_out[124], data_out[120], data_out[116], data_out[112], data_out[108],
          data_out[104], data_out[100], data_out[96], data_out[92], data_out[88], data_out[84],
          data_out[80], data_out[76], data_out[72], data_out[68], data_out[64], data_out[60],
          data_out[56], data_out[52], data_out[48], data_out[44], data_out[40], data_out[36],
          data_out[32], data_out[28], data_out[24], data_out[20], data_out[16], data_out[12],
          data_out[8], data_out[4], data_out[0]};
        shifted_readLatch1 = (readLatch1 >> AB_int[2]);
        mem_path_B = {shifted_readLatch1[30], shifted_readLatch1[28], shifted_readLatch1[26],
          shifted_readLatch1[24], shifted_readLatch1[22], shifted_readLatch1[20], shifted_readLatch1[18],
          shifted_readLatch1[16], shifted_readLatch1[14], shifted_readLatch1[12], shifted_readLatch1[10],
          shifted_readLatch1[8], shifted_readLatch1[6], shifted_readLatch1[4], shifted_readLatch1[2],
          shifted_readLatch1[0]};
        	XQB = 1'b0; QB_update = 1'b1;
      end
      if (DFTRAMBYP_int === 1'b1) begin
        	XQB = 1'b0; QB_update = 1'b1;
      end
      if( isBitX(WENB_int) && DFTRAMBYP_int !== 1'b1) begin
        XQB = 1'b1; QB_update = 1'b1;
      end
      if( isBitX(DFTRAMBYP_int) ) begin
        XQB = 1'b1; QB_update = 1'b1;
      end
      if( isBitX(SEB_int) && DFTRAMBYP_int === 1'b1 ) begin
        XQB = 1'b1; QB_update = 1'b1;
      end
    end
  end
  endtask
  always @ (CENB_ or TCENB_ or TENB_ or DFTRAMBYP_ or CLKB_) begin
  	if(CLKB_ == 1'b0) begin
  		CENB_p2 = CENB_;
  		TCENB_p2 = TCENB_;
  		DFTRAMBYP_p2 = DFTRAMBYP_;
  	end
  end

`ifdef POWER_PINS
  always @ (RET1N_ or VDDPE or VDDCE) begin
`else     
  always @ RET1N_ begin
`endif
`ifdef POWER_PINS
    if (RET1N_ == 1'b1 && RET1N_int == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 && pre_charge_st_b == 1'b1 && (CENB_ === 1'bx || TCENB_ === 1'bx || DFTRAMBYP_ === 1'bx || CLKB_ === 1'bx)) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end
`else     
`endif
`ifdef POWER_PINS
`else     
      pre_charge_st_b = 0;
      pre_charge_st = 0;
`endif
    if (RET1N_ === 1'bx || RET1N_ === 1'bz) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (RET1N_ === 1'b0 && RET1N_int === 1'b1 && (CENB_p2 === 1'b0 || TCENB_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if (RET1N_ === 1'b1 && RET1N_int === 1'b0 && (CENB_p2 === 1'b0 || TCENB_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end
`ifdef POWER_PINS
    if (RET1N_ == 1'b0 && VDDCE == 1'b1 && VDDPE == 1'b1) begin
      pre_charge_st_b = 1;
      pre_charge_st = 1;
    end else if (RET1N_ == 1'b0 && VDDPE == 1'b0) begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
      if (VDDCE != 1'b1) begin
        failedWrite(1);
      end
`else     
    if (RET1N_ == 1'b0) begin
`endif
        XQB = 1'b1; QB_update = 1'b1;
      CENB_int = 1'bx;
      WENB_int = 1'bx;
      AB_int = {10{1'bx}};
      DB_int = {16{1'bx}};
      EMAB_int = {3{1'bx}};
      EMAWB_int = {2{1'bx}};
      TENB_int = 1'bx;
      TCENB_int = 1'bx;
      TWENB_int = 1'bx;
      TAB_int = {10{1'bx}};
      TDB_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SEB_int = 1'bx;
      COLLDISN_int = 1'bx;
`ifdef POWER_PINS
    end else if (RET1N_ == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 &&  pre_charge_st_b == 1'b1) begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
    end else begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
`else     
    end else begin
`endif
        XQB = 1'b1; QB_update = 1'b1;
      CENB_int = 1'bx;
      WENB_int = 1'bx;
      AB_int = {10{1'bx}};
      DB_int = {16{1'bx}};
      EMAB_int = {3{1'bx}};
      EMAWB_int = {2{1'bx}};
      TENB_int = 1'bx;
      TCENB_int = 1'bx;
      TWENB_int = 1'bx;
      TAB_int = {10{1'bx}};
      TDB_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SEB_int = 1'bx;
      COLLDISN_int = 1'bx;
    end
    RET1N_int = RET1N_;
    #0;
        QB_update = 1'b0;
  end


  always @ CLKB_ begin
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
`endif
`ifdef POWER_PINS
  if (RET1N_ == 1'b0) begin
`else     
  if (RET1N_ == 1'b0) begin
`endif
      // no cycle in retention mode
  end else begin
    if ((CLKB_ === 1'bx || CLKB_ === 1'bz) && RET1N_ !== 1'b0) begin
      failedWrite(1);
        XQB = 1'b1; QB_update = 1'b1;
    end else if ((CLKB_ === 1'b1 || CLKB_ === 1'b0) && LAST_CLKB === 1'bx) begin
       DB_sh_update = 1'b0;  XDB_sh = 1'b0;
       XQB = 1'b0; QB_update = 1'b0; 
    end else if (CLKB_ === 1'b1 && LAST_CLKB === 1'b0) begin
      DFTRAMBYP_int = DFTRAMBYP_;
      SEB_int = SEB_;
      CENB_int = TENB_ ? CENB_ : TCENB_;
      EMAB_int = EMAB_;
      EMAWB_int = EMAWB_;
      TENB_int = TENB_;
      TWENB_int = TWENB_;
      RET1N_int = RET1N_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENB_int != 1'b1) begin
        WENB_int = TENB_ ? WENB_ : TWENB_;
        AB_int = TENB_ ? AB_ : TAB_;
        DB_int = TENB_ ? DB_ : TDB_;
        TCENB_int = TCENB_;
        TAB_int = TAB_;
        TDB_int = TDB_;
        if (WENB_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
          read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
        end
      end
      clk1_int = 1'b0;
      if (DFTRAMBYP_=== 1'b1 && SEB_ === 1'b1) begin
         read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
         read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
        XQB = 1'b0; QB_update = 1'b1;
      end else begin
      CENB_int = TENB_ ? CENB_ : TCENB_;
      EMAB_int = EMAB_;
      EMAWB_int = EMAWB_;
      TENB_int = TENB_;
      TWENB_int = TWENB_;
      RET1N_int = RET1N_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENB_int != 1'b1) begin
        WENB_int = TENB_ ? WENB_ : TWENB_;
        AB_int = TENB_ ? AB_ : TAB_;
        DB_int = TENB_ ? DB_ : TDB_;
        TCENB_int = TCENB_;
        TAB_int = TAB_;
        TDB_int = TDB_;
        if (WENB_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
          read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
        end
      end
      clk1_int = 1'b0;
      if (CENB_int === 1'b0) previous_CLKB = $realtime;
    readWriteB;
      end
    #0;
      if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && COLLDISN_int === 1'b1 && row_contention(AA_int,
        AB_int, WENA_int, WENB_int)) begin
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQB = 1'b1; QB_update = 1'b1;
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQA = 1'b1; QA_update = 1'b1;
		end
        end else begin
          readWriteA;
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteA;
          readWriteB;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
      end else if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && (COLLDISN_int === 1'b0 || COLLDISN_int 
       === 1'bx)  && row_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
        XQA = 1'b1; QA_update = 1'b1;
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_READ_1 = 1;
          READ_WRITE_1 = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
        XQB = 1'b1; QB_update = 1'b1;
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
      end
    end else if (CLKB_ === 1'b0 && LAST_CLKB === 1'b1) begin
      QB_update = 1'b0;
      DB_sh_update = 1'b0;
      XQB = 1'b0;
         read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
    end
  end
    LAST_CLKB = CLKB_;
  end

  reg globalNotifier1;
  initial globalNotifier1 = 1'b0;

  always @ globalNotifier1 begin
    if ($realtime == 0) begin
    end else if ((EMAB_int[0] === 1'bx & DFTRAMBYP_int === 1'b1) || (EMAB_int[1] === 1'bx & DFTRAMBYP_int === 1'b1) || 
      (EMAB_int[2] === 1'bx & DFTRAMBYP_int === 1'b1) || (EMAWB_int[0] === 1'bx & DFTRAMBYP_int === 1'b1) || 
      (EMAWB_int[1] === 1'bx & DFTRAMBYP_int === 1'b1)) begin
        XQB = 1'b1; QB_update = 1'b1;
    end else if ((CENB_int === 1'bx & DFTRAMBYP_int === 1'b0) || EMAB_int[0] === 1'bx || 
      EMAB_int[1] === 1'bx || EMAB_int[2] === 1'bx || EMAWB_int[0] === 1'bx || EMAWB_int[1] === 1'bx || 
      RET1N_int === 1'bx || clk1_int === 1'bx) begin
        XQB = 1'b1; QB_update = 1'b1;
      failedWrite(1);
    end else if (TENB_int === 1'bx) begin
      if(((CENB_ === 1'b1 & TCENB_ === 1'b1) & DFTRAMBYP_int === 1'b0) | (DFTRAMBYP_int === 1'b1 & SEB_int === 1'b1)) begin
      end else begin
        XQB = 1'b1; QB_update = 1'b1;
      if (DFTRAMBYP_int === 1'b0) begin
          failedWrite(1);
      end
      end
    end else if  (cont_flag1_int === 1'bx && COLLDISN_int === 1'b1 &&  (CENB_int !== 1'b1 && ((TENA_ ? CENA_ : TCENA_) !== 1'b1) && DFTRAMBYP_ !== 1'b1) 
     && row_contention(TENA_ ? AA_ : TAA_, AB_int, WENB_int, TENA_ ? WENA_ : TWENA_)) begin
      cont_flag1_int = 1'b0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQB = 1'b1; QB_update = 1'b1;
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
        XQA = 1'b1; QA_update = 1'b1;
		end
        end else begin
          readWriteA;
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteA;
          readWriteB;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
    end else if  ((CENB_int !== 1'b1 && ((TENA_ ? CENA_ : TCENA_) !== 1'b1) && DFTRAMBYP_ !== 1'b1) && cont_flag1_int === 1'bx && (COLLDISN_int === 1'b0 
     || COLLDISN_int === 1'bx) && row_contention(TENA_ ? AA_ : TAA_, AB_int, WENB_int, TENA_ ? WENA_ : TWENA_)) begin
      cont_flag1_int = 1'b0;
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
        XQA = 1'b1; QA_update = 1'b1;
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_READ_1 = 1;
          READ_WRITE_1 = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
        XQB = 1'b1; QB_update = 1'b1;
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
    end else begin
      #0;
      readWriteB;
   end
      #0;
        XQB = 1'b0; QB_update = 1'b0;
    globalNotifier1 = 1'b0;
  end

  assign SIB_int = SEB_ ? SIB_ : {2{1'b0}};
  assign DB_int_bmux = TENB_ ? DB_ : TDB_;

  datapath_latch_sram_dp_hde_ibuf uDQB0 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(SIB_int[0]), .D(DB_int_bmux[0]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[0]), .XQ(XQB), .Q(QB_int[0]));
  datapath_latch_sram_dp_hde_ibuf uDQB1 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[0]), .D(DB_int_bmux[1]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[1]), .XQ(XQB), .Q(QB_int[1]));
  datapath_latch_sram_dp_hde_ibuf uDQB2 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[1]), .D(DB_int_bmux[2]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[2]), .XQ(XQB), .Q(QB_int[2]));
  datapath_latch_sram_dp_hde_ibuf uDQB3 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[2]), .D(DB_int_bmux[3]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[3]), .XQ(XQB), .Q(QB_int[3]));
  datapath_latch_sram_dp_hde_ibuf uDQB4 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[3]), .D(DB_int_bmux[4]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[4]), .XQ(XQB), .Q(QB_int[4]));
  datapath_latch_sram_dp_hde_ibuf uDQB5 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[4]), .D(DB_int_bmux[5]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[5]), .XQ(XQB), .Q(QB_int[5]));
  datapath_latch_sram_dp_hde_ibuf uDQB6 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[5]), .D(DB_int_bmux[6]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[6]), .XQ(XQB), .Q(QB_int[6]));
  datapath_latch_sram_dp_hde_ibuf uDQB7 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[6]), .D(DB_int_bmux[7]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[7]), .XQ(XQB), .Q(QB_int[7]));
  datapath_latch_sram_dp_hde_ibuf uDQB8 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[9]), .D(DB_int_bmux[8]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[8]), .XQ(XQB), .Q(QB_int[8]));
  datapath_latch_sram_dp_hde_ibuf uDQB9 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[10]), .D(DB_int_bmux[9]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[9]), .XQ(XQB), .Q(QB_int[9]));
  datapath_latch_sram_dp_hde_ibuf uDQB10 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[11]), .D(DB_int_bmux[10]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[10]), .XQ(XQB), .Q(QB_int[10]));
  datapath_latch_sram_dp_hde_ibuf uDQB11 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[12]), .D(DB_int_bmux[11]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[11]), .XQ(XQB), .Q(QB_int[11]));
  datapath_latch_sram_dp_hde_ibuf uDQB12 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[13]), .D(DB_int_bmux[12]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[12]), .XQ(XQB), .Q(QB_int[12]));
  datapath_latch_sram_dp_hde_ibuf uDQB13 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[14]), .D(DB_int_bmux[13]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[13]), .XQ(XQB), .Q(QB_int[13]));
  datapath_latch_sram_dp_hde_ibuf uDQB14 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(QB_int[15]), .D(DB_int_bmux[14]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[14]), .XQ(XQB), .Q(QB_int[14]));
  datapath_latch_sram_dp_hde_ibuf uDQB15 (.CLK(CLKB), .Q_update(QB_update), .D_update(DB_sh_update), .SE(SEB_), .SI(SIB_int[1]), .D(DB_int_bmux[15]), .DFTRAMBYP(DFTRAMBYP_), .mem_path(mem_path_B[15]), .XQ(XQB), .Q(QB_int[15]));


// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
 always @ (VDDCE or VDDPE or VSSE) begin
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
 end
`endif

  function row_contention;
    input [9:0] aa;
    input [9:0] ab;
    input  wena;
    input  wenb;
    reg result;
    reg sameRow;
    reg sameMux;
    reg anyWrite;
  begin
    anyWrite = ((& wena) === 1'b1 && (& wenb) === 1'b1) ? 1'b0 : 1'b1;
    sameMux = (aa[2:0] == ab[2:0]) ? 1'b1 : 1'b0;
    if (aa[9:3] == ab[9:3]) begin
      sameRow = 1'b1;
    end else begin
      sameRow = 1'b0;
    end
    if (sameRow == 1'b1 && anyWrite == 1'b1)
      row_contention = 1'b1;
    else if (sameRow == 1'b1 && sameMux == 1'b1)
      row_contention = 1'b1;
    else
      row_contention = 1'b0;
  end
  endfunction

  function col_contention;
    input [9:0] aa;
    input [9:0] ab;
  begin
    if (aa[2:0] == ab[2:0])
      col_contention = 1'b1;
    else
      col_contention = 1'b0;
  end
  endfunction

  function is_contention;
    input [9:0] aa;
    input [9:0] ab;
    input  wena;
    input  wenb;
    reg result;
  begin
    if ((& wena) === 1'b1 && (& wenb) === 1'b1) begin
      result = 1'b0;
    end else if (aa == ab) begin
      result = 1'b1;
    end else begin
      result = 1'b0;
    end
    is_contention = result;
  end
  endfunction

   wire contA_flag = (CENA_int !== 1'b1 && ((TENB_ ? CENB_ : TCENB_) !== 1'b1)) && ((COLLDISN_int === 1'b1 && is_contention(TENB_ ? AB_ : TAB_, AA_int, TENB_ ? WENB_ : TWENB_, WENA_int)) ||
              ((COLLDISN_int === 1'b0 || COLLDISN_int === 1'bx) && row_contention(TENB_ ? AB_ : TAB_, AA_int, TENB_ ? WENB_ : TWENB_, WENA_int)));
   wire contB_flag = (CENB_int !== 1'b1 && ((TENA_ ? CENA_ : TCENA_) !== 1'b1)) && ((COLLDISN_int === 1'b1 && is_contention(TENA_ ? AA_ : TAA_, AB_int, TENA_ ? WENA_ : TWENA_, WENB_int)) ||
              ((COLLDISN_int === 1'b0 || COLLDISN_int === 1'bx) && row_contention(TENA_ ? AA_ : TAA_, AB_int, TENA_ ? WENA_ : TWENA_, WENB_int)));

  always @ NOT_CENA begin
    CENA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_WENA begin
    WENA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA9 begin
    AA_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA8 begin
    AA_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA7 begin
    AA_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA6 begin
    AA_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA5 begin
    AA_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA4 begin
    AA_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA3 begin
    AA_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA2 begin
    AA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA1 begin
    AA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA0 begin
    AA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA15 begin
    DA_int[15] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA14 begin
    DA_int[14] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA13 begin
    DA_int[13] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA12 begin
    DA_int[12] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA11 begin
    DA_int[11] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA10 begin
    DA_int[10] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA9 begin
    DA_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA8 begin
    DA_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA7 begin
    DA_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA6 begin
    DA_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA5 begin
    DA_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA4 begin
    DA_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA3 begin
    DA_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA2 begin
    DA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA1 begin
    DA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA0 begin
    DA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CENB begin
    CENB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_WENB begin
    WENB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB9 begin
    AB_int[9] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB8 begin
    AB_int[8] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB7 begin
    AB_int[7] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB6 begin
    AB_int[6] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB5 begin
    AB_int[5] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB4 begin
    AB_int[4] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB3 begin
    AB_int[3] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB2 begin
    AB_int[2] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB1 begin
    AB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB0 begin
    AB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB15 begin
    DB_int[15] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB14 begin
    DB_int[14] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB13 begin
    DB_int[13] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB12 begin
    DB_int[12] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB11 begin
    DB_int[11] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB10 begin
    DB_int[10] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB9 begin
    DB_int[9] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB8 begin
    DB_int[8] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB7 begin
    DB_int[7] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB6 begin
    DB_int[6] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB5 begin
    DB_int[5] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB4 begin
    DB_int[4] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB3 begin
    DB_int[3] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB2 begin
    DB_int[2] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB1 begin
    DB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB0 begin
    DB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_EMAA2 begin
    EMAA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAA1 begin
    EMAA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAA0 begin
    EMAA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAWA1 begin
    EMAWA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAWA0 begin
    EMAWA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAB2 begin
    EMAB_int[2] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_EMAB1 begin
    EMAB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_EMAB0 begin
    EMAB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_EMAWB1 begin
    EMAWB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_EMAWB0 begin
    EMAWB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TENA begin
    TENA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TCENA begin
    CENA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TWENA begin
    WENA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA9 begin
    AA_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA8 begin
    AA_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA7 begin
    AA_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA6 begin
    AA_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA5 begin
    AA_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA4 begin
    AA_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA3 begin
    AA_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA2 begin
    AA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA1 begin
    AA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA0 begin
    AA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA15 begin
    DA_int[15] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA14 begin
    DA_int[14] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA13 begin
    DA_int[13] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA12 begin
    DA_int[12] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA11 begin
    DA_int[11] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA10 begin
    DA_int[10] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA9 begin
    DA_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA8 begin
    DA_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA7 begin
    DA_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA6 begin
    DA_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA5 begin
    DA_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA4 begin
    DA_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA3 begin
    DA_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA2 begin
    DA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA1 begin
    DA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA0 begin
    DA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TENB begin
    TENB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TCENB begin
    CENB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TWENB begin
    WENB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB9 begin
    AB_int[9] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB8 begin
    AB_int[8] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB7 begin
    AB_int[7] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB6 begin
    AB_int[6] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB5 begin
    AB_int[5] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB4 begin
    AB_int[4] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB3 begin
    AB_int[3] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB2 begin
    AB_int[2] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB1 begin
    AB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB0 begin
    AB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB15 begin
    DB_int[15] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB14 begin
    DB_int[14] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB13 begin
    DB_int[13] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB12 begin
    DB_int[12] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB11 begin
    DB_int[11] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB10 begin
    DB_int[10] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB9 begin
    DB_int[9] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB8 begin
    DB_int[8] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB7 begin
    DB_int[7] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB6 begin
    DB_int[6] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB5 begin
    DB_int[5] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB4 begin
    DB_int[4] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB3 begin
    DB_int[3] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB2 begin
    DB_int[2] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB1 begin
    DB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB0 begin
    DB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_SIA1 begin
        XQA = 1'b1; QA_update = 1'b1;
  end
  always @ NOT_SIA0 begin
        XQA = 1'b1; QA_update = 1'b1;
  end
  always @ NOT_SEA begin
        XQA = 1'b1; QA_update = 1'b1;
    SEA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DFTRAMBYP_CLKA begin
    DFTRAMBYP_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DFTRAMBYP_CLKB begin
    DFTRAMBYP_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_RET1N begin
    RET1N_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_SIB1 begin
        XQB = 1'b1; QB_update = 1'b1;
  end
  always @ NOT_SIB0 begin
        XQB = 1'b1; QB_update = 1'b1;
  end
  always @ NOT_SEB begin
        XQB = 1'b1; QB_update = 1'b1;
    SEB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_COLLDISN begin
    COLLDISN_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end

  always @ NOT_CONTA begin
    cont_flag0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CLKA_PER begin
    clk0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CLKA_MINH begin
    clk0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CLKA_MINL begin
    clk0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CONTB begin
    cont_flag1_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_CLKB_PER begin
    clk1_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_CLKB_MINH begin
    clk1_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_CLKB_MINL begin
    clk1_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end


  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;

  wire RET1Neq1aTENAeq1, RET1Neq1aTENAeq1aCENAeq0, RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0;
  wire RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0;
  wire RET1Neq1aTENBeq1, RET1Neq1aTENBeq1aCENBeq0, RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0;
  wire RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0;
  wire RET1Neq1aTENAeq0, RET1Neq1aTENAeq0aTCENAeq0, RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0;
  wire RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0;
  wire RET1Neq1aTENBeq0, RET1Neq1aTENBeq0aTCENBeq0, RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0;
  wire RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0;
  wire RET1Neq1aSEAeq1, RET1Neq1aSEBeq1, RET1Neq1, RET1Neq1aTENAeq1aCENAeq0oTENAeq0aTCENAeq0;
  wire RET1Neq1aTENBeq1aCENBeq0oTENBeq0aTCENBeq0;

  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0 = 
  RET1N && TENA && ((DFTRAMBYP && !SEA) || (!DFTRAMBYP && !CENA && !WENA));
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0 = 
  RET1N && TENB && ((DFTRAMBYP && !SEB) || (!DFTRAMBYP && !CENB && !WENB));
  assign RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !TENA && ((DFTRAMBYP && !SEA) || (!DFTRAMBYP && !TCENA && !TWENA));
  assign RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !TENB && ((DFTRAMBYP && !SEB) || (!DFTRAMBYP && !TCENB && !TWENB));

  assign RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0 = RET1N && TENA && !CENA && !COLLDISN;
  assign RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1 = RET1N && TENA && !CENA && COLLDISN;
  assign RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0 = RET1N && TENB && !CENB && !COLLDISN;
  assign RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1 = RET1N && TENB && !CENB && COLLDISN;
  assign RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0 = RET1N && !TENA && !TCENA && !COLLDISN;
  assign RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1 = RET1N && !TENA && !TCENA && COLLDISN;
  assign RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0 = RET1N && !TENB && !TCENB && !COLLDISN;
  assign RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1 = RET1N && !TENB && !TCENB && COLLDISN;
  assign RET1Neq1aTENAeq1aCENAeq0oTENAeq0aTCENAeq0 = RET1N && ((TENA && !CENA) || (!TENA && !TCENA));
  assign RET1Neq1aTENBeq1aCENBeq0oTENBeq0aTCENBeq0 = RET1N && ((TENB && !CENB) || (!TENB && !TCENB));

  assign RET1Neq1aTENAeq1aCENAeq0 = RET1N && TENA && !CENA;
  assign RET1Neq1aTENBeq1aCENBeq0 = RET1N && TENB && !CENB;
  assign RET1Neq1aTENAeq0aTCENAeq0 = RET1N && !TENA && !TCENA;
  assign RET1Neq1aTENBeq0aTCENBeq0 = RET1N && !TENB && !TCENB;

  assign RET1Neq1aTENAeq1 = RET1N && TENA;
  assign RET1Neq1aTENBeq1 = RET1N && TENB;
  assign RET1Neq1aTENAeq0 = RET1N && !TENA;
  assign RET1Neq1aTENBeq0 = RET1N && !TENB;
  assign RET1Neq1aSEAeq1 = RET1N && SEA;
  assign RET1Neq1aSEBeq1 = RET1N && SEB;
  assign RET1Neq1 = RET1N;

  specify

    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (CENA +=> CENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TCENA +=> CENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && CENA == 1'b0 && TCENA == 1'b1)
       (TENA -=> CENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && CENA == 1'b1 && TCENA == 1'b0)
       (TENA +=> CENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> CENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && WENA == 1'b0 && TWENA == 1'b1)
       (TENA -=> WENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && WENA == 1'b1 && TWENA == 1'b0)
       (TENA +=> WENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (WENA +=> WENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TWENA +=> WENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> WENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[9] == 1'b0 && TAA[9] == 1'b1)
       (TENA -=> AYA[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[9] == 1'b1 && TAA[9] == 1'b0)
       (TENA +=> AYA[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[8] == 1'b0 && TAA[8] == 1'b1)
       (TENA -=> AYA[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[8] == 1'b1 && TAA[8] == 1'b0)
       (TENA +=> AYA[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[7] == 1'b0 && TAA[7] == 1'b1)
       (TENA -=> AYA[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[7] == 1'b1 && TAA[7] == 1'b0)
       (TENA +=> AYA[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[6] == 1'b0 && TAA[6] == 1'b1)
       (TENA -=> AYA[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[6] == 1'b1 && TAA[6] == 1'b0)
       (TENA +=> AYA[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[5] == 1'b0 && TAA[5] == 1'b1)
       (TENA -=> AYA[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[5] == 1'b1 && TAA[5] == 1'b0)
       (TENA +=> AYA[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[4] == 1'b0 && TAA[4] == 1'b1)
       (TENA -=> AYA[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[4] == 1'b1 && TAA[4] == 1'b0)
       (TENA +=> AYA[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[3] == 1'b0 && TAA[3] == 1'b1)
       (TENA -=> AYA[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[3] == 1'b1 && TAA[3] == 1'b0)
       (TENA +=> AYA[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[2] == 1'b0 && TAA[2] == 1'b1)
       (TENA -=> AYA[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[2] == 1'b1 && TAA[2] == 1'b0)
       (TENA +=> AYA[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[1] == 1'b0 && TAA[1] == 1'b1)
       (TENA -=> AYA[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[1] == 1'b1 && TAA[1] == 1'b0)
       (TENA +=> AYA[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[0] == 1'b0 && TAA[0] == 1'b1)
       (TENA -=> AYA[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[0] == 1'b1 && TAA[0] == 1'b0)
       (TENA +=> AYA[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[9] +=> AYA[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[8] +=> AYA[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[7] +=> AYA[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[6] +=> AYA[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[5] +=> AYA[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[4] +=> AYA[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[3] +=> AYA[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[2] +=> AYA[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[1] +=> AYA[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[0] +=> AYA[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[9] +=> AYA[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[8] +=> AYA[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[7] +=> AYA[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[6] +=> AYA[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[5] +=> AYA[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[4] +=> AYA[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[3] +=> AYA[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[2] +=> AYA[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[1] +=> AYA[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[0] +=> AYA[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (CENB +=> CENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TCENB +=> CENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && CENB == 1'b0 && TCENB == 1'b1)
       (TENB -=> CENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && CENB == 1'b1 && TCENB == 1'b0)
       (TENB +=> CENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> CENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && WENB == 1'b0 && TWENB == 1'b1)
       (TENB -=> WENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && WENB == 1'b1 && TWENB == 1'b0)
       (TENB +=> WENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (WENB +=> WENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TWENB +=> WENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> WENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[9] == 1'b0 && TAB[9] == 1'b1)
       (TENB -=> AYB[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[9] == 1'b1 && TAB[9] == 1'b0)
       (TENB +=> AYB[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[8] == 1'b0 && TAB[8] == 1'b1)
       (TENB -=> AYB[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[8] == 1'b1 && TAB[8] == 1'b0)
       (TENB +=> AYB[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[7] == 1'b0 && TAB[7] == 1'b1)
       (TENB -=> AYB[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[7] == 1'b1 && TAB[7] == 1'b0)
       (TENB +=> AYB[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[6] == 1'b0 && TAB[6] == 1'b1)
       (TENB -=> AYB[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[6] == 1'b1 && TAB[6] == 1'b0)
       (TENB +=> AYB[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[5] == 1'b0 && TAB[5] == 1'b1)
       (TENB -=> AYB[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[5] == 1'b1 && TAB[5] == 1'b0)
       (TENB +=> AYB[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[4] == 1'b0 && TAB[4] == 1'b1)
       (TENB -=> AYB[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[4] == 1'b1 && TAB[4] == 1'b0)
       (TENB +=> AYB[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[3] == 1'b0 && TAB[3] == 1'b1)
       (TENB -=> AYB[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[3] == 1'b1 && TAB[3] == 1'b0)
       (TENB +=> AYB[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[2] == 1'b0 && TAB[2] == 1'b1)
       (TENB -=> AYB[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[2] == 1'b1 && TAB[2] == 1'b0)
       (TENB +=> AYB[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[1] == 1'b0 && TAB[1] == 1'b1)
       (TENB -=> AYB[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[1] == 1'b1 && TAB[1] == 1'b0)
       (TENB +=> AYB[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[0] == 1'b0 && TAB[0] == 1'b1)
       (TENB -=> AYB[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[0] == 1'b1 && TAB[0] == 1'b0)
       (TENB +=> AYB[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[9] +=> AYB[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[8] +=> AYB[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[7] +=> AYB[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[6] +=> AYB[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[5] +=> AYB[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[4] +=> AYB[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[3] +=> AYB[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[2] +=> AYB[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[1] +=> AYB[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[0] +=> AYB[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[9] +=> AYB[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[8] +=> AYB[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[7] +=> AYB[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[6] +=> AYB[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[5] +=> AYB[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[4] +=> AYB[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[3] +=> AYB[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[2] +=> AYB[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[1] +=> AYB[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[0] +=> AYB[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);


   // Define SDTC only if back-annotating SDF file generated by Design Compiler
   `ifdef NO_SDTC
       $period(posedge CLKA, `ARM_MEM_PERIOD, NOT_CLKA_PER);
   `else
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
   `endif

   // Define SDTC only if back-annotating SDF file generated by Design Compiler
   `ifdef NO_SDTC
       $period(posedge CLKB, `ARM_MEM_PERIOD, NOT_CLKB_PER);
   `else
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
   `endif


   // Define SDTC only if back-annotating SDF file generated by Design Compiler
   `ifdef NO_SDTC
       $width(posedge CLKA, `ARM_MEM_WIDTH, 0, NOT_CLKA_MINH);
       $width(negedge CLKA, `ARM_MEM_WIDTH, 0, NOT_CLKA_MINL);
   `else
       $width(posedge CLKA &&& RET1Neq1, `ARM_MEM_WIDTH, 0, NOT_CLKA_MINH);
       $width(negedge CLKA &&& RET1Neq1, `ARM_MEM_WIDTH, 0, NOT_CLKA_MINL);
   `endif

   // Define SDTC only if back-annotating SDF file generated by Design Compiler
   `ifdef NO_SDTC
       $width(posedge CLKB, `ARM_MEM_WIDTH, 0, NOT_CLKB_MINH);
       $width(negedge CLKB, `ARM_MEM_WIDTH, 0, NOT_CLKB_MINL);
   `else
       $width(posedge CLKB &&& RET1Neq1, `ARM_MEM_WIDTH, 0, NOT_CLKB_MINH);
       $width(negedge CLKB &&& RET1Neq1, `ARM_MEM_WIDTH, 0, NOT_CLKB_MINL);
   `endif


    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);

    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);

    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1, posedge CENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_CENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1, negedge CENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_CENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0, posedge WENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_WENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0, negedge WENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_WENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA15);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA14);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA13);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA12);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA11);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA10);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA15);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA14);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA13);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA12);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA11);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA10);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1, posedge CENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_CENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1, negedge CENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_CENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0, posedge WENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_WENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0, negedge WENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_WENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB15);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB14);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB13);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB12);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB11);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB10);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB15);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB14);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB13);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB12);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB11);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB10);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAWA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAWA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAWA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAWA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWA0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAWB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAWB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAWB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAWB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWB0);
    $setuphold(posedge CLKA &&& RET1Neq1, posedge TENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TENA);
    $setuphold(posedge CLKA &&& RET1Neq1, negedge TENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0, posedge TCENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TCENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0, negedge TCENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TCENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0, posedge TWENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TWENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0, negedge TWENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TWENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA15);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA14);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA13);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA12);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA11);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA10);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA15);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA14);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA13);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA12);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA11);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA10);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA0);
    $setuphold(posedge CLKB &&& RET1Neq1, posedge TENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TENB);
    $setuphold(posedge CLKB &&& RET1Neq1, negedge TENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0, posedge TCENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TCENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0, negedge TCENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TCENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0, posedge TWENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TWENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0, negedge TWENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TWENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB15);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB14);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB13);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB12);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB11);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB10);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB15);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB14);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB13);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB12);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB11);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB10);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB0);
    $setuphold(posedge CLKA, posedge RET1N, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CLKA, negedge RET1N, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CLKB, posedge RET1N, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CLKB, negedge RET1N, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CLKA &&& RET1Neq1aSEAeq1, posedge SIA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIA1);
    $setuphold(posedge CLKA &&& RET1Neq1aSEAeq1, posedge SIA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIA0);
    $setuphold(posedge CLKA &&& RET1Neq1aSEAeq1, negedge SIA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIA1);
    $setuphold(posedge CLKA &&& RET1Neq1aSEAeq1, negedge SIA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIA0);
    $setuphold(posedge CLKA &&& RET1Neq1, posedge SEA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SEA);
    $setuphold(posedge CLKA &&& RET1Neq1, negedge SEA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SEA);
    $setuphold(posedge CLKA &&& RET1Neq1, posedge DFTRAMBYP, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DFTRAMBYP_CLKA);
    $setuphold(posedge CLKA &&& RET1Neq1, negedge DFTRAMBYP, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DFTRAMBYP_CLKA);
    $setuphold(posedge CLKB &&& RET1Neq1, posedge DFTRAMBYP, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DFTRAMBYP_CLKB);
    $setuphold(posedge CLKB &&& RET1Neq1, negedge DFTRAMBYP, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DFTRAMBYP_CLKB);
    $setuphold(posedge CLKB &&& RET1Neq1aSEBeq1, posedge SIB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIB1);
    $setuphold(posedge CLKB &&& RET1Neq1aSEBeq1, posedge SIB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIB0);
    $setuphold(posedge CLKB &&& RET1Neq1aSEBeq1, negedge SIB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIB1);
    $setuphold(posedge CLKB &&& RET1Neq1aSEBeq1, negedge SIB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIB0);
    $setuphold(posedge CLKB &&& RET1Neq1, posedge SEB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SEB);
    $setuphold(posedge CLKB &&& RET1Neq1, negedge SEB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SEB);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0oTENAeq0aTCENAeq0, posedge COLLDISN, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_COLLDISN);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0oTENAeq0aTCENAeq0, negedge COLLDISN, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_COLLDISN);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0oTENBeq0aTCENBeq0, posedge COLLDISN, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_COLLDISN);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0oTENBeq0aTCENBeq0, negedge COLLDISN, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_COLLDISN);
    $setuphold(negedge RET1N, negedge CENA, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge RET1N, negedge CENA, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge RET1N, negedge CENB, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge RET1N, negedge CENB, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge RET1N, negedge TCENA, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge RET1N, negedge TCENA, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge RET1N, negedge TCENB, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge RET1N, negedge TCENB, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge DFTRAMBYP, posedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge DFTRAMBYP, negedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CENB, negedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CENA, negedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge TCENA, negedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge TCENB, negedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge TCENB, posedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge TCENA, posedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CENB, posedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CENA, posedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge RET1N, posedge DFTRAMBYP, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge RET1N, posedge DFTRAMBYP, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
  endspecify


endmodule
`endcelldefine
  `endif
  `else
// If ARM_UD_MODEL is defined at Simulator Command Line, it Selects the Fast Functional Model
`ifdef ARM_UD_MODEL

// Following parameter Values can be overridden at Simulator Command Line.

// ARM_UD_DP Defines the delay through Data Paths, for Memory Models it represents BIST MUX output delays.
`ifdef ARM_UD_DP
`else
`define ARM_UD_DP #0.001
`endif
// ARM_UD_CP Defines the delay through Clock Path Cells, for Memory Models it is not used.
`ifdef ARM_UD_CP
`else
`define ARM_UD_CP
`endif
// ARM_UD_SEQ Defines the delay through the Memory, for Memory Models it is used for CLK->Q delays.
`ifdef ARM_UD_SEQ
`else
`define ARM_UD_SEQ #0.01
`endif

`celldefine
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
module sram_dp_hde_ibuf (VDDCE, VDDPE, VSSE, CENYA, WENYA, AYA, CENYB, WENYB, AYB,
    QA, QB, SOA, SOB, CLKA, CENA, WENA, AA, DA, CLKB, CENB, WENB, AB, DB, EMAA, EMAWA,
    EMAB, EMAWB, TENA, TCENA, TWENA, TAA, TDA, TENB, TCENB, TWENB, TAB, TDB, RET1N,
    SIA, SEA, DFTRAMBYP, SIB, SEB, COLLDISN);
`else
module sram_dp_hde_ibuf (CENYA, WENYA, AYA, CENYB, WENYB, AYB, QA, QB, SOA, SOB, CLKA,
    CENA, WENA, AA, DA, CLKB, CENB, WENB, AB, DB, EMAA, EMAWA, EMAB, EMAWB, TENA, TCENA,
    TWENA, TAA, TDA, TENB, TCENB, TWENB, TAB, TDB, RET1N, SIA, SEA, DFTRAMBYP, SIB,
    SEB, COLLDISN);
`endif

  parameter ASSERT_PREFIX = "";
  parameter BITS = 16;
  parameter WORDS = 800;
  parameter MUX = 8;
  parameter MEM_WIDTH = 128; // redun block size 4, 64 on left, 64 on right
  parameter MEM_HEIGHT = 100;
  parameter WP_SIZE = 16 ;
  parameter UPM_WIDTH = 3;
  parameter UPMW_WIDTH = 2;
  parameter UPMS_WIDTH = 0;

  output  CENYA;
  output  WENYA;
  output [9:0] AYA;
  output  CENYB;
  output  WENYB;
  output [9:0] AYB;
  output [15:0] QA;
  output [15:0] QB;
  output [1:0] SOA;
  output [1:0] SOB;
  input  CLKA;
  input  CENA;
  input  WENA;
  input [9:0] AA;
  input [15:0] DA;
  input  CLKB;
  input  CENB;
  input  WENB;
  input [9:0] AB;
  input [15:0] DB;
  input [2:0] EMAA;
  input [1:0] EMAWA;
  input [2:0] EMAB;
  input [1:0] EMAWB;
  input  TENA;
  input  TCENA;
  input  TWENA;
  input [9:0] TAA;
  input [15:0] TDA;
  input  TENB;
  input  TCENB;
  input  TWENB;
  input [9:0] TAB;
  input [15:0] TDB;
  input  RET1N;
  input [1:0] SIA;
  input  SEA;
  input  DFTRAMBYP;
  input [1:0] SIB;
  input  SEB;
  input  COLLDISN;
`ifdef POWER_PINS
  inout VDDCE;
  inout VDDPE;
  inout VSSE;
`endif

  reg pre_charge_st;
  reg pre_charge_st_a;
  reg pre_charge_st_b;
  integer row_address;
  integer mux_address;
  reg [127:0] mem [0:99];
  reg [127:0] row, row_t;
  reg LAST_CLKA;
  reg [127:0] row_mask;
  reg [127:0] new_data;
  reg [127:0] data_out;
  reg [31:0] readLatch0;
  reg [31:0] shifted_readLatch0;
  reg  read_mux_sel0;
  reg  read_mux_sel0_p2;
  reg [31:0] readLatch1;
  reg [31:0] shifted_readLatch1;
  reg  read_mux_sel1;
  reg  read_mux_sel1_p2;
  reg LAST_CLKB;
  reg [15:0] QA_int;
  reg [15:0] QB_int;
  reg [15:0] writeEnable;
  real previous_CLKA;
  real previous_CLKB;
  initial previous_CLKA = 0;
  initial previous_CLKB = 0;
  reg READ_WRITE, WRITE_WRITE, READ_READ, ROW_CC, COL_CC;
  reg READ_WRITE_1, WRITE_WRITE_1, READ_READ_1;
  reg  cont_flag0_int;
  reg  cont_flag1_int;
  initial cont_flag0_int = 1'b0;
  initial cont_flag1_int = 1'b0;
  reg clk0_int;
  reg clk1_int;

  wire  CENYA_;
  wire  WENYA_;
  wire [9:0] AYA_;
  wire  CENYB_;
  wire  WENYB_;
  wire [9:0] AYB_;
  wire [15:0] QA_;
  wire [15:0] QB_;
  wire [1:0] SOA_;
  reg [1:0] SOA_int;
  wire [1:0] SOB_;
  reg [1:0] SOB_int;
 wire  CLKA_;
  wire  CENA_;
  reg  CENA_int;
  reg  CENA_p2;
  wire  WENA_;
  reg  WENA_int;
  wire [9:0] AA_;
  reg [9:0] AA_int;
  wire [15:0] DA_;
  reg [15:0] DA_int;
 wire  CLKB_;
  wire  CENB_;
  reg  CENB_int;
  reg  CENB_p2;
  wire  WENB_;
  reg  WENB_int;
  wire [9:0] AB_;
  reg [9:0] AB_int;
  wire [15:0] DB_;
  reg [15:0] DB_int;
  wire [2:0] EMAA_;
  reg [2:0] EMAA_int;
  wire [1:0] EMAWA_;
  reg [1:0] EMAWA_int;
  wire [2:0] EMAB_;
  reg [2:0] EMAB_int;
  wire [1:0] EMAWB_;
  reg [1:0] EMAWB_int;
  wire  TENA_;
  reg  TENA_int;
  wire  TCENA_;
  reg  TCENA_int;
  reg  TCENA_p2;
  wire  TWENA_;
  reg  TWENA_int;
  wire [9:0] TAA_;
  reg [9:0] TAA_int;
  wire [15:0] TDA_;
  reg [15:0] TDA_int;
  wire  TENB_;
  reg  TENB_int;
  wire  TCENB_;
  reg  TCENB_int;
  reg  TCENB_p2;
  wire  TWENB_;
  reg  TWENB_int;
  wire [9:0] TAB_;
  reg [9:0] TAB_int;
  wire [15:0] TDB_;
  reg [15:0] TDB_int;
  wire  RET1N_;
  reg  RET1N_int;
  wire [1:0] SIA_;
  reg [1:0] SIA_int;
  wire  SEA_;
  reg  SEA_int;
  wire  DFTRAMBYP_;
  reg  DFTRAMBYP_int;
  reg  DFTRAMBYP_p2;
  wire [1:0] SIB_;
  reg [1:0] SIB_int;
  wire  SEB_;
  reg  SEB_int;
  wire  COLLDISN_;
  reg  COLLDISN_int;

  assign CENYA = CENYA_; 
  assign WENYA = WENYA_; 
  assign AYA[0] = AYA_[0]; 
  assign AYA[1] = AYA_[1]; 
  assign AYA[2] = AYA_[2]; 
  assign AYA[3] = AYA_[3]; 
  assign AYA[4] = AYA_[4]; 
  assign AYA[5] = AYA_[5]; 
  assign AYA[6] = AYA_[6]; 
  assign AYA[7] = AYA_[7]; 
  assign AYA[8] = AYA_[8]; 
  assign AYA[9] = AYA_[9]; 
  assign CENYB = CENYB_; 
  assign WENYB = WENYB_; 
  assign AYB[0] = AYB_[0]; 
  assign AYB[1] = AYB_[1]; 
  assign AYB[2] = AYB_[2]; 
  assign AYB[3] = AYB_[3]; 
  assign AYB[4] = AYB_[4]; 
  assign AYB[5] = AYB_[5]; 
  assign AYB[6] = AYB_[6]; 
  assign AYB[7] = AYB_[7]; 
  assign AYB[8] = AYB_[8]; 
  assign AYB[9] = AYB_[9]; 
  assign QA[0] = QA_[0]; 
  assign QA[1] = QA_[1]; 
  assign QA[2] = QA_[2]; 
  assign QA[3] = QA_[3]; 
  assign QA[4] = QA_[4]; 
  assign QA[5] = QA_[5]; 
  assign QA[6] = QA_[6]; 
  assign QA[7] = QA_[7]; 
  assign QA[8] = QA_[8]; 
  assign QA[9] = QA_[9]; 
  assign QA[10] = QA_[10]; 
  assign QA[11] = QA_[11]; 
  assign QA[12] = QA_[12]; 
  assign QA[13] = QA_[13]; 
  assign QA[14] = QA_[14]; 
  assign QA[15] = QA_[15]; 
  assign QB[0] = QB_[0]; 
  assign QB[1] = QB_[1]; 
  assign QB[2] = QB_[2]; 
  assign QB[3] = QB_[3]; 
  assign QB[4] = QB_[4]; 
  assign QB[5] = QB_[5]; 
  assign QB[6] = QB_[6]; 
  assign QB[7] = QB_[7]; 
  assign QB[8] = QB_[8]; 
  assign QB[9] = QB_[9]; 
  assign QB[10] = QB_[10]; 
  assign QB[11] = QB_[11]; 
  assign QB[12] = QB_[12]; 
  assign QB[13] = QB_[13]; 
  assign QB[14] = QB_[14]; 
  assign QB[15] = QB_[15]; 
  assign SOA[0] = SOA_[0]; 
  assign SOA[1] = SOA_[1]; 
  assign SOB[0] = SOB_[0]; 
  assign SOB[1] = SOB_[1]; 
  assign CLKA_ = CLKA;
  assign CENA_ = CENA;
  assign WENA_ = WENA;
  assign AA_[0] = AA[0];
  assign AA_[1] = AA[1];
  assign AA_[2] = AA[2];
  assign AA_[3] = AA[3];
  assign AA_[4] = AA[4];
  assign AA_[5] = AA[5];
  assign AA_[6] = AA[6];
  assign AA_[7] = AA[7];
  assign AA_[8] = AA[8];
  assign AA_[9] = AA[9];
  assign DA_[0] = DA[0];
  assign DA_[1] = DA[1];
  assign DA_[2] = DA[2];
  assign DA_[3] = DA[3];
  assign DA_[4] = DA[4];
  assign DA_[5] = DA[5];
  assign DA_[6] = DA[6];
  assign DA_[7] = DA[7];
  assign DA_[8] = DA[8];
  assign DA_[9] = DA[9];
  assign DA_[10] = DA[10];
  assign DA_[11] = DA[11];
  assign DA_[12] = DA[12];
  assign DA_[13] = DA[13];
  assign DA_[14] = DA[14];
  assign DA_[15] = DA[15];
  assign CLKB_ = CLKB;
  assign CENB_ = CENB;
  assign WENB_ = WENB;
  assign AB_[0] = AB[0];
  assign AB_[1] = AB[1];
  assign AB_[2] = AB[2];
  assign AB_[3] = AB[3];
  assign AB_[4] = AB[4];
  assign AB_[5] = AB[5];
  assign AB_[6] = AB[6];
  assign AB_[7] = AB[7];
  assign AB_[8] = AB[8];
  assign AB_[9] = AB[9];
  assign DB_[0] = DB[0];
  assign DB_[1] = DB[1];
  assign DB_[2] = DB[2];
  assign DB_[3] = DB[3];
  assign DB_[4] = DB[4];
  assign DB_[5] = DB[5];
  assign DB_[6] = DB[6];
  assign DB_[7] = DB[7];
  assign DB_[8] = DB[8];
  assign DB_[9] = DB[9];
  assign DB_[10] = DB[10];
  assign DB_[11] = DB[11];
  assign DB_[12] = DB[12];
  assign DB_[13] = DB[13];
  assign DB_[14] = DB[14];
  assign DB_[15] = DB[15];
  assign EMAA_[0] = EMAA[0];
  assign EMAA_[1] = EMAA[1];
  assign EMAA_[2] = EMAA[2];
  assign EMAWA_[0] = EMAWA[0];
  assign EMAWA_[1] = EMAWA[1];
  assign EMAB_[0] = EMAB[0];
  assign EMAB_[1] = EMAB[1];
  assign EMAB_[2] = EMAB[2];
  assign EMAWB_[0] = EMAWB[0];
  assign EMAWB_[1] = EMAWB[1];
  assign TENA_ = TENA;
  assign TCENA_ = TCENA;
  assign TWENA_ = TWENA;
  assign TAA_[0] = TAA[0];
  assign TAA_[1] = TAA[1];
  assign TAA_[2] = TAA[2];
  assign TAA_[3] = TAA[3];
  assign TAA_[4] = TAA[4];
  assign TAA_[5] = TAA[5];
  assign TAA_[6] = TAA[6];
  assign TAA_[7] = TAA[7];
  assign TAA_[8] = TAA[8];
  assign TAA_[9] = TAA[9];
  assign TDA_[0] = TDA[0];
  assign TDA_[1] = TDA[1];
  assign TDA_[2] = TDA[2];
  assign TDA_[3] = TDA[3];
  assign TDA_[4] = TDA[4];
  assign TDA_[5] = TDA[5];
  assign TDA_[6] = TDA[6];
  assign TDA_[7] = TDA[7];
  assign TDA_[8] = TDA[8];
  assign TDA_[9] = TDA[9];
  assign TDA_[10] = TDA[10];
  assign TDA_[11] = TDA[11];
  assign TDA_[12] = TDA[12];
  assign TDA_[13] = TDA[13];
  assign TDA_[14] = TDA[14];
  assign TDA_[15] = TDA[15];
  assign TENB_ = TENB;
  assign TCENB_ = TCENB;
  assign TWENB_ = TWENB;
  assign TAB_[0] = TAB[0];
  assign TAB_[1] = TAB[1];
  assign TAB_[2] = TAB[2];
  assign TAB_[3] = TAB[3];
  assign TAB_[4] = TAB[4];
  assign TAB_[5] = TAB[5];
  assign TAB_[6] = TAB[6];
  assign TAB_[7] = TAB[7];
  assign TAB_[8] = TAB[8];
  assign TAB_[9] = TAB[9];
  assign TDB_[0] = TDB[0];
  assign TDB_[1] = TDB[1];
  assign TDB_[2] = TDB[2];
  assign TDB_[3] = TDB[3];
  assign TDB_[4] = TDB[4];
  assign TDB_[5] = TDB[5];
  assign TDB_[6] = TDB[6];
  assign TDB_[7] = TDB[7];
  assign TDB_[8] = TDB[8];
  assign TDB_[9] = TDB[9];
  assign TDB_[10] = TDB[10];
  assign TDB_[11] = TDB[11];
  assign TDB_[12] = TDB[12];
  assign TDB_[13] = TDB[13];
  assign TDB_[14] = TDB[14];
  assign TDB_[15] = TDB[15];
  assign RET1N_ = RET1N;
  assign SIA_[0] = SIA[0];
  assign SIA_[1] = SIA[1];
  assign SEA_ = SEA;
  assign DFTRAMBYP_ = DFTRAMBYP;
  assign SIB_[0] = SIB[0];
  assign SIB_[1] = SIB[1];
  assign SEB_ = SEB;
  assign COLLDISN_ = COLLDISN;

  assign `ARM_UD_DP CENYA_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENA_ ? CENA_ : TCENA_)) : 1'bx;
  assign `ARM_UD_DP WENYA_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENA_ ? WENA_ : TWENA_)) : 1'bx;
  assign `ARM_UD_DP AYA_ = (RET1N_ | pre_charge_st) ? ({10{DFTRAMBYP_}} & (TENA_ ? AA_ : TAA_)) : {10{1'bx}};
  assign `ARM_UD_DP CENYB_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENB_ ? CENB_ : TCENB_)) : 1'bx;
  assign `ARM_UD_DP WENYB_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENB_ ? WENB_ : TWENB_)) : 1'bx;
  assign `ARM_UD_DP AYB_ = (RET1N_ | pre_charge_st) ? ({10{DFTRAMBYP_}} & (TENB_ ? AB_ : TAB_)) : {10{1'bx}};
  assign `ARM_UD_SEQ QA_ = (RET1N_ | pre_charge_st) ? ((QA_int)) : {16{1'bx}};
  assign `ARM_UD_SEQ QB_ = (RET1N_ | pre_charge_st) ? ((QB_int)) : {16{1'bx}};
  assign `ARM_UD_DP SOA_ = (RET1N_ | pre_charge_st) ? ({QA_[8], QA_[7]}) : {2{1'bx}};
  assign `ARM_UD_DP SOB_ = (RET1N_ | pre_charge_st) ? ({QB_[8], QB_[7]}) : {2{1'bx}};

// If INITIALIZE_MEMORY is defined at Simulator Command Line, it Initializes the Memory with all ZEROS.
`ifdef INITIALIZE_MEMORY
  integer i;
  initial begin
    #0;
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'b0}};
  end
`endif
  always @ (EMAA_) begin
  	if(EMAA_ < 2) 
   	$display("Warning: Set Value for EMAA doesn't match Default value 2 in %m at %0t", $time);
  end
  always @ (EMAWA_) begin
  	if(EMAWA_ < 0) 
   	$display("Warning: Set Value for EMAWA doesn't match Default value 0 in %m at %0t", $time);
  end
  always @ (EMAB_) begin
  	if(EMAB_ < 2) 
   	$display("Warning: Set Value for EMAB doesn't match Default value 2 in %m at %0t", $time);
  end
  always @ (EMAWB_) begin
  	if(EMAWB_ < 0) 
   	$display("Warning: Set Value for EMAWB doesn't match Default value 0 in %m at %0t", $time);
  end

  task failedWrite;
  input port_f;
  integer i;
  begin
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'bx}};
  end
  endtask

  function isBitX;
    input bitval;
    begin
      isBitX = ( bitval===1'bx || bitval==1'bz ) ? 1'b1 : 1'b0;
    end
  endfunction

  function isBit1;
    input bitval;
    begin
      isBit1 = ( bitval===1'b1 ) ? 1'b1 : 1'b0;
    end
  endfunction



  task readWriteA;
  begin
    if (WENA_int !== 1'b1 && DFTRAMBYP_int=== 1'b0 && SEA_int === 1'bx) begin
      failedWrite(0);
    end else if (DFTRAMBYP_int=== 1'b0 && SEA_int === 1'b1) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (RET1N_int === 1'bx || RET1N_int === 1'bz) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (RET1N_int === 1'b0 && (CENA_int === 1'b0 || DFTRAMBYP_int === 1'b1)) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (RET1N_int === 1'b0) begin
      // no cycle in retention mode
    end else if (^{(EMAA_int & isBit1(DFTRAMBYP_int)), (EMAWA_int & isBit1(DFTRAMBYP_int))} === 1'bx) begin
        QA_int = {16{1'bx}};
    end else if (^{(CENA_int & !isBit1(DFTRAMBYP_int)), EMAA_int, EMAWA_int, RET1N_int} === 1'bx) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if ((AA_int >= WORDS) && (CENA_int === 1'b0) && DFTRAMBYP_int === 1'b0) begin
      QA_int = WENA_int !== 1'b1 ? QA_int : {16{1'bx}};
    end else if (CENA_int === 1'b0 && (^AA_int) === 1'bx && DFTRAMBYP_int === 1'b0) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (CENA_int === 1'b0 || DFTRAMBYP_int === 1'b1) begin
      if(isBitX(DFTRAMBYP_int) || isBitX(SEA_int))
        DA_int = {16{1'bx}};

      mux_address = (AA_int & 3'b111);
      row_address = (AA_int >> 3);
      if (DFTRAMBYP_int !== 1'b1) begin
      if (row_address > 99)
        row = {128{1'bx}};
      else
        row = mem[row_address];
      end
      if(isBitX(DFTRAMBYP_int) || (isBitX(WENA_int) && DFTRAMBYP_int!==1)) begin
        writeEnable = {16{1'bx}};
        DA_int = {16{1'bx}};
      end else
          writeEnable = ~ {16{WENA_int}};
      if (WENA_int !== 1'b1 || DFTRAMBYP_int === 1'b1 || DFTRAMBYP_int === 1'bx) begin
        row_mask =  ( {7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14], 7'b0000000, writeEnable[13],
          7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11], 7'b0000000, writeEnable[10],
          7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8], 7'b0000000, writeEnable[7],
          7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5], 7'b0000000, writeEnable[4],
          7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2], 7'b0000000, writeEnable[1],
          7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, DA_int[15], 7'b0000000, DA_int[14], 7'b0000000, DA_int[13],
          7'b0000000, DA_int[12], 7'b0000000, DA_int[11], 7'b0000000, DA_int[10], 7'b0000000, DA_int[9],
          7'b0000000, DA_int[8], 7'b0000000, DA_int[7], 7'b0000000, DA_int[6], 7'b0000000, DA_int[5],
          7'b0000000, DA_int[4], 7'b0000000, DA_int[3], 7'b0000000, DA_int[2], 7'b0000000, DA_int[1],
          7'b0000000, DA_int[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        if (DFTRAMBYP_int === 1'b1 && SEA_int === 1'b0) begin
        end else if (WENA_int !== 1'b1 && DFTRAMBYP_int === 1'b1 && SEA_int === 1'bx) begin
             QA_int = {16{1'bx}};
        end else begin
        mem[row_address] = row;
        end
      end else begin
        data_out = (row >> (mux_address%4));
        readLatch0 = {data_out[124], data_out[120], data_out[116], data_out[112], data_out[108],
          data_out[104], data_out[100], data_out[96], data_out[92], data_out[88], data_out[84],
          data_out[80], data_out[76], data_out[72], data_out[68], data_out[64], data_out[60],
          data_out[56], data_out[52], data_out[48], data_out[44], data_out[40], data_out[36],
          data_out[32], data_out[28], data_out[24], data_out[20], data_out[16], data_out[12],
          data_out[8], data_out[4], data_out[0]};
        shifted_readLatch0 = (readLatch0 >> AA_int[2]);
        QA_int = {shifted_readLatch0[30], shifted_readLatch0[28], shifted_readLatch0[26],
          shifted_readLatch0[24], shifted_readLatch0[22], shifted_readLatch0[20], shifted_readLatch0[18],
          shifted_readLatch0[16], shifted_readLatch0[14], shifted_readLatch0[12], shifted_readLatch0[10],
          shifted_readLatch0[8], shifted_readLatch0[6], shifted_readLatch0[4], shifted_readLatch0[2],
          shifted_readLatch0[0]};
      end
      if (DFTRAMBYP_int === 1'b1) begin
        QA_int = DA_int;
      end
      if( isBitX(WENA_int) && DFTRAMBYP_int !== 1'b1) begin
        QA_int = {16{1'bx}};
      end
      if( isBitX(DFTRAMBYP_int) )
        QA_int = {16{1'bx}};
    end
  end
  endtask
  always @ (CENA_ or TCENA_ or TENA_ or DFTRAMBYP_ or CLKA_) begin
  	if(CLKA_ == 1'b0) begin
  		CENA_p2 = CENA_;
  		TCENA_p2 = TCENA_;
  		DFTRAMBYP_p2 = DFTRAMBYP_;
  	end
  end

`ifdef POWER_PINS
  always @ (VDDCE) begin
      if (VDDCE != 1'b1) begin
       if (VDDPE == 1'b1) begin
        $display("VDDCE should be powered down after VDDPE, Illegal power down sequencing in %m at %0t", $time);
       end
        $display("In PowerDown Mode in %m at %0t", $time);
        failedWrite(0);
      end
      if (VDDCE == 1'b1) begin
       if (VDDPE == 1'b1) begin
        $display("VDDPE should be powered up after VDDCE in %m at %0t", $time);
        $display("Illegal power up sequencing in %m at %0t", $time);
       end
        failedWrite(0);
      end
  end
`endif
`ifdef POWER_PINS
  always @ (RET1N_ or VDDPE or VDDCE) begin
`else     
  always @ RET1N_ begin
`endif
`ifdef POWER_PINS
    if (RET1N_ == 1'b1 && RET1N_int == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 && pre_charge_st_a == 1'b1 && (CENA_ === 1'bx || TCENA_ === 1'bx || DFTRAMBYP_ === 1'bx || CLKA_ === 1'bx)) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end
`else     
`endif
`ifdef POWER_PINS
`else     
      pre_charge_st_a = 0;
      pre_charge_st = 0;
`endif
    if (RET1N_ === 1'bx || RET1N_ === 1'bz) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (RET1N_ === 1'b0 && RET1N_int === 1'b1 && (CENA_p2 === 1'b0 || TCENA_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (RET1N_ === 1'b1 && RET1N_int === 1'b0 && (CENA_p2 === 1'b0 || TCENA_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end
`ifdef POWER_PINS
    if (RET1N_ == 1'b0 && VDDCE == 1'b1 && VDDPE == 1'b1) begin
      pre_charge_st_a = 1;
      pre_charge_st = 1;
    end else if (RET1N_ == 1'b0 && VDDPE == 1'b0) begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
      if (VDDCE != 1'b1) begin
        failedWrite(0);
      end
`else     
    if (RET1N_ == 1'b0) begin
`endif
      QA_int = {16{1'bx}};
      CENA_int = 1'bx;
      WENA_int = 1'bx;
      AA_int = {10{1'bx}};
      DA_int = {16{1'bx}};
      EMAA_int = {3{1'bx}};
      EMAWA_int = {2{1'bx}};
      TENA_int = 1'bx;
      TCENA_int = 1'bx;
      TWENA_int = 1'bx;
      TAA_int = {10{1'bx}};
      TDA_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SIA_int = {2{1'bx}};
      SEA_int = 1'bx;
      DFTRAMBYP_int = 1'bx;
      COLLDISN_int = 1'bx;
`ifdef POWER_PINS
    end else if (RET1N_ == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 &&  pre_charge_st_a == 1'b1) begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
    end else begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
`else     
    end else begin
`endif
        QA_int = {16{1'bx}};
      CENA_int = 1'bx;
      WENA_int = 1'bx;
      AA_int = {10{1'bx}};
      DA_int = {16{1'bx}};
      EMAA_int = {3{1'bx}};
      EMAWA_int = {2{1'bx}};
      TENA_int = 1'bx;
      TCENA_int = 1'bx;
      TWENA_int = 1'bx;
      TAA_int = {10{1'bx}};
      TDA_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SIA_int = {2{1'bx}};
      SEA_int = 1'bx;
      DFTRAMBYP_int = 1'bx;
      COLLDISN_int = 1'bx;
    end
    RET1N_int = RET1N_;
  end

  always @ (SIA_int) begin
  	#0;
      if (DFTRAMBYP_=== 1'b1 && SEA_ === 1'b1 && ^SIA_int === 1'bx) begin
	QA_int[15] = SIA_int[1]; 
	QA_int[0] = SIA_int[0]; 
  	end
  end

  always @ CLKA_ begin
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
`endif
`ifdef POWER_PINS
  if (RET1N_ == 1'b0) begin
`else     
  if (RET1N_ == 1'b0) begin
`endif
      // no cycle in retention mode
  end else begin
    if ((CLKA_ === 1'bx || CLKA_ === 1'bz) && RET1N_ !== 1'b0) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (CLKA_ === 1'b1 && LAST_CLKA === 1'b0) begin
      SIA_int = SIA_;
      SEA_int = SEA_;
      DFTRAMBYP_int = DFTRAMBYP_;
      CENA_int = TENA_ ? CENA_ : TCENA_;
      EMAA_int = EMAA_;
      EMAWA_int = EMAWA_;
      TENA_int = TENA_;
      TWENA_int = TWENA_;
      RET1N_int = RET1N_;
      SIA_int = SIA_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENA_int != 1'b1) begin
        WENA_int = TENA_ ? WENA_ : TWENA_;
        AA_int = TENA_ ? AA_ : TAA_;
        DA_int = TENA_ ? DA_ : TDA_;
        TCENA_int = TCENA_;
        TAA_int = TAA_;
        TDA_int = TDA_;
        DFTRAMBYP_int = DFTRAMBYP_;
        if (WENA_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
          read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
        end
      end
      clk0_int = 1'b0;
      if (DFTRAMBYP_=== 1'b1 && SEA_ === 1'b1) begin
         read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
         read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
	QA_int[15:8] = {SIA_[1], QA_int[15:9]}; 
	QA_int[7:0] = {QA_int[6:0], SIA_[0]}; 
      end else begin
      CENA_int = TENA_ ? CENA_ : TCENA_;
      EMAA_int = EMAA_;
      EMAWA_int = EMAWA_;
      TENA_int = TENA_;
      TWENA_int = TWENA_;
      RET1N_int = RET1N_;
      SIA_int = SIA_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENA_int != 1'b1) begin
        WENA_int = TENA_ ? WENA_ : TWENA_;
        AA_int = TENA_ ? AA_ : TAA_;
        DA_int = TENA_ ? DA_ : TDA_;
        TCENA_int = TCENA_;
        TAA_int = TAA_;
        TDA_int = TDA_;
        DFTRAMBYP_int = DFTRAMBYP_;
        if (WENA_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
          read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
        end
      end
      clk0_int = 1'b0;
      if (CENA_int === 1'b0) previous_CLKA = $realtime;
    readWriteA;
      end
    #0;
      if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && COLLDISN_int === 1'b1 && row_contention(AA_int,
        AB_int, WENA_int, WENB_int)) begin
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QB_int = {16{1'bx}};
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QA_int = {16{1'bx}};
		end
        end else begin
          readWriteB;
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteB;
          readWriteA;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
      end else if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && (COLLDISN_int === 1'b0 || COLLDISN_int 
       === 1'bx)  && row_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
          QB_int = {16{1'bx}};
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE_1 = 1;
          READ_READ_1 = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          QA_int = {16{1'bx}};
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
      end
    end else if (CLKA_ === 1'b0 && LAST_CLKA === 1'b1) begin
         read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
    end
  end
    LAST_CLKA = CLKA_;
  end

  task readWriteB;
  begin
    if (WENB_int !== 1'b1 && DFTRAMBYP_int=== 1'b0 && SEB_int === 1'bx) begin
      failedWrite(1);
    end else if (DFTRAMBYP_int=== 1'b0 && SEB_int === 1'b1) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (RET1N_int === 1'bx || RET1N_int === 1'bz) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (RET1N_int === 1'b0 && (CENB_int === 1'b0 || DFTRAMBYP_int === 1'b1)) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (RET1N_int === 1'b0) begin
      // no cycle in retention mode
    end else if (^{(EMAB_int & isBit1(DFTRAMBYP_int)), (EMAWB_int & isBit1(DFTRAMBYP_int))} === 1'bx) begin
        QB_int = {16{1'bx}};
    end else if (^{(CENB_int & !isBit1(DFTRAMBYP_int)), EMAB_int, EMAWB_int, RET1N_int} === 1'bx) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if ((AB_int >= WORDS) && (CENB_int === 1'b0) && DFTRAMBYP_int === 1'b0) begin
      QB_int = WENB_int !== 1'b1 ? QB_int : {16{1'bx}};
    end else if (CENB_int === 1'b0 && (^AB_int) === 1'bx && DFTRAMBYP_int === 1'b0) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (CENB_int === 1'b0 || DFTRAMBYP_int === 1'b1) begin
      if(isBitX(DFTRAMBYP_int) || isBitX(SEB_int))
        DB_int = {16{1'bx}};

      mux_address = (AB_int & 3'b111);
      row_address = (AB_int >> 3);
      if (DFTRAMBYP_int !== 1'b1) begin
      if (row_address > 99)
        row = {128{1'bx}};
      else
        row = mem[row_address];
      end
      if(isBitX(DFTRAMBYP_int) || (isBitX(WENB_int) && DFTRAMBYP_int!==1)) begin
        writeEnable = {16{1'bx}};
        DB_int = {16{1'bx}};
      end else
          writeEnable = ~ {16{WENB_int}};
      if (WENB_int !== 1'b1 || DFTRAMBYP_int === 1'b1 || DFTRAMBYP_int === 1'bx) begin
        row_mask =  ( {7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14], 7'b0000000, writeEnable[13],
          7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11], 7'b0000000, writeEnable[10],
          7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8], 7'b0000000, writeEnable[7],
          7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5], 7'b0000000, writeEnable[4],
          7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2], 7'b0000000, writeEnable[1],
          7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, DB_int[15], 7'b0000000, DB_int[14], 7'b0000000, DB_int[13],
          7'b0000000, DB_int[12], 7'b0000000, DB_int[11], 7'b0000000, DB_int[10], 7'b0000000, DB_int[9],
          7'b0000000, DB_int[8], 7'b0000000, DB_int[7], 7'b0000000, DB_int[6], 7'b0000000, DB_int[5],
          7'b0000000, DB_int[4], 7'b0000000, DB_int[3], 7'b0000000, DB_int[2], 7'b0000000, DB_int[1],
          7'b0000000, DB_int[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        if (DFTRAMBYP_int === 1'b1 && SEB_int === 1'b0) begin
        end else if (WENB_int !== 1'b1 && DFTRAMBYP_int === 1'b1 && SEB_int === 1'bx) begin
             QB_int = {16{1'bx}};
        end else begin
        mem[row_address] = row;
        end
      end else begin
        data_out = (row >> (mux_address%4));
        readLatch1 = {data_out[124], data_out[120], data_out[116], data_out[112], data_out[108],
          data_out[104], data_out[100], data_out[96], data_out[92], data_out[88], data_out[84],
          data_out[80], data_out[76], data_out[72], data_out[68], data_out[64], data_out[60],
          data_out[56], data_out[52], data_out[48], data_out[44], data_out[40], data_out[36],
          data_out[32], data_out[28], data_out[24], data_out[20], data_out[16], data_out[12],
          data_out[8], data_out[4], data_out[0]};
        shifted_readLatch1 = (readLatch1 >> AB_int[2]);
        QB_int = {shifted_readLatch1[30], shifted_readLatch1[28], shifted_readLatch1[26],
          shifted_readLatch1[24], shifted_readLatch1[22], shifted_readLatch1[20], shifted_readLatch1[18],
          shifted_readLatch1[16], shifted_readLatch1[14], shifted_readLatch1[12], shifted_readLatch1[10],
          shifted_readLatch1[8], shifted_readLatch1[6], shifted_readLatch1[4], shifted_readLatch1[2],
          shifted_readLatch1[0]};
      end
      if (DFTRAMBYP_int === 1'b1) begin
        QB_int = DB_int;
      end
      if( isBitX(WENB_int) && DFTRAMBYP_int !== 1'b1) begin
        QB_int = {16{1'bx}};
      end
      if( isBitX(DFTRAMBYP_int) )
        QB_int = {16{1'bx}};
    end
  end
  endtask
  always @ (CENB_ or TCENB_ or TENB_ or DFTRAMBYP_ or CLKB_) begin
  	if(CLKB_ == 1'b0) begin
  		CENB_p2 = CENB_;
  		TCENB_p2 = TCENB_;
  		DFTRAMBYP_p2 = DFTRAMBYP_;
  	end
  end

`ifdef POWER_PINS
  always @ (RET1N_ or VDDPE or VDDCE) begin
`else     
  always @ RET1N_ begin
`endif
`ifdef POWER_PINS
    if (RET1N_ == 1'b1 && RET1N_int == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 && pre_charge_st_b == 1'b1 && (CENB_ === 1'bx || TCENB_ === 1'bx || DFTRAMBYP_ === 1'bx || CLKB_ === 1'bx)) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end
`else     
`endif
`ifdef POWER_PINS
`else     
      pre_charge_st_b = 0;
      pre_charge_st = 0;
`endif
    if (RET1N_ === 1'bx || RET1N_ === 1'bz) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (RET1N_ === 1'b0 && RET1N_int === 1'b1 && (CENB_p2 === 1'b0 || TCENB_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (RET1N_ === 1'b1 && RET1N_int === 1'b0 && (CENB_p2 === 1'b0 || TCENB_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end
`ifdef POWER_PINS
    if (RET1N_ == 1'b0 && VDDCE == 1'b1 && VDDPE == 1'b1) begin
      pre_charge_st_b = 1;
      pre_charge_st = 1;
    end else if (RET1N_ == 1'b0 && VDDPE == 1'b0) begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
      if (VDDCE != 1'b1) begin
        failedWrite(1);
      end
`else     
    if (RET1N_ == 1'b0) begin
`endif
      QB_int = {16{1'bx}};
      CENB_int = 1'bx;
      WENB_int = 1'bx;
      AB_int = {10{1'bx}};
      DB_int = {16{1'bx}};
      EMAB_int = {3{1'bx}};
      EMAWB_int = {2{1'bx}};
      TENB_int = 1'bx;
      TCENB_int = 1'bx;
      TWENB_int = 1'bx;
      TAB_int = {10{1'bx}};
      TDB_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SIB_int = {2{1'bx}};
      SEB_int = 1'bx;
      COLLDISN_int = 1'bx;
`ifdef POWER_PINS
    end else if (RET1N_ == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 &&  pre_charge_st_b == 1'b1) begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
    end else begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
`else     
    end else begin
`endif
        QB_int = {16{1'bx}};
      CENB_int = 1'bx;
      WENB_int = 1'bx;
      AB_int = {10{1'bx}};
      DB_int = {16{1'bx}};
      EMAB_int = {3{1'bx}};
      EMAWB_int = {2{1'bx}};
      TENB_int = 1'bx;
      TCENB_int = 1'bx;
      TWENB_int = 1'bx;
      TAB_int = {10{1'bx}};
      TDB_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SIB_int = {2{1'bx}};
      SEB_int = 1'bx;
      COLLDISN_int = 1'bx;
    end
    RET1N_int = RET1N_;
  end

  always @ (SIB_int) begin
  	#0;
      if (DFTRAMBYP_=== 1'b1 && SEB_ === 1'b1 && ^SIB_int === 1'bx) begin
	QB_int[15] = SIB_int[1]; 
	QB_int[0] = SIB_int[0]; 
  	end
  end

  always @ CLKB_ begin
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
`endif
`ifdef POWER_PINS
  if (RET1N_ == 1'b0) begin
`else     
  if (RET1N_ == 1'b0) begin
`endif
      // no cycle in retention mode
  end else begin
    if ((CLKB_ === 1'bx || CLKB_ === 1'bz) && RET1N_ !== 1'b0) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (CLKB_ === 1'b1 && LAST_CLKB === 1'b0) begin
      DFTRAMBYP_int = DFTRAMBYP_;
      SIB_int = SIB_;
      SEB_int = SEB_;
      CENB_int = TENB_ ? CENB_ : TCENB_;
      EMAB_int = EMAB_;
      EMAWB_int = EMAWB_;
      TENB_int = TENB_;
      TWENB_int = TWENB_;
      RET1N_int = RET1N_;
      SIB_int = SIB_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENB_int != 1'b1) begin
        WENB_int = TENB_ ? WENB_ : TWENB_;
        AB_int = TENB_ ? AB_ : TAB_;
        DB_int = TENB_ ? DB_ : TDB_;
        TCENB_int = TCENB_;
        TAB_int = TAB_;
        TDB_int = TDB_;
        if (WENB_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
          read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
        end
      end
      clk1_int = 1'b0;
      if (DFTRAMBYP_=== 1'b1 && SEB_ === 1'b1) begin
         read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
         read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
	QB_int[15:8] = {SIB_[1], QB_int[15:9]}; 
	QB_int[7:0] = {QB_int[6:0], SIB_[0]}; 
      end else begin
      CENB_int = TENB_ ? CENB_ : TCENB_;
      EMAB_int = EMAB_;
      EMAWB_int = EMAWB_;
      TENB_int = TENB_;
      TWENB_int = TWENB_;
      RET1N_int = RET1N_;
      SIB_int = SIB_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENB_int != 1'b1) begin
        WENB_int = TENB_ ? WENB_ : TWENB_;
        AB_int = TENB_ ? AB_ : TAB_;
        DB_int = TENB_ ? DB_ : TDB_;
        TCENB_int = TCENB_;
        TAB_int = TAB_;
        TDB_int = TDB_;
        if (WENB_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
          read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
        end
      end
      clk1_int = 1'b0;
      if (CENB_int === 1'b0) previous_CLKB = $realtime;
    readWriteB;
      end
    #0;
      if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && COLLDISN_int === 1'b1 && row_contention(AA_int,
        AB_int, WENA_int, WENB_int)) begin
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QB_int = {16{1'bx}};
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QA_int = {16{1'bx}};
		end
        end else begin
          readWriteA;
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteA;
          readWriteB;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
      end else if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && (COLLDISN_int === 1'b0 || COLLDISN_int 
       === 1'bx)  && row_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
          QA_int = {16{1'bx}};
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_READ_1 = 1;
          READ_WRITE_1 = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          QB_int = {16{1'bx}};
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
      end
    end else if (CLKB_ === 1'b0 && LAST_CLKB === 1'b1) begin
         read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
    end
  end
    LAST_CLKB = CLKB_;
  end
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
 always @ (VDDCE or VDDPE or VSSE) begin
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
 end
`endif

  function row_contention;
    input [9:0] aa;
    input [9:0] ab;
    input  wena;
    input  wenb;
    reg result;
    reg sameRow;
    reg sameMux;
    reg anyWrite;
  begin
    anyWrite = ((& wena) === 1'b1 && (& wenb) === 1'b1) ? 1'b0 : 1'b1;
    sameMux = (aa[2:0] == ab[2:0]) ? 1'b1 : 1'b0;
    if (aa[9:3] == ab[9:3]) begin
      sameRow = 1'b1;
    end else begin
      sameRow = 1'b0;
    end
    if (sameRow == 1'b1 && anyWrite == 1'b1)
      row_contention = 1'b1;
    else if (sameRow == 1'b1 && sameMux == 1'b1)
      row_contention = 1'b1;
    else
      row_contention = 1'b0;
  end
  endfunction

  function col_contention;
    input [9:0] aa;
    input [9:0] ab;
  begin
    if (aa[2:0] == ab[2:0])
      col_contention = 1'b1;
    else
      col_contention = 1'b0;
  end
  endfunction

  function is_contention;
    input [9:0] aa;
    input [9:0] ab;
    input  wena;
    input  wenb;
    reg result;
  begin
    if ((& wena) === 1'b1 && (& wenb) === 1'b1) begin
      result = 1'b0;
    end else if (aa == ab) begin
      result = 1'b1;
    end else begin
      result = 1'b0;
    end
    is_contention = result;
  end
  endfunction


endmodule
`endcelldefine
`else
`celldefine
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
module sram_dp_hde_ibuf (VDDCE, VDDPE, VSSE, CENYA, WENYA, AYA, CENYB, WENYB, AYB,
    QA, QB, SOA, SOB, CLKA, CENA, WENA, AA, DA, CLKB, CENB, WENB, AB, DB, EMAA, EMAWA,
    EMAB, EMAWB, TENA, TCENA, TWENA, TAA, TDA, TENB, TCENB, TWENB, TAB, TDB, RET1N,
    SIA, SEA, DFTRAMBYP, SIB, SEB, COLLDISN);
`else
module sram_dp_hde_ibuf (CENYA, WENYA, AYA, CENYB, WENYB, AYB, QA, QB, SOA, SOB, CLKA,
    CENA, WENA, AA, DA, CLKB, CENB, WENB, AB, DB, EMAA, EMAWA, EMAB, EMAWB, TENA, TCENA,
    TWENA, TAA, TDA, TENB, TCENB, TWENB, TAB, TDB, RET1N, SIA, SEA, DFTRAMBYP, SIB,
    SEB, COLLDISN);
`endif

  parameter ASSERT_PREFIX = "";
  parameter BITS = 16;
  parameter WORDS = 800;
  parameter MUX = 8;
  parameter MEM_WIDTH = 128; // redun block size 4, 64 on left, 64 on right
  parameter MEM_HEIGHT = 100;
  parameter WP_SIZE = 16 ;
  parameter UPM_WIDTH = 3;
  parameter UPMW_WIDTH = 2;
  parameter UPMS_WIDTH = 0;

  output  CENYA;
  output  WENYA;
  output [9:0] AYA;
  output  CENYB;
  output  WENYB;
  output [9:0] AYB;
  output [15:0] QA;
  output [15:0] QB;
  output [1:0] SOA;
  output [1:0] SOB;
  input  CLKA;
  input  CENA;
  input  WENA;
  input [9:0] AA;
  input [15:0] DA;
  input  CLKB;
  input  CENB;
  input  WENB;
  input [9:0] AB;
  input [15:0] DB;
  input [2:0] EMAA;
  input [1:0] EMAWA;
  input [2:0] EMAB;
  input [1:0] EMAWB;
  input  TENA;
  input  TCENA;
  input  TWENA;
  input [9:0] TAA;
  input [15:0] TDA;
  input  TENB;
  input  TCENB;
  input  TWENB;
  input [9:0] TAB;
  input [15:0] TDB;
  input  RET1N;
  input [1:0] SIA;
  input  SEA;
  input  DFTRAMBYP;
  input [1:0] SIB;
  input  SEB;
  input  COLLDISN;
`ifdef POWER_PINS
  inout VDDCE;
  inout VDDPE;
  inout VSSE;
`endif

  reg pre_charge_st;
  reg pre_charge_st_a;
  reg pre_charge_st_b;
  integer row_address;
  integer mux_address;
  reg [127:0] mem [0:99];
  reg [127:0] row, row_t;
  reg LAST_CLKA;
  reg [127:0] row_mask;
  reg [127:0] new_data;
  reg [127:0] data_out;
  reg [31:0] readLatch0;
  reg [31:0] shifted_readLatch0;
  reg  read_mux_sel0;
  reg  read_mux_sel0_p2;
  reg [31:0] readLatch1;
  reg [31:0] shifted_readLatch1;
  reg  read_mux_sel1;
  reg  read_mux_sel1_p2;
  reg LAST_CLKB;
  reg [15:0] QA_int;
  reg [15:0] QB_int;
  reg [15:0] writeEnable;
  real previous_CLKA;
  real previous_CLKB;
  initial previous_CLKA = 0;
  initial previous_CLKB = 0;
  reg READ_WRITE, WRITE_WRITE, READ_READ, ROW_CC, COL_CC;
  reg READ_WRITE_1, WRITE_WRITE_1, READ_READ_1;
  reg  cont_flag0_int;
  reg  cont_flag1_int;
  initial cont_flag0_int = 1'b0;
  initial cont_flag1_int = 1'b0;

  reg NOT_CENA, NOT_WENA, NOT_AA9, NOT_AA8, NOT_AA7, NOT_AA6, NOT_AA5, NOT_AA4, NOT_AA3;
  reg NOT_AA2, NOT_AA1, NOT_AA0, NOT_DA15, NOT_DA14, NOT_DA13, NOT_DA12, NOT_DA11;
  reg NOT_DA10, NOT_DA9, NOT_DA8, NOT_DA7, NOT_DA6, NOT_DA5, NOT_DA4, NOT_DA3, NOT_DA2;
  reg NOT_DA1, NOT_DA0, NOT_CENB, NOT_WENB, NOT_AB9, NOT_AB8, NOT_AB7, NOT_AB6, NOT_AB5;
  reg NOT_AB4, NOT_AB3, NOT_AB2, NOT_AB1, NOT_AB0, NOT_DB15, NOT_DB14, NOT_DB13, NOT_DB12;
  reg NOT_DB11, NOT_DB10, NOT_DB9, NOT_DB8, NOT_DB7, NOT_DB6, NOT_DB5, NOT_DB4, NOT_DB3;
  reg NOT_DB2, NOT_DB1, NOT_DB0, NOT_EMAA2, NOT_EMAA1, NOT_EMAA0, NOT_EMAWA1, NOT_EMAWA0;
  reg NOT_EMAB2, NOT_EMAB1, NOT_EMAB0, NOT_EMAWB1, NOT_EMAWB0, NOT_TENA, NOT_TCENA;
  reg NOT_TWENA, NOT_TAA9, NOT_TAA8, NOT_TAA7, NOT_TAA6, NOT_TAA5, NOT_TAA4, NOT_TAA3;
  reg NOT_TAA2, NOT_TAA1, NOT_TAA0, NOT_TDA15, NOT_TDA14, NOT_TDA13, NOT_TDA12, NOT_TDA11;
  reg NOT_TDA10, NOT_TDA9, NOT_TDA8, NOT_TDA7, NOT_TDA6, NOT_TDA5, NOT_TDA4, NOT_TDA3;
  reg NOT_TDA2, NOT_TDA1, NOT_TDA0, NOT_TENB, NOT_TCENB, NOT_TWENB, NOT_TAB9, NOT_TAB8;
  reg NOT_TAB7, NOT_TAB6, NOT_TAB5, NOT_TAB4, NOT_TAB3, NOT_TAB2, NOT_TAB1, NOT_TAB0;
  reg NOT_TDB15, NOT_TDB14, NOT_TDB13, NOT_TDB12, NOT_TDB11, NOT_TDB10, NOT_TDB9, NOT_TDB8;
  reg NOT_TDB7, NOT_TDB6, NOT_TDB5, NOT_TDB4, NOT_TDB3, NOT_TDB2, NOT_TDB1, NOT_TDB0;
  reg NOT_SIA1, NOT_SIA0, NOT_SEA, NOT_DFTRAMBYP_CLKA, NOT_DFTRAMBYP_CLKB, NOT_RET1N;
  reg NOT_SIB1, NOT_SIB0, NOT_SEB, NOT_COLLDISN;
  reg NOT_CONTA, NOT_CLKA_PER, NOT_CLKA_MINH, NOT_CLKA_MINL, NOT_CONTB, NOT_CLKB_PER;
  reg NOT_CLKB_MINH, NOT_CLKB_MINL;
  reg clk0_int;
  reg clk1_int;

  wire  CENYA_;
  wire  WENYA_;
  wire [9:0] AYA_;
  wire  CENYB_;
  wire  WENYB_;
  wire [9:0] AYB_;
  wire [15:0] QA_;
  wire [15:0] QB_;
  wire [1:0] SOA_;
  reg [1:0] SOA_int;
  wire [1:0] SOB_;
  reg [1:0] SOB_int;
 wire  CLKA_;
  wire  CENA_;
  reg  CENA_int;
  reg  CENA_p2;
  wire  WENA_;
  reg  WENA_int;
  wire [9:0] AA_;
  reg [9:0] AA_int;
  wire [15:0] DA_;
  reg [15:0] DA_int;
 wire  CLKB_;
  wire  CENB_;
  reg  CENB_int;
  reg  CENB_p2;
  wire  WENB_;
  reg  WENB_int;
  wire [9:0] AB_;
  reg [9:0] AB_int;
  wire [15:0] DB_;
  reg [15:0] DB_int;
  wire [2:0] EMAA_;
  reg [2:0] EMAA_int;
  wire [1:0] EMAWA_;
  reg [1:0] EMAWA_int;
  wire [2:0] EMAB_;
  reg [2:0] EMAB_int;
  wire [1:0] EMAWB_;
  reg [1:0] EMAWB_int;
  wire  TENA_;
  reg  TENA_int;
  wire  TCENA_;
  reg  TCENA_int;
  reg  TCENA_p2;
  wire  TWENA_;
  reg  TWENA_int;
  wire [9:0] TAA_;
  reg [9:0] TAA_int;
  wire [15:0] TDA_;
  reg [15:0] TDA_int;
  wire  TENB_;
  reg  TENB_int;
  wire  TCENB_;
  reg  TCENB_int;
  reg  TCENB_p2;
  wire  TWENB_;
  reg  TWENB_int;
  wire [9:0] TAB_;
  reg [9:0] TAB_int;
  wire [15:0] TDB_;
  reg [15:0] TDB_int;
  wire  RET1N_;
  reg  RET1N_int;
  wire [1:0] SIA_;
  reg [1:0] SIA_int;
  wire  SEA_;
  reg  SEA_int;
  wire  DFTRAMBYP_;
  reg  DFTRAMBYP_int;
  reg  DFTRAMBYP_p2;
  wire [1:0] SIB_;
  reg [1:0] SIB_int;
  wire  SEB_;
  reg  SEB_int;
  wire  COLLDISN_;
  reg  COLLDISN_int;

  buf B195(CENYA, CENYA_);
  buf B196(WENYA, WENYA_);
  buf B197(AYA[0], AYA_[0]);
  buf B198(AYA[1], AYA_[1]);
  buf B199(AYA[2], AYA_[2]);
  buf B200(AYA[3], AYA_[3]);
  buf B201(AYA[4], AYA_[4]);
  buf B202(AYA[5], AYA_[5]);
  buf B203(AYA[6], AYA_[6]);
  buf B204(AYA[7], AYA_[7]);
  buf B205(AYA[8], AYA_[8]);
  buf B206(AYA[9], AYA_[9]);
  buf B207(CENYB, CENYB_);
  buf B208(WENYB, WENYB_);
  buf B209(AYB[0], AYB_[0]);
  buf B210(AYB[1], AYB_[1]);
  buf B211(AYB[2], AYB_[2]);
  buf B212(AYB[3], AYB_[3]);
  buf B213(AYB[4], AYB_[4]);
  buf B214(AYB[5], AYB_[5]);
  buf B215(AYB[6], AYB_[6]);
  buf B216(AYB[7], AYB_[7]);
  buf B217(AYB[8], AYB_[8]);
  buf B218(AYB[9], AYB_[9]);
  buf B219(QA[0], QA_[0]);
  buf B220(QA[1], QA_[1]);
  buf B221(QA[2], QA_[2]);
  buf B222(QA[3], QA_[3]);
  buf B223(QA[4], QA_[4]);
  buf B224(QA[5], QA_[5]);
  buf B225(QA[6], QA_[6]);
  buf B226(QA[7], QA_[7]);
  buf B227(QA[8], QA_[8]);
  buf B228(QA[9], QA_[9]);
  buf B229(QA[10], QA_[10]);
  buf B230(QA[11], QA_[11]);
  buf B231(QA[12], QA_[12]);
  buf B232(QA[13], QA_[13]);
  buf B233(QA[14], QA_[14]);
  buf B234(QA[15], QA_[15]);
  buf B235(QB[0], QB_[0]);
  buf B236(QB[1], QB_[1]);
  buf B237(QB[2], QB_[2]);
  buf B238(QB[3], QB_[3]);
  buf B239(QB[4], QB_[4]);
  buf B240(QB[5], QB_[5]);
  buf B241(QB[6], QB_[6]);
  buf B242(QB[7], QB_[7]);
  buf B243(QB[8], QB_[8]);
  buf B244(QB[9], QB_[9]);
  buf B245(QB[10], QB_[10]);
  buf B246(QB[11], QB_[11]);
  buf B247(QB[12], QB_[12]);
  buf B248(QB[13], QB_[13]);
  buf B249(QB[14], QB_[14]);
  buf B250(QB[15], QB_[15]);
  buf B251(SOA[0], SOA_[0]);
  buf B252(SOA[1], SOA_[1]);
  buf B253(SOB[0], SOB_[0]);
  buf B254(SOB[1], SOB_[1]);
  buf B255(CLKA_, CLKA);
  buf B256(CENA_, CENA);
  buf B257(WENA_, WENA);
  buf B258(AA_[0], AA[0]);
  buf B259(AA_[1], AA[1]);
  buf B260(AA_[2], AA[2]);
  buf B261(AA_[3], AA[3]);
  buf B262(AA_[4], AA[4]);
  buf B263(AA_[5], AA[5]);
  buf B264(AA_[6], AA[6]);
  buf B265(AA_[7], AA[7]);
  buf B266(AA_[8], AA[8]);
  buf B267(AA_[9], AA[9]);
  buf B268(DA_[0], DA[0]);
  buf B269(DA_[1], DA[1]);
  buf B270(DA_[2], DA[2]);
  buf B271(DA_[3], DA[3]);
  buf B272(DA_[4], DA[4]);
  buf B273(DA_[5], DA[5]);
  buf B274(DA_[6], DA[6]);
  buf B275(DA_[7], DA[7]);
  buf B276(DA_[8], DA[8]);
  buf B277(DA_[9], DA[9]);
  buf B278(DA_[10], DA[10]);
  buf B279(DA_[11], DA[11]);
  buf B280(DA_[12], DA[12]);
  buf B281(DA_[13], DA[13]);
  buf B282(DA_[14], DA[14]);
  buf B283(DA_[15], DA[15]);
  buf B284(CLKB_, CLKB);
  buf B285(CENB_, CENB);
  buf B286(WENB_, WENB);
  buf B287(AB_[0], AB[0]);
  buf B288(AB_[1], AB[1]);
  buf B289(AB_[2], AB[2]);
  buf B290(AB_[3], AB[3]);
  buf B291(AB_[4], AB[4]);
  buf B292(AB_[5], AB[5]);
  buf B293(AB_[6], AB[6]);
  buf B294(AB_[7], AB[7]);
  buf B295(AB_[8], AB[8]);
  buf B296(AB_[9], AB[9]);
  buf B297(DB_[0], DB[0]);
  buf B298(DB_[1], DB[1]);
  buf B299(DB_[2], DB[2]);
  buf B300(DB_[3], DB[3]);
  buf B301(DB_[4], DB[4]);
  buf B302(DB_[5], DB[5]);
  buf B303(DB_[6], DB[6]);
  buf B304(DB_[7], DB[7]);
  buf B305(DB_[8], DB[8]);
  buf B306(DB_[9], DB[9]);
  buf B307(DB_[10], DB[10]);
  buf B308(DB_[11], DB[11]);
  buf B309(DB_[12], DB[12]);
  buf B310(DB_[13], DB[13]);
  buf B311(DB_[14], DB[14]);
  buf B312(DB_[15], DB[15]);
  buf B313(EMAA_[0], EMAA[0]);
  buf B314(EMAA_[1], EMAA[1]);
  buf B315(EMAA_[2], EMAA[2]);
  buf B316(EMAWA_[0], EMAWA[0]);
  buf B317(EMAWA_[1], EMAWA[1]);
  buf B318(EMAB_[0], EMAB[0]);
  buf B319(EMAB_[1], EMAB[1]);
  buf B320(EMAB_[2], EMAB[2]);
  buf B321(EMAWB_[0], EMAWB[0]);
  buf B322(EMAWB_[1], EMAWB[1]);
  buf B323(TENA_, TENA);
  buf B324(TCENA_, TCENA);
  buf B325(TWENA_, TWENA);
  buf B326(TAA_[0], TAA[0]);
  buf B327(TAA_[1], TAA[1]);
  buf B328(TAA_[2], TAA[2]);
  buf B329(TAA_[3], TAA[3]);
  buf B330(TAA_[4], TAA[4]);
  buf B331(TAA_[5], TAA[5]);
  buf B332(TAA_[6], TAA[6]);
  buf B333(TAA_[7], TAA[7]);
  buf B334(TAA_[8], TAA[8]);
  buf B335(TAA_[9], TAA[9]);
  buf B336(TDA_[0], TDA[0]);
  buf B337(TDA_[1], TDA[1]);
  buf B338(TDA_[2], TDA[2]);
  buf B339(TDA_[3], TDA[3]);
  buf B340(TDA_[4], TDA[4]);
  buf B341(TDA_[5], TDA[5]);
  buf B342(TDA_[6], TDA[6]);
  buf B343(TDA_[7], TDA[7]);
  buf B344(TDA_[8], TDA[8]);
  buf B345(TDA_[9], TDA[9]);
  buf B346(TDA_[10], TDA[10]);
  buf B347(TDA_[11], TDA[11]);
  buf B348(TDA_[12], TDA[12]);
  buf B349(TDA_[13], TDA[13]);
  buf B350(TDA_[14], TDA[14]);
  buf B351(TDA_[15], TDA[15]);
  buf B352(TENB_, TENB);
  buf B353(TCENB_, TCENB);
  buf B354(TWENB_, TWENB);
  buf B355(TAB_[0], TAB[0]);
  buf B356(TAB_[1], TAB[1]);
  buf B357(TAB_[2], TAB[2]);
  buf B358(TAB_[3], TAB[3]);
  buf B359(TAB_[4], TAB[4]);
  buf B360(TAB_[5], TAB[5]);
  buf B361(TAB_[6], TAB[6]);
  buf B362(TAB_[7], TAB[7]);
  buf B363(TAB_[8], TAB[8]);
  buf B364(TAB_[9], TAB[9]);
  buf B365(TDB_[0], TDB[0]);
  buf B366(TDB_[1], TDB[1]);
  buf B367(TDB_[2], TDB[2]);
  buf B368(TDB_[3], TDB[3]);
  buf B369(TDB_[4], TDB[4]);
  buf B370(TDB_[5], TDB[5]);
  buf B371(TDB_[6], TDB[6]);
  buf B372(TDB_[7], TDB[7]);
  buf B373(TDB_[8], TDB[8]);
  buf B374(TDB_[9], TDB[9]);
  buf B375(TDB_[10], TDB[10]);
  buf B376(TDB_[11], TDB[11]);
  buf B377(TDB_[12], TDB[12]);
  buf B378(TDB_[13], TDB[13]);
  buf B379(TDB_[14], TDB[14]);
  buf B380(TDB_[15], TDB[15]);
  buf B381(RET1N_, RET1N);
  buf B382(SIA_[0], SIA[0]);
  buf B383(SIA_[1], SIA[1]);
  buf B384(SEA_, SEA);
  buf B385(DFTRAMBYP_, DFTRAMBYP);
  buf B386(SIB_[0], SIB[0]);
  buf B387(SIB_[1], SIB[1]);
  buf B388(SEB_, SEB);
  buf B389(COLLDISN_, COLLDISN);

  assign CENYA_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENA_ ? CENA_ : TCENA_)) : 1'bx;
  assign WENYA_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENA_ ? WENA_ : TWENA_)) : 1'bx;
  assign AYA_ = (RET1N_ | pre_charge_st) ? ({10{DFTRAMBYP_}} & (TENA_ ? AA_ : TAA_)) : {10{1'bx}};
  assign CENYB_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENB_ ? CENB_ : TCENB_)) : 1'bx;
  assign WENYB_ = (RET1N_ | pre_charge_st) ? (DFTRAMBYP_ & (TENB_ ? WENB_ : TWENB_)) : 1'bx;
  assign AYB_ = (RET1N_ | pre_charge_st) ? ({10{DFTRAMBYP_}} & (TENB_ ? AB_ : TAB_)) : {10{1'bx}};
   `ifdef ARM_FAULT_MODELING
     sram_dp_hde_ibuf_error_injection u1(.CLK(CLKA_), .Q_out(QA_), .A(AA_int), .CEN(CENA_int), .DFTRAMBYP(DFTRAMBYP_int), .SE(SEA_int), .WEN(WENA_int), .Q_in(QA_int));
  `else
  assign QA_ = (RET1N_ | pre_charge_st) ? ((QA_int)) : {16{1'bx}};
  `endif
  assign QB_ = (RET1N_ | pre_charge_st) ? ((QB_int)) : {16{1'bx}};
  assign SOA_ = (RET1N_ | pre_charge_st) ? ({QA_[8], QA_[7]}) : {2{1'bx}};
  assign SOB_ = (RET1N_ | pre_charge_st) ? ({QB_[8], QB_[7]}) : {2{1'bx}};

// If INITIALIZE_MEMORY is defined at Simulator Command Line, it Initializes the Memory with all ZEROS.
`ifdef INITIALIZE_MEMORY
  integer i;
  initial begin
    #0;
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'b0}};
  end
`endif
  always @ (EMAA_) begin
  	if(EMAA_ < 2) 
   	$display("Warning: Set Value for EMAA doesn't match Default value 2 in %m at %0t", $time);
  end
  always @ (EMAWA_) begin
  	if(EMAWA_ < 0) 
   	$display("Warning: Set Value for EMAWA doesn't match Default value 0 in %m at %0t", $time);
  end
  always @ (EMAB_) begin
  	if(EMAB_ < 2) 
   	$display("Warning: Set Value for EMAB doesn't match Default value 2 in %m at %0t", $time);
  end
  always @ (EMAWB_) begin
  	if(EMAWB_ < 0) 
   	$display("Warning: Set Value for EMAWB doesn't match Default value 0 in %m at %0t", $time);
  end

  task failedWrite;
  input port_f;
  integer i;
  begin
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'bx}};
  end
  endtask

  function isBitX;
    input bitval;
    begin
      isBitX = ( bitval===1'bx || bitval==1'bz ) ? 1'b1 : 1'b0;
    end
  endfunction

  function isBit1;
    input bitval;
    begin
      isBit1 = ( bitval===1'b1 ) ? 1'b1 : 1'b0;
    end
  endfunction



  task readWriteA;
  begin
    if (WENA_int !== 1'b1 && DFTRAMBYP_int=== 1'b0 && SEA_int === 1'bx) begin
      failedWrite(0);
    end else if (DFTRAMBYP_int=== 1'b0 && SEA_int === 1'b1) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (RET1N_int === 1'bx || RET1N_int === 1'bz) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (RET1N_int === 1'b0 && (CENA_int === 1'b0 || DFTRAMBYP_int === 1'b1)) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (RET1N_int === 1'b0) begin
      // no cycle in retention mode
    end else if (^{(EMAA_int & isBit1(DFTRAMBYP_int)), (EMAWA_int & isBit1(DFTRAMBYP_int))} === 1'bx) begin
        QA_int = {16{1'bx}};
    end else if (^{(CENA_int & !isBit1(DFTRAMBYP_int)), EMAA_int, EMAWA_int, RET1N_int} === 1'bx) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if ((AA_int >= WORDS) && (CENA_int === 1'b0) && DFTRAMBYP_int === 1'b0) begin
      QA_int = WENA_int !== 1'b1 ? QA_int : {16{1'bx}};
    end else if (CENA_int === 1'b0 && (^AA_int) === 1'bx && DFTRAMBYP_int === 1'b0) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (CENA_int === 1'b0 || DFTRAMBYP_int === 1'b1) begin
      if(isBitX(DFTRAMBYP_int) || isBitX(SEA_int))
        DA_int = {16{1'bx}};

      mux_address = (AA_int & 3'b111);
      row_address = (AA_int >> 3);
      if (DFTRAMBYP_int !== 1'b1) begin
      if (row_address > 99)
        row = {128{1'bx}};
      else
        row = mem[row_address];
      end
      if(isBitX(DFTRAMBYP_int) || (isBitX(WENA_int) && DFTRAMBYP_int!==1)) begin
        writeEnable = {16{1'bx}};
        DA_int = {16{1'bx}};
      end else
          writeEnable = ~ {16{WENA_int}};
      if (WENA_int !== 1'b1 || DFTRAMBYP_int === 1'b1 || DFTRAMBYP_int === 1'bx) begin
        row_mask =  ( {7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14], 7'b0000000, writeEnable[13],
          7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11], 7'b0000000, writeEnable[10],
          7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8], 7'b0000000, writeEnable[7],
          7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5], 7'b0000000, writeEnable[4],
          7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2], 7'b0000000, writeEnable[1],
          7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, DA_int[15], 7'b0000000, DA_int[14], 7'b0000000, DA_int[13],
          7'b0000000, DA_int[12], 7'b0000000, DA_int[11], 7'b0000000, DA_int[10], 7'b0000000, DA_int[9],
          7'b0000000, DA_int[8], 7'b0000000, DA_int[7], 7'b0000000, DA_int[6], 7'b0000000, DA_int[5],
          7'b0000000, DA_int[4], 7'b0000000, DA_int[3], 7'b0000000, DA_int[2], 7'b0000000, DA_int[1],
          7'b0000000, DA_int[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        if (DFTRAMBYP_int === 1'b1 && SEA_int === 1'b0) begin
        end else if (WENA_int !== 1'b1 && DFTRAMBYP_int === 1'b1 && SEA_int === 1'bx) begin
             QA_int = {16{1'bx}};
        end else begin
        mem[row_address] = row;
        end
      end else begin
        data_out = (row >> (mux_address%4));
        readLatch0 = {data_out[124], data_out[120], data_out[116], data_out[112], data_out[108],
          data_out[104], data_out[100], data_out[96], data_out[92], data_out[88], data_out[84],
          data_out[80], data_out[76], data_out[72], data_out[68], data_out[64], data_out[60],
          data_out[56], data_out[52], data_out[48], data_out[44], data_out[40], data_out[36],
          data_out[32], data_out[28], data_out[24], data_out[20], data_out[16], data_out[12],
          data_out[8], data_out[4], data_out[0]};
        shifted_readLatch0 = (readLatch0 >> AA_int[2]);
        QA_int = {shifted_readLatch0[30], shifted_readLatch0[28], shifted_readLatch0[26],
          shifted_readLatch0[24], shifted_readLatch0[22], shifted_readLatch0[20], shifted_readLatch0[18],
          shifted_readLatch0[16], shifted_readLatch0[14], shifted_readLatch0[12], shifted_readLatch0[10],
          shifted_readLatch0[8], shifted_readLatch0[6], shifted_readLatch0[4], shifted_readLatch0[2],
          shifted_readLatch0[0]};
      end
      if (DFTRAMBYP_int === 1'b1) begin
        QA_int = DA_int;
      end
      if( isBitX(WENA_int) && DFTRAMBYP_int !== 1'b1) begin
        QA_int = {16{1'bx}};
      end
      if( isBitX(DFTRAMBYP_int) )
        QA_int = {16{1'bx}};
    end
  end
  endtask
  always @ (CENA_ or TCENA_ or TENA_ or DFTRAMBYP_ or CLKA_) begin
  	if(CLKA_ == 1'b0) begin
  		CENA_p2 = CENA_;
  		TCENA_p2 = TCENA_;
  		DFTRAMBYP_p2 = DFTRAMBYP_;
  	end
  end

`ifdef POWER_PINS
  always @ (VDDCE) begin
      if (VDDCE != 1'b1) begin
       if (VDDPE == 1'b1) begin
        $display("VDDCE should be powered down after VDDPE, Illegal power down sequencing in %m at %0t", $time);
       end
        $display("In PowerDown Mode in %m at %0t", $time);
        failedWrite(0);
      end
      if (VDDCE == 1'b1) begin
       if (VDDPE == 1'b1) begin
        $display("VDDPE should be powered up after VDDCE in %m at %0t", $time);
        $display("Illegal power up sequencing in %m at %0t", $time);
       end
        failedWrite(0);
      end
  end
`endif
`ifdef POWER_PINS
  always @ (RET1N_ or VDDPE or VDDCE) begin
`else     
  always @ RET1N_ begin
`endif
`ifdef POWER_PINS
    if (RET1N_ == 1'b1 && RET1N_int == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 && pre_charge_st_a == 1'b1 && (CENA_ === 1'bx || TCENA_ === 1'bx || DFTRAMBYP_ === 1'bx || CLKA_ === 1'bx)) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end
`else     
`endif
`ifdef POWER_PINS
`else     
      pre_charge_st_a = 0;
      pre_charge_st = 0;
`endif
    if (RET1N_ === 1'bx || RET1N_ === 1'bz) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (RET1N_ === 1'b0 && RET1N_int === 1'b1 && (CENA_p2 === 1'b0 || TCENA_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (RET1N_ === 1'b1 && RET1N_int === 1'b0 && (CENA_p2 === 1'b0 || TCENA_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end
`ifdef POWER_PINS
    if (RET1N_ == 1'b0 && VDDCE == 1'b1 && VDDPE == 1'b1) begin
      pre_charge_st_a = 1;
      pre_charge_st = 1;
    end else if (RET1N_ == 1'b0 && VDDPE == 1'b0) begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
      if (VDDCE != 1'b1) begin
        failedWrite(0);
      end
`else     
    if (RET1N_ == 1'b0) begin
`endif
      QA_int = {16{1'bx}};
      CENA_int = 1'bx;
      WENA_int = 1'bx;
      AA_int = {10{1'bx}};
      DA_int = {16{1'bx}};
      EMAA_int = {3{1'bx}};
      EMAWA_int = {2{1'bx}};
      TENA_int = 1'bx;
      TCENA_int = 1'bx;
      TWENA_int = 1'bx;
      TAA_int = {10{1'bx}};
      TDA_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SIA_int = {2{1'bx}};
      SEA_int = 1'bx;
      DFTRAMBYP_int = 1'bx;
      COLLDISN_int = 1'bx;
`ifdef POWER_PINS
    end else if (RET1N_ == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 &&  pre_charge_st_a == 1'b1) begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
    end else begin
      pre_charge_st_a = 0;
      pre_charge_st = 0;
`else     
    end else begin
`endif
        QA_int = {16{1'bx}};
      CENA_int = 1'bx;
      WENA_int = 1'bx;
      AA_int = {10{1'bx}};
      DA_int = {16{1'bx}};
      EMAA_int = {3{1'bx}};
      EMAWA_int = {2{1'bx}};
      TENA_int = 1'bx;
      TCENA_int = 1'bx;
      TWENA_int = 1'bx;
      TAA_int = {10{1'bx}};
      TDA_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SIA_int = {2{1'bx}};
      SEA_int = 1'bx;
      DFTRAMBYP_int = 1'bx;
      COLLDISN_int = 1'bx;
    end
    RET1N_int = RET1N_;
  end

  always @ (SIA_int) begin
  	#0;
      if (DFTRAMBYP_=== 1'b1 && SEA_ === 1'b1 && ^SIA_int === 1'bx) begin
	QA_int[15] = SIA_int[1]; 
	QA_int[0] = SIA_int[0]; 
  	end
  end

  always @ CLKA_ begin
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
`endif
`ifdef POWER_PINS
  if (RET1N_ == 1'b0) begin
`else     
  if (RET1N_ == 1'b0) begin
`endif
      // no cycle in retention mode
  end else begin
    if ((CLKA_ === 1'bx || CLKA_ === 1'bz) && RET1N_ !== 1'b0) begin
      failedWrite(0);
        QA_int = {16{1'bx}};
    end else if (CLKA_ === 1'b1 && LAST_CLKA === 1'b0) begin
      SIA_int = SIA_;
      SEA_int = SEA_;
      DFTRAMBYP_int = DFTRAMBYP_;
      CENA_int = TENA_ ? CENA_ : TCENA_;
      EMAA_int = EMAA_;
      EMAWA_int = EMAWA_;
      TENA_int = TENA_;
      TWENA_int = TWENA_;
      RET1N_int = RET1N_;
      SIA_int = SIA_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENA_int != 1'b1) begin
        WENA_int = TENA_ ? WENA_ : TWENA_;
        AA_int = TENA_ ? AA_ : TAA_;
        DA_int = TENA_ ? DA_ : TDA_;
        TCENA_int = TCENA_;
        TAA_int = TAA_;
        TDA_int = TDA_;
        DFTRAMBYP_int = DFTRAMBYP_;
        if (WENA_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
          read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
        end
      end
      clk0_int = 1'b0;
      if (DFTRAMBYP_=== 1'b1 && SEA_ === 1'b1) begin
         read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
         read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
	QA_int[15:8] = {SIA_[1], QA_int[15:9]}; 
	QA_int[7:0] = {QA_int[6:0], SIA_[0]}; 
      end else begin
      CENA_int = TENA_ ? CENA_ : TCENA_;
      EMAA_int = EMAA_;
      EMAWA_int = EMAWA_;
      TENA_int = TENA_;
      TWENA_int = TWENA_;
      RET1N_int = RET1N_;
      SIA_int = SIA_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENA_int != 1'b1) begin
        WENA_int = TENA_ ? WENA_ : TWENA_;
        AA_int = TENA_ ? AA_ : TAA_;
        DA_int = TENA_ ? DA_ : TDA_;
        TCENA_int = TCENA_;
        TAA_int = TAA_;
        TDA_int = TDA_;
        DFTRAMBYP_int = DFTRAMBYP_;
        if (WENA_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel0 = (TENA_ ? AA_[2] : TAA_[2] );
          read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
        end
      end
      clk0_int = 1'b0;
      if (CENA_int === 1'b0) previous_CLKA = $realtime;
    readWriteA;
      end
    #0;
      if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && COLLDISN_int === 1'b1 && row_contention(AA_int,
        AB_int, WENA_int, WENB_int)) begin
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QB_int = {16{1'bx}};
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QA_int = {16{1'bx}};
		end
        end else begin
          readWriteB;
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteB;
          readWriteA;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
      end else if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && (COLLDISN_int === 1'b0 || COLLDISN_int 
       === 1'bx)  && row_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
          QB_int = {16{1'bx}};
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE_1 = 1;
          READ_READ_1 = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          QA_int = {16{1'bx}};
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
      end
    end else if (CLKA_ === 1'b0 && LAST_CLKA === 1'b1) begin
         read_mux_sel0_p2 = ((^read_mux_sel0 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel0;
    end
  end
    LAST_CLKA = CLKA_;
  end

  reg globalNotifier0;
  initial globalNotifier0 = 1'b0;

  always @ globalNotifier0 begin
    if ($realtime == 0) begin
    end else if ((EMAA_int[0] === 1'bx & DFTRAMBYP_int === 1'b1) || (EMAA_int[1] === 1'bx & DFTRAMBYP_int === 1'b1) || 
      (EMAA_int[2] === 1'bx & DFTRAMBYP_int === 1'b1) || (EMAWA_int[0] === 1'bx & DFTRAMBYP_int === 1'b1) || 
      (EMAWA_int[1] === 1'bx & DFTRAMBYP_int === 1'b1)) begin
        QA_int = {16{1'bx}};
    end else if ((CENA_int === 1'bx & DFTRAMBYP_int === 1'b0) || EMAA_int[0] === 1'bx || 
      EMAA_int[1] === 1'bx || EMAA_int[2] === 1'bx || EMAWA_int[0] === 1'bx || EMAWA_int[1] === 1'bx || 
      RET1N_int === 1'bx || clk0_int === 1'bx) begin
        QA_int = {16{1'bx}};
      failedWrite(0);
    end else if (TENA_int === 1'bx) begin
      if(((CENA_ === 1'b1 & TCENA_ === 1'b1) & DFTRAMBYP_int === 1'b0) | (DFTRAMBYP_int === 1'b1 & SEA_int === 1'b1)) begin
      end else begin
        QA_int = {16{1'bx}};
      if (DFTRAMBYP_int === 1'b0) begin
          failedWrite(0);
      end
      end
    end else if (^SIA_int === 1'bx) begin
    end else if  (cont_flag0_int === 1'bx && COLLDISN_int === 1'b1 &&  (CENA_int !== 1'b1 && ((TENB_ ? CENB_ : TCENB_) !== 1'b1) && DFTRAMBYP_ !== 1'b1) 
     && row_contention(TENB_ ? AB_ : TAB_, AA_int, WENA_int, TENB_ ? WENB_ : TWENB_)) begin
      cont_flag0_int = 1'b0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QB_int = {16{1'bx}};
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QA_int = {16{1'bx}};
		end
        end else begin
          readWriteB;
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteB;
          readWriteA;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
    end else if  ((CENA_int !== 1'b1 && ((TENB_ ? CENB_ : TCENB_) !== 1'b1) && DFTRAMBYP_ !== 1'b1) && cont_flag0_int === 1'bx && (COLLDISN_int === 1'b0 
     || COLLDISN_int === 1'bx) && row_contention(TENB_ ? AB_ : TAB_, AA_int, WENA_int, TENB_ ? WENB_ : TWENB_)) begin
      cont_flag0_int = 1'b0;
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
          QB_int = {16{1'bx}};
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE_1 = 1;
          READ_READ_1 = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          QA_int = {16{1'bx}};
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
    end else begin
      #0;
      readWriteA;
   end
    globalNotifier0 = 1'b0;
  end

  task readWriteB;
  begin
    if (WENB_int !== 1'b1 && DFTRAMBYP_int=== 1'b0 && SEB_int === 1'bx) begin
      failedWrite(1);
    end else if (DFTRAMBYP_int=== 1'b0 && SEB_int === 1'b1) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (RET1N_int === 1'bx || RET1N_int === 1'bz) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (RET1N_int === 1'b0 && (CENB_int === 1'b0 || DFTRAMBYP_int === 1'b1)) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (RET1N_int === 1'b0) begin
      // no cycle in retention mode
    end else if (^{(EMAB_int & isBit1(DFTRAMBYP_int)), (EMAWB_int & isBit1(DFTRAMBYP_int))} === 1'bx) begin
        QB_int = {16{1'bx}};
    end else if (^{(CENB_int & !isBit1(DFTRAMBYP_int)), EMAB_int, EMAWB_int, RET1N_int} === 1'bx) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if ((AB_int >= WORDS) && (CENB_int === 1'b0) && DFTRAMBYP_int === 1'b0) begin
      QB_int = WENB_int !== 1'b1 ? QB_int : {16{1'bx}};
    end else if (CENB_int === 1'b0 && (^AB_int) === 1'bx && DFTRAMBYP_int === 1'b0) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (CENB_int === 1'b0 || DFTRAMBYP_int === 1'b1) begin
      if(isBitX(DFTRAMBYP_int) || isBitX(SEB_int))
        DB_int = {16{1'bx}};

      mux_address = (AB_int & 3'b111);
      row_address = (AB_int >> 3);
      if (DFTRAMBYP_int !== 1'b1) begin
      if (row_address > 99)
        row = {128{1'bx}};
      else
        row = mem[row_address];
      end
      if(isBitX(DFTRAMBYP_int) || (isBitX(WENB_int) && DFTRAMBYP_int!==1)) begin
        writeEnable = {16{1'bx}};
        DB_int = {16{1'bx}};
      end else
          writeEnable = ~ {16{WENB_int}};
      if (WENB_int !== 1'b1 || DFTRAMBYP_int === 1'b1 || DFTRAMBYP_int === 1'bx) begin
        row_mask =  ( {7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14], 7'b0000000, writeEnable[13],
          7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11], 7'b0000000, writeEnable[10],
          7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8], 7'b0000000, writeEnable[7],
          7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5], 7'b0000000, writeEnable[4],
          7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2], 7'b0000000, writeEnable[1],
          7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, DB_int[15], 7'b0000000, DB_int[14], 7'b0000000, DB_int[13],
          7'b0000000, DB_int[12], 7'b0000000, DB_int[11], 7'b0000000, DB_int[10], 7'b0000000, DB_int[9],
          7'b0000000, DB_int[8], 7'b0000000, DB_int[7], 7'b0000000, DB_int[6], 7'b0000000, DB_int[5],
          7'b0000000, DB_int[4], 7'b0000000, DB_int[3], 7'b0000000, DB_int[2], 7'b0000000, DB_int[1],
          7'b0000000, DB_int[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        if (DFTRAMBYP_int === 1'b1 && SEB_int === 1'b0) begin
        end else if (WENB_int !== 1'b1 && DFTRAMBYP_int === 1'b1 && SEB_int === 1'bx) begin
             QB_int = {16{1'bx}};
        end else begin
        mem[row_address] = row;
        end
      end else begin
        data_out = (row >> (mux_address%4));
        readLatch1 = {data_out[124], data_out[120], data_out[116], data_out[112], data_out[108],
          data_out[104], data_out[100], data_out[96], data_out[92], data_out[88], data_out[84],
          data_out[80], data_out[76], data_out[72], data_out[68], data_out[64], data_out[60],
          data_out[56], data_out[52], data_out[48], data_out[44], data_out[40], data_out[36],
          data_out[32], data_out[28], data_out[24], data_out[20], data_out[16], data_out[12],
          data_out[8], data_out[4], data_out[0]};
        shifted_readLatch1 = (readLatch1 >> AB_int[2]);
        QB_int = {shifted_readLatch1[30], shifted_readLatch1[28], shifted_readLatch1[26],
          shifted_readLatch1[24], shifted_readLatch1[22], shifted_readLatch1[20], shifted_readLatch1[18],
          shifted_readLatch1[16], shifted_readLatch1[14], shifted_readLatch1[12], shifted_readLatch1[10],
          shifted_readLatch1[8], shifted_readLatch1[6], shifted_readLatch1[4], shifted_readLatch1[2],
          shifted_readLatch1[0]};
      end
      if (DFTRAMBYP_int === 1'b1) begin
        QB_int = DB_int;
      end
      if( isBitX(WENB_int) && DFTRAMBYP_int !== 1'b1) begin
        QB_int = {16{1'bx}};
      end
      if( isBitX(DFTRAMBYP_int) )
        QB_int = {16{1'bx}};
    end
  end
  endtask
  always @ (CENB_ or TCENB_ or TENB_ or DFTRAMBYP_ or CLKB_) begin
  	if(CLKB_ == 1'b0) begin
  		CENB_p2 = CENB_;
  		TCENB_p2 = TCENB_;
  		DFTRAMBYP_p2 = DFTRAMBYP_;
  	end
  end

`ifdef POWER_PINS
  always @ (RET1N_ or VDDPE or VDDCE) begin
`else     
  always @ RET1N_ begin
`endif
`ifdef POWER_PINS
    if (RET1N_ == 1'b1 && RET1N_int == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 && pre_charge_st_b == 1'b1 && (CENB_ === 1'bx || TCENB_ === 1'bx || DFTRAMBYP_ === 1'bx || CLKB_ === 1'bx)) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end
`else     
`endif
`ifdef POWER_PINS
`else     
      pre_charge_st_b = 0;
      pre_charge_st = 0;
`endif
    if (RET1N_ === 1'bx || RET1N_ === 1'bz) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (RET1N_ === 1'b0 && RET1N_int === 1'b1 && (CENB_p2 === 1'b0 || TCENB_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (RET1N_ === 1'b1 && RET1N_int === 1'b0 && (CENB_p2 === 1'b0 || TCENB_p2 === 1'b0 || DFTRAMBYP_p2 === 1'b1)) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end
`ifdef POWER_PINS
    if (RET1N_ == 1'b0 && VDDCE == 1'b1 && VDDPE == 1'b1) begin
      pre_charge_st_b = 1;
      pre_charge_st = 1;
    end else if (RET1N_ == 1'b0 && VDDPE == 1'b0) begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
      if (VDDCE != 1'b1) begin
        failedWrite(1);
      end
`else     
    if (RET1N_ == 1'b0) begin
`endif
      QB_int = {16{1'bx}};
      CENB_int = 1'bx;
      WENB_int = 1'bx;
      AB_int = {10{1'bx}};
      DB_int = {16{1'bx}};
      EMAB_int = {3{1'bx}};
      EMAWB_int = {2{1'bx}};
      TENB_int = 1'bx;
      TCENB_int = 1'bx;
      TWENB_int = 1'bx;
      TAB_int = {10{1'bx}};
      TDB_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SIB_int = {2{1'bx}};
      SEB_int = 1'bx;
      COLLDISN_int = 1'bx;
`ifdef POWER_PINS
    end else if (RET1N_ == 1'b1 && VDDCE == 1'b1 && VDDPE == 1'b1 &&  pre_charge_st_b == 1'b1) begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
    end else begin
      pre_charge_st_b = 0;
      pre_charge_st = 0;
`else     
    end else begin
`endif
        QB_int = {16{1'bx}};
      CENB_int = 1'bx;
      WENB_int = 1'bx;
      AB_int = {10{1'bx}};
      DB_int = {16{1'bx}};
      EMAB_int = {3{1'bx}};
      EMAWB_int = {2{1'bx}};
      TENB_int = 1'bx;
      TCENB_int = 1'bx;
      TWENB_int = 1'bx;
      TAB_int = {10{1'bx}};
      TDB_int = {16{1'bx}};
      RET1N_int = 1'bx;
      SIB_int = {2{1'bx}};
      SEB_int = 1'bx;
      COLLDISN_int = 1'bx;
    end
    RET1N_int = RET1N_;
  end

  always @ (SIB_int) begin
  	#0;
      if (DFTRAMBYP_=== 1'b1 && SEB_ === 1'b1 && ^SIB_int === 1'bx) begin
	QB_int[15] = SIB_int[1]; 
	QB_int[0] = SIB_int[0]; 
  	end
  end

  always @ CLKB_ begin
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
`endif
`ifdef POWER_PINS
  if (RET1N_ == 1'b0) begin
`else     
  if (RET1N_ == 1'b0) begin
`endif
      // no cycle in retention mode
  end else begin
    if ((CLKB_ === 1'bx || CLKB_ === 1'bz) && RET1N_ !== 1'b0) begin
      failedWrite(1);
        QB_int = {16{1'bx}};
    end else if (CLKB_ === 1'b1 && LAST_CLKB === 1'b0) begin
      DFTRAMBYP_int = DFTRAMBYP_;
      SIB_int = SIB_;
      SEB_int = SEB_;
      CENB_int = TENB_ ? CENB_ : TCENB_;
      EMAB_int = EMAB_;
      EMAWB_int = EMAWB_;
      TENB_int = TENB_;
      TWENB_int = TWENB_;
      RET1N_int = RET1N_;
      SIB_int = SIB_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENB_int != 1'b1) begin
        WENB_int = TENB_ ? WENB_ : TWENB_;
        AB_int = TENB_ ? AB_ : TAB_;
        DB_int = TENB_ ? DB_ : TDB_;
        TCENB_int = TCENB_;
        TAB_int = TAB_;
        TDB_int = TDB_;
        if (WENB_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
          read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
        end
      end
      clk1_int = 1'b0;
      if (DFTRAMBYP_=== 1'b1 && SEB_ === 1'b1) begin
         read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
         read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
	QB_int[15:8] = {SIB_[1], QB_int[15:9]}; 
	QB_int[7:0] = {QB_int[6:0], SIB_[0]}; 
      end else begin
      CENB_int = TENB_ ? CENB_ : TCENB_;
      EMAB_int = EMAB_;
      EMAWB_int = EMAWB_;
      TENB_int = TENB_;
      TWENB_int = TWENB_;
      RET1N_int = RET1N_;
      SIB_int = SIB_;
      COLLDISN_int = COLLDISN_;
      if (DFTRAMBYP_=== 1'b1 || CENB_int != 1'b1) begin
        WENB_int = TENB_ ? WENB_ : TWENB_;
        AB_int = TENB_ ? AB_ : TAB_;
        DB_int = TENB_ ? DB_ : TDB_;
        TCENB_int = TCENB_;
        TAB_int = TAB_;
        TDB_int = TDB_;
        if (WENB_int === 1'b1 || DFTRAMBYP_ == 1'b1) begin
          read_mux_sel1 = (TENB_ ? AB_[2] : TAB_[2] );
          read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
        end
      end
      clk1_int = 1'b0;
      if (CENB_int === 1'b0) previous_CLKB = $realtime;
    readWriteB;
      end
    #0;
      if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && COLLDISN_int === 1'b1 && row_contention(AA_int,
        AB_int, WENA_int, WENB_int)) begin
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QB_int = {16{1'bx}};
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QA_int = {16{1'bx}};
		end
        end else begin
          readWriteA;
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteA;
          readWriteB;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
      end else if (((previous_CLKA == previous_CLKB)) && (CENA_int !== 1'b1 && CENB_int !== 1'b1 && DFTRAMBYP_ !== 1'b1) && (COLLDISN_int === 1'b0 || COLLDISN_int 
       === 1'bx)  && row_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
          QA_int = {16{1'bx}};
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_READ_1 = 1;
          READ_WRITE_1 = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          QB_int = {16{1'bx}};
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
      end
    end else if (CLKB_ === 1'b0 && LAST_CLKB === 1'b1) begin
         read_mux_sel1_p2 = ((^read_mux_sel1 === 1'bx) && DFTRAMBYP_p2) ? {1{1'b0}} : read_mux_sel1;
    end
  end
    LAST_CLKB = CLKB_;
  end

  reg globalNotifier1;
  initial globalNotifier1 = 1'b0;

  always @ globalNotifier1 begin
    if ($realtime == 0) begin
    end else if ((EMAB_int[0] === 1'bx & DFTRAMBYP_int === 1'b1) || (EMAB_int[1] === 1'bx & DFTRAMBYP_int === 1'b1) || 
      (EMAB_int[2] === 1'bx & DFTRAMBYP_int === 1'b1) || (EMAWB_int[0] === 1'bx & DFTRAMBYP_int === 1'b1) || 
      (EMAWB_int[1] === 1'bx & DFTRAMBYP_int === 1'b1)) begin
        QB_int = {16{1'bx}};
    end else if ((CENB_int === 1'bx & DFTRAMBYP_int === 1'b0) || EMAB_int[0] === 1'bx || 
      EMAB_int[1] === 1'bx || EMAB_int[2] === 1'bx || EMAWB_int[0] === 1'bx || EMAWB_int[1] === 1'bx || 
      RET1N_int === 1'bx || clk1_int === 1'bx) begin
        QB_int = {16{1'bx}};
      failedWrite(1);
    end else if (TENB_int === 1'bx) begin
      if(((CENB_ === 1'b1 & TCENB_ === 1'b1) & DFTRAMBYP_int === 1'b0) | (DFTRAMBYP_int === 1'b1 & SEB_int === 1'b1)) begin
      end else begin
        QB_int = {16{1'bx}};
      if (DFTRAMBYP_int === 1'b0) begin
          failedWrite(1);
      end
      end
    end else if (^SIB_int === 1'bx) begin
    end else if  (cont_flag1_int === 1'bx && COLLDISN_int === 1'b1 &&  (CENB_int !== 1'b1 && ((TENA_ ? CENA_ : TCENA_) !== 1'b1) && DFTRAMBYP_ !== 1'b1) 
     && row_contention(TENA_ ? AA_ : TAA_, AB_int, WENB_int, TENA_ ? WENA_ : TWENA_)) begin
      cont_flag1_int = 1'b0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
	      if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: both writes fail in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          WRITE_WRITE = 1;
          DA_int = {16{1'bx}};
          readWriteA;
          DB_int = {16{1'bx}};
          readWriteB;
	      end
        end else if (WENA_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write A succeeds, read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QB_int = {16{1'bx}};
		end
        end else if (WENB_int !== 1'b1) begin
		if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: write B succeeds, read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE = 1;
          QA_int = {16{1'bx}};
		end
        end else begin
          readWriteA;
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: both reads succeed in %m at %0t",ASSERT_PREFIX, $time);
`endif
          COL_CC = 1;
          READ_READ = 1;
        end
        if (!is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          readWriteA;
          readWriteB;
        if (WENA_int !== 1'b1 && WENB_int !== 1'b1) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          WRITE_WRITE = 1;
        end else if (!(WENA_int !== 1'b1) && (WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: write B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else if ((WENA_int !== 1'b1) && !(WENB_int !== 1'b1)) begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, write A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_WRITE = 1;
        end else begin
`ifdef ARM_MESSAGES
          $display("%s row contention: read B succeeds, read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
        end
        end
    end else if  ((CENB_int !== 1'b1 && ((TENA_ ? CENA_ : TCENA_) !== 1'b1) && DFTRAMBYP_ !== 1'b1) && cont_flag1_int === 1'bx && (COLLDISN_int === 1'b0 
     || COLLDISN_int === 1'bx) && row_contention(TENA_ ? AA_ : TAA_, AB_int, WENB_int, TENA_ ? WENA_ : TWENA_)) begin
      cont_flag1_int = 1'b0;
          ROW_CC = 1;
          READ_READ_1 = 0;
          READ_WRITE_1 = 0;
          WRITE_WRITE_1 = 0;
        if (col_contention(AA_int, AB_int)) begin
          COL_CC = 1;
        end
        if (WENA_int !== 1'b1) begin
          $display("%s contention: write A fails in %m at %0t",ASSERT_PREFIX, $time);
          WRITE_WRITE_1 = 1;
          DA_int = {16{1'bx}};
          readWriteA;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read A fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          READ_WRITE_1 = 1;
          QA_int = {16{1'bx}};
        end else begin
          readWriteA;
`ifdef ARM_MESSAGES
          $display("%s contention: read A succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          READ_READ_1 = 1;
          READ_WRITE_1 = 1;
        end
        if (WENB_int !== 1'b1) begin
          $display("%s contention: write B fails in %m at %0t",ASSERT_PREFIX, $time);
          if(WRITE_WRITE_1)
            WRITE_WRITE = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          DB_int = {16{1'bx}};
          readWriteB;
        end else if (is_contention(AA_int, AB_int, WENA_int, WENB_int)) begin
          $display("%s contention: read B fails in %m at %0t",ASSERT_PREFIX, $time);
          COL_CC = 1;
          if(READ_WRITE_1) begin
            READ_WRITE = 1;
            READ_WRITE_1 = 0;
          end
          QB_int = {16{1'bx}};
        end else begin
          readWriteB;
`ifdef ARM_MESSAGES
          $display("%s contention: read B succeeds in %m at %0t",ASSERT_PREFIX, $time);
`endif
          if(READ_READ_1) begin
            READ_READ = 1;
            READ_READ_1 = 0;
          end
        end
    end else begin
      #0;
      readWriteB;
   end
    globalNotifier1 = 1'b0;
  end
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
 always @ (VDDCE or VDDPE or VSSE) begin
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("Warning: Unknown value for VDDCE %b in %m at %0t", VDDCE, $time);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("Warning: Unknown value for VDDPE %b in %m at %0t", VDDPE, $time);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("Warning: Unknown value for VSSE %b in %m at %0t", VSSE, $time);
 end
`endif

  function row_contention;
    input [9:0] aa;
    input [9:0] ab;
    input  wena;
    input  wenb;
    reg result;
    reg sameRow;
    reg sameMux;
    reg anyWrite;
  begin
    anyWrite = ((& wena) === 1'b1 && (& wenb) === 1'b1) ? 1'b0 : 1'b1;
    sameMux = (aa[2:0] == ab[2:0]) ? 1'b1 : 1'b0;
    if (aa[9:3] == ab[9:3]) begin
      sameRow = 1'b1;
    end else begin
      sameRow = 1'b0;
    end
    if (sameRow == 1'b1 && anyWrite == 1'b1)
      row_contention = 1'b1;
    else if (sameRow == 1'b1 && sameMux == 1'b1)
      row_contention = 1'b1;
    else
      row_contention = 1'b0;
  end
  endfunction

  function col_contention;
    input [9:0] aa;
    input [9:0] ab;
  begin
    if (aa[2:0] == ab[2:0])
      col_contention = 1'b1;
    else
      col_contention = 1'b0;
  end
  endfunction

  function is_contention;
    input [9:0] aa;
    input [9:0] ab;
    input  wena;
    input  wenb;
    reg result;
  begin
    if ((& wena) === 1'b1 && (& wenb) === 1'b1) begin
      result = 1'b0;
    end else if (aa == ab) begin
      result = 1'b1;
    end else begin
      result = 1'b0;
    end
    is_contention = result;
  end
  endfunction

   wire contA_flag = (CENA_int !== 1'b1 && ((TENB_ ? CENB_ : TCENB_) !== 1'b1)) && ((COLLDISN_int === 1'b1 && is_contention(TENB_ ? AB_ : TAB_, AA_int, TENB_ ? WENB_ : TWENB_, WENA_int)) ||
              ((COLLDISN_int === 1'b0 || COLLDISN_int === 1'bx) && row_contention(TENB_ ? AB_ : TAB_, AA_int, TENB_ ? WENB_ : TWENB_, WENA_int)));
   wire contB_flag = (CENB_int !== 1'b1 && ((TENA_ ? CENA_ : TCENA_) !== 1'b1)) && ((COLLDISN_int === 1'b1 && is_contention(TENA_ ? AA_ : TAA_, AB_int, TENA_ ? WENA_ : TWENA_, WENB_int)) ||
              ((COLLDISN_int === 1'b0 || COLLDISN_int === 1'bx) && row_contention(TENA_ ? AA_ : TAA_, AB_int, TENA_ ? WENA_ : TWENA_, WENB_int)));

  always @ NOT_CENA begin
    CENA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_WENA begin
    WENA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA9 begin
    AA_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA8 begin
    AA_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA7 begin
    AA_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA6 begin
    AA_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA5 begin
    AA_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA4 begin
    AA_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA3 begin
    AA_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA2 begin
    AA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA1 begin
    AA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_AA0 begin
    AA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA15 begin
    DA_int[15] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA14 begin
    DA_int[14] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA13 begin
    DA_int[13] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA12 begin
    DA_int[12] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA11 begin
    DA_int[11] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA10 begin
    DA_int[10] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA9 begin
    DA_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA8 begin
    DA_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA7 begin
    DA_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA6 begin
    DA_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA5 begin
    DA_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA4 begin
    DA_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA3 begin
    DA_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA2 begin
    DA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA1 begin
    DA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DA0 begin
    DA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CENB begin
    CENB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_WENB begin
    WENB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB9 begin
    AB_int[9] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB8 begin
    AB_int[8] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB7 begin
    AB_int[7] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB6 begin
    AB_int[6] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB5 begin
    AB_int[5] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB4 begin
    AB_int[4] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB3 begin
    AB_int[3] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB2 begin
    AB_int[2] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB1 begin
    AB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_AB0 begin
    AB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB15 begin
    DB_int[15] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB14 begin
    DB_int[14] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB13 begin
    DB_int[13] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB12 begin
    DB_int[12] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB11 begin
    DB_int[11] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB10 begin
    DB_int[10] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB9 begin
    DB_int[9] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB8 begin
    DB_int[8] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB7 begin
    DB_int[7] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB6 begin
    DB_int[6] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB5 begin
    DB_int[5] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB4 begin
    DB_int[4] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB3 begin
    DB_int[3] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB2 begin
    DB_int[2] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB1 begin
    DB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_DB0 begin
    DB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_EMAA2 begin
    EMAA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAA1 begin
    EMAA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAA0 begin
    EMAA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAWA1 begin
    EMAWA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAWA0 begin
    EMAWA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAB2 begin
    EMAB_int[2] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_EMAB1 begin
    EMAB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_EMAB0 begin
    EMAB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_EMAWB1 begin
    EMAWB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_EMAWB0 begin
    EMAWB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TENA begin
    TENA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TCENA begin
    CENA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TWENA begin
    WENA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA9 begin
    AA_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA8 begin
    AA_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA7 begin
    AA_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA6 begin
    AA_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA5 begin
    AA_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA4 begin
    AA_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA3 begin
    AA_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA2 begin
    AA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA1 begin
    AA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TAA0 begin
    AA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA15 begin
    DA_int[15] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA14 begin
    DA_int[14] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA13 begin
    DA_int[13] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA12 begin
    DA_int[12] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA11 begin
    DA_int[11] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA10 begin
    DA_int[10] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA9 begin
    DA_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA8 begin
    DA_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA7 begin
    DA_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA6 begin
    DA_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA5 begin
    DA_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA4 begin
    DA_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA3 begin
    DA_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA2 begin
    DA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA1 begin
    DA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TDA0 begin
    DA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TENB begin
    TENB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TCENB begin
    CENB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TWENB begin
    WENB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB9 begin
    AB_int[9] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB8 begin
    AB_int[8] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB7 begin
    AB_int[7] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB6 begin
    AB_int[6] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB5 begin
    AB_int[5] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB4 begin
    AB_int[4] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB3 begin
    AB_int[3] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB2 begin
    AB_int[2] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB1 begin
    AB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TAB0 begin
    AB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB15 begin
    DB_int[15] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB14 begin
    DB_int[14] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB13 begin
    DB_int[13] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB12 begin
    DB_int[12] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB11 begin
    DB_int[11] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB10 begin
    DB_int[10] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB9 begin
    DB_int[9] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB8 begin
    DB_int[8] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB7 begin
    DB_int[7] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB6 begin
    DB_int[6] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB5 begin
    DB_int[5] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB4 begin
    DB_int[4] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB3 begin
    DB_int[3] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB2 begin
    DB_int[2] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB1 begin
    DB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_TDB0 begin
    DB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_SIA1 begin
    SIA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_SIA0 begin
    SIA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_SEA begin
    SEA_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DFTRAMBYP_CLKA begin
    DFTRAMBYP_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_DFTRAMBYP_CLKB begin
    DFTRAMBYP_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_RET1N begin
    RET1N_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_SIB1 begin
    SIB_int[1] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_SIB0 begin
    SIB_int[0] = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_SEB begin
    SEB_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_COLLDISN begin
    COLLDISN_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end

  always @ NOT_CONTA begin
    cont_flag0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CLKA_PER begin
    clk0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CLKA_MINH begin
    clk0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CLKA_MINL begin
    clk0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CONTB begin
    cont_flag1_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_CLKB_PER begin
    clk1_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_CLKB_MINH begin
    clk1_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end
  always @ NOT_CLKB_MINL begin
    clk1_int = 1'bx;
    if ( globalNotifier1 === 1'b0 ) globalNotifier1 = 1'bx;
  end


  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;
  wire RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1;

  wire RET1Neq1aTENAeq1, RET1Neq1aTENAeq1aCENAeq0, RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0;
  wire RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0;
  wire RET1Neq1aTENBeq1, RET1Neq1aTENBeq1aCENBeq0, RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0;
  wire RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0;
  wire RET1Neq1aTENAeq0, RET1Neq1aTENAeq0aTCENAeq0, RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0;
  wire RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0;
  wire RET1Neq1aTENBeq0, RET1Neq1aTENBeq0aTCENBeq0, RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0;
  wire RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0;
  wire RET1Neq1aSEAeq1, RET1Neq1aSEBeq1, RET1Neq1, RET1Neq1aTENAeq1aCENAeq0oTENAeq0aTCENAeq0;
  wire RET1Neq1aTENBeq1aCENBeq0oTENBeq0aTCENBeq0;

  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && !DFTRAMBYP && ((TENA && !CENA && WENA) || (!TENA && !TCENA && TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && !DFTRAMBYP && ((TENA && !CENA && !WENA) || (!TENA && !TCENA && !TWENA)) && contA_flag;
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && !EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && !EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && !EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && !EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAA[2] && EMAA[1] && EMAA[0] && EMAWA[1] && EMAWA[0] && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0 = 
  RET1N && TENA && ((DFTRAMBYP && !SEA) || (!DFTRAMBYP && !CENA && !WENA));
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && !DFTRAMBYP && ((TENB && !CENB && WENB) || (!TENB && !TCENB && TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && !DFTRAMBYP && ((TENB && !CENB && !WENB) || (!TENB && !TCENB && !TWENB)) && contB_flag;
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && !EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && !EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && !EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && !EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && !EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && EMAB[2] && EMAB[1] && EMAB[0] && EMAWB[1] && EMAWB[0] && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0 = 
  RET1N && TENB && ((DFTRAMBYP && !SEB) || (!DFTRAMBYP && !CENB && !WENB));
  assign RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && (((TENA && !CENA && !DFTRAMBYP) || (!TENA && !TCENA && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1 = 
  RET1N && (((TENB && !CENB && !DFTRAMBYP) || (!TENB && !TCENB && !DFTRAMBYP)) || DFTRAMBYP);
  assign RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0 = 
  RET1N && !TENA && ((DFTRAMBYP && !SEA) || (!DFTRAMBYP && !TCENA && !TWENA));
  assign RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0 = 
  RET1N && !TENB && ((DFTRAMBYP && !SEB) || (!DFTRAMBYP && !TCENB && !TWENB));

  assign RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0 = RET1N && TENA && !CENA && !COLLDISN;
  assign RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1 = RET1N && TENA && !CENA && COLLDISN;
  assign RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0 = RET1N && TENB && !CENB && !COLLDISN;
  assign RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1 = RET1N && TENB && !CENB && COLLDISN;
  assign RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0 = RET1N && !TENA && !TCENA && !COLLDISN;
  assign RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1 = RET1N && !TENA && !TCENA && COLLDISN;
  assign RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0 = RET1N && !TENB && !TCENB && !COLLDISN;
  assign RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1 = RET1N && !TENB && !TCENB && COLLDISN;
  assign RET1Neq1aTENAeq1aCENAeq0oTENAeq0aTCENAeq0 = RET1N && ((TENA && !CENA) || (!TENA && !TCENA));
  assign RET1Neq1aTENBeq1aCENBeq0oTENBeq0aTCENBeq0 = RET1N && ((TENB && !CENB) || (!TENB && !TCENB));

  assign RET1Neq1aTENAeq1aCENAeq0 = RET1N && TENA && !CENA;
  assign RET1Neq1aTENBeq1aCENBeq0 = RET1N && TENB && !CENB;
  assign RET1Neq1aTENAeq0aTCENAeq0 = RET1N && !TENA && !TCENA;
  assign RET1Neq1aTENBeq0aTCENBeq0 = RET1N && !TENB && !TCENB;

  assign RET1Neq1aTENAeq1 = RET1N && TENA;
  assign RET1Neq1aTENBeq1 = RET1N && TENB;
  assign RET1Neq1aTENAeq0 = RET1N && !TENA;
  assign RET1Neq1aTENBeq0 = RET1N && !TENB;
  assign RET1Neq1aSEAeq1 = RET1N && SEA;
  assign RET1Neq1aSEBeq1 = RET1N && SEB;
  assign RET1Neq1 = RET1N;

  specify

    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (CENA +=> CENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TCENA +=> CENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && CENA == 1'b0 && TCENA == 1'b1)
       (TENA -=> CENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && CENA == 1'b1 && TCENA == 1'b0)
       (TENA +=> CENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> CENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && WENA == 1'b0 && TWENA == 1'b1)
       (TENA -=> WENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && WENA == 1'b1 && TWENA == 1'b0)
       (TENA +=> WENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (WENA +=> WENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TWENA +=> WENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> WENYA) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[9] == 1'b0 && TAA[9] == 1'b1)
       (TENA -=> AYA[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[9] == 1'b1 && TAA[9] == 1'b0)
       (TENA +=> AYA[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[8] == 1'b0 && TAA[8] == 1'b1)
       (TENA -=> AYA[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[8] == 1'b1 && TAA[8] == 1'b0)
       (TENA +=> AYA[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[7] == 1'b0 && TAA[7] == 1'b1)
       (TENA -=> AYA[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[7] == 1'b1 && TAA[7] == 1'b0)
       (TENA +=> AYA[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[6] == 1'b0 && TAA[6] == 1'b1)
       (TENA -=> AYA[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[6] == 1'b1 && TAA[6] == 1'b0)
       (TENA +=> AYA[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[5] == 1'b0 && TAA[5] == 1'b1)
       (TENA -=> AYA[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[5] == 1'b1 && TAA[5] == 1'b0)
       (TENA +=> AYA[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[4] == 1'b0 && TAA[4] == 1'b1)
       (TENA -=> AYA[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[4] == 1'b1 && TAA[4] == 1'b0)
       (TENA +=> AYA[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[3] == 1'b0 && TAA[3] == 1'b1)
       (TENA -=> AYA[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[3] == 1'b1 && TAA[3] == 1'b0)
       (TENA +=> AYA[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[2] == 1'b0 && TAA[2] == 1'b1)
       (TENA -=> AYA[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[2] == 1'b1 && TAA[2] == 1'b0)
       (TENA +=> AYA[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[1] == 1'b0 && TAA[1] == 1'b1)
       (TENA -=> AYA[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[1] == 1'b1 && TAA[1] == 1'b0)
       (TENA +=> AYA[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[0] == 1'b0 && TAA[0] == 1'b1)
       (TENA -=> AYA[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AA[0] == 1'b1 && TAA[0] == 1'b0)
       (TENA +=> AYA[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[9] +=> AYA[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[8] +=> AYA[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[7] +=> AYA[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[6] +=> AYA[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[5] +=> AYA[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[4] +=> AYA[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[3] +=> AYA[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[2] +=> AYA[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[1] +=> AYA[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b1)
       (AA[0] +=> AYA[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[9] +=> AYA[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[8] +=> AYA[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[7] +=> AYA[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[6] +=> AYA[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[5] +=> AYA[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[4] +=> AYA[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[3] +=> AYA[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[2] +=> AYA[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[1] +=> AYA[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENA == 1'b0)
       (TAA[0] +=> AYA[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYA[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (CENB +=> CENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TCENB +=> CENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && CENB == 1'b0 && TCENB == 1'b1)
       (TENB -=> CENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && CENB == 1'b1 && TCENB == 1'b0)
       (TENB +=> CENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> CENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && WENB == 1'b0 && TWENB == 1'b1)
       (TENB -=> WENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && WENB == 1'b1 && TWENB == 1'b0)
       (TENB +=> WENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (WENB +=> WENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TWENB +=> WENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> WENYB) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[9] == 1'b0 && TAB[9] == 1'b1)
       (TENB -=> AYB[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[9] == 1'b1 && TAB[9] == 1'b0)
       (TENB +=> AYB[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[8] == 1'b0 && TAB[8] == 1'b1)
       (TENB -=> AYB[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[8] == 1'b1 && TAB[8] == 1'b0)
       (TENB +=> AYB[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[7] == 1'b0 && TAB[7] == 1'b1)
       (TENB -=> AYB[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[7] == 1'b1 && TAB[7] == 1'b0)
       (TENB +=> AYB[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[6] == 1'b0 && TAB[6] == 1'b1)
       (TENB -=> AYB[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[6] == 1'b1 && TAB[6] == 1'b0)
       (TENB +=> AYB[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[5] == 1'b0 && TAB[5] == 1'b1)
       (TENB -=> AYB[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[5] == 1'b1 && TAB[5] == 1'b0)
       (TENB +=> AYB[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[4] == 1'b0 && TAB[4] == 1'b1)
       (TENB -=> AYB[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[4] == 1'b1 && TAB[4] == 1'b0)
       (TENB +=> AYB[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[3] == 1'b0 && TAB[3] == 1'b1)
       (TENB -=> AYB[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[3] == 1'b1 && TAB[3] == 1'b0)
       (TENB +=> AYB[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[2] == 1'b0 && TAB[2] == 1'b1)
       (TENB -=> AYB[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[2] == 1'b1 && TAB[2] == 1'b0)
       (TENB +=> AYB[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[1] == 1'b0 && TAB[1] == 1'b1)
       (TENB -=> AYB[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[1] == 1'b1 && TAB[1] == 1'b0)
       (TENB +=> AYB[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[0] == 1'b0 && TAB[0] == 1'b1)
       (TENB -=> AYB[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && AB[0] == 1'b1 && TAB[0] == 1'b0)
       (TENB +=> AYB[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[9] +=> AYB[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[8] +=> AYB[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[7] +=> AYB[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[6] +=> AYB[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[5] +=> AYB[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[4] +=> AYB[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[3] +=> AYB[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[2] +=> AYB[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[1] +=> AYB[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b1)
       (AB[0] +=> AYB[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[9] +=> AYB[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[8] +=> AYB[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[7] +=> AYB[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[6] +=> AYB[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[5] +=> AYB[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[4] +=> AYB[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[3] +=> AYB[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[2] +=> AYB[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[1] +=> AYB[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (DFTRAMBYP == 1'b1 && TENB == 1'b0)
       (TAB[0] +=> AYB[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[9]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[8]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[7]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[6]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[5]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[4]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[3]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[2]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[1]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1)
       (DFTRAMBYP +=> AYB[0]) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (QA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[15] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[14] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[13] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[12] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[11] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[10] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[9] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[8] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[7] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[6] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[5] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[4] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[3] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[2] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (QB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b0 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b0 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAA[2] == 1'b1 && EMAA[1] == 1'b1 && EMAA[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENA == 1'b1 && WENA == 1'b1) || (TENA == 1'b0 && TWENA == 1'b1)))
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (SOA[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKA => (SOA[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b0 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b0 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b0 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && EMAB[2] == 1'b1 && EMAB[1] == 1'b1 && EMAB[0] == 1'b1 && DFTRAMBYP == 1'b0 && ((TENB == 1'b1 && WENB == 1'b1) || (TENB == 1'b0 && TWENB == 1'b1)))
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (SOB[1] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);
    if (RET1N == 1'b1 && DFTRAMBYP == 1'b1)
       (posedge CLKB => (SOB[0] : 1'b0)) = (`ARM_MEM_PROP, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP, `ARM_MEM_RETAIN, `ARM_MEM_PROP);


   // Define SDTC only if back-annotating SDF file generated by Design Compiler
   `ifdef NO_SDTC
       $period(posedge CLKA, `ARM_MEM_PERIOD, NOT_CLKA_PER);
   `else
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
       $period(posedge CLKA &&& RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKA_PER);
   `endif

   // Define SDTC only if back-annotating SDF file generated by Design Compiler
   `ifdef NO_SDTC
       $period(posedge CLKB, `ARM_MEM_PERIOD, NOT_CLKB_PER);
   `else
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
       $period(posedge CLKB &&& RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, `ARM_MEM_PERIOD, NOT_CLKB_PER);
   `endif


   // Define SDTC only if back-annotating SDF file generated by Design Compiler
   `ifdef NO_SDTC
       $width(posedge CLKA, `ARM_MEM_WIDTH, 0, NOT_CLKA_MINH);
       $width(negedge CLKA, `ARM_MEM_WIDTH, 0, NOT_CLKA_MINL);
   `else
       $width(posedge CLKA &&& RET1Neq1, `ARM_MEM_WIDTH, 0, NOT_CLKA_MINH);
       $width(negedge CLKA &&& RET1Neq1, `ARM_MEM_WIDTH, 0, NOT_CLKA_MINL);
   `endif

   // Define SDTC only if back-annotating SDF file generated by Design Compiler
   `ifdef NO_SDTC
       $width(posedge CLKB, `ARM_MEM_WIDTH, 0, NOT_CLKB_MINH);
       $width(negedge CLKB, `ARM_MEM_WIDTH, 0, NOT_CLKB_MINL);
   `else
       $width(posedge CLKB &&& RET1Neq1, `ARM_MEM_WIDTH, 0, NOT_CLKB_MINH);
       $width(negedge CLKB &&& RET1Neq1, `ARM_MEM_WIDTH, 0, NOT_CLKB_MINL);
   `endif


    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq1oTENAeq0aTCENAeq0aTWENAeq1, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq0aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq0aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq0aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq0aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq0aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);
    $setuphold(posedge CLKB &&& contA_RET1Neq1aEMAA2eq1aEMAA1eq1aEMAA0eq1aEMAWA1eq1aEMAWA0eq1aDFTRAMBYPeq0aTENAeq1aCENAeq0aWENAeq0oTENAeq0aTCENAeq0aTWENAeq0, posedge CLKA, `ARM_MEM_COLLISION, 0.000, NOT_CONTA);

    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq1oTENBeq0aTCENBeq0aTWENBeq1, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq0aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq0aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq0aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq0aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq0aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);
    $setuphold(posedge CLKA &&& contB_RET1Neq1aEMAB2eq1aEMAB1eq1aEMAB0eq1aEMAWB1eq1aEMAWB0eq1aDFTRAMBYPeq0aTENBeq1aCENBeq0aWENBeq0oTENBeq0aTCENBeq0aTWENBeq0, posedge CLKB, `ARM_MEM_COLLISION, 0.000, NOT_CONTB);

    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1, posedge CENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_CENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1, negedge CENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_CENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0, posedge WENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_WENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0, negedge WENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_WENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, posedge AA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq0, negedge AA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, posedge AA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aCOLLDISNeq1, negedge AA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA15);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA14);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA13);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA12);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA11);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA10);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, posedge DA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA15);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA14);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA13);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA12);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA11);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA10);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aCENAeq0aWENAeq0, negedge DA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DA0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1, posedge CENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_CENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1, negedge CENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_CENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0, posedge WENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_WENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0, negedge WENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_WENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, posedge AB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq0, negedge AB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, posedge AB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aCOLLDISNeq1, negedge AB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_AB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB15);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB14);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB13);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB12);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB11);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB10);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, posedge DB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB15);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB14);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB13);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB12);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB11);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB10);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aCENBeq0aWENBeq0, negedge DB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DB0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAWA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAWA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAWA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0aDFTRAMBYPeq0oTENAeq0aTCENAeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAWA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWA0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAWB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, posedge EMAWB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAWB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0aDFTRAMBYPeq0oTENBeq0aTCENBeq0aDFTRAMBYPeq0oDFTRAMBYPeq1, negedge EMAWB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_EMAWB0);
    $setuphold(posedge CLKA &&& RET1Neq1, posedge TENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TENA);
    $setuphold(posedge CLKA &&& RET1Neq1, negedge TENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0, posedge TCENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TCENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0, negedge TCENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TCENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0, posedge TWENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TWENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0, negedge TWENA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TWENA);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, posedge TAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq0, negedge TAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, posedge TAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aTCENAeq0aCOLLDISNeq1, negedge TAA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA15);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA14);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA13);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA12);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA11);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA10);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, posedge TDA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA0);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA15);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA14);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA13);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA12);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA11);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA10);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA9);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA8);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA7);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA6);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA5);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA4);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA3);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA2);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA1);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq0aDFTRAMBYPeq1aSEAeq0oDFTRAMBYPeq0aTCENAeq0aTWENAeq0, negedge TDA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDA0);
    $setuphold(posedge CLKB &&& RET1Neq1, posedge TENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TENB);
    $setuphold(posedge CLKB &&& RET1Neq1, negedge TENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0, posedge TCENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TCENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0, negedge TCENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TCENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0, posedge TWENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TWENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0, negedge TWENB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TWENB);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, posedge TAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq0, negedge TAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, posedge TAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aTCENBeq0aCOLLDISNeq1, negedge TAB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TAB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB15);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB14);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB13);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB12);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB11);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB10);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, posedge TDB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB0);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[15], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB15);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[14], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB14);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[13], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB13);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[12], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB12);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[11], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB11);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[10], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB10);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[9], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB9);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[8], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB8);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[7], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB7);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[6], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB6);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[5], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB5);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[4], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB4);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[3], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB3);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[2], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB2);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB1);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq0aDFTRAMBYPeq1aSEBeq0oDFTRAMBYPeq0aTCENBeq0aTWENBeq0, negedge TDB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_TDB0);
    $setuphold(posedge CLKA, posedge RET1N, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CLKA, negedge RET1N, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CLKB, posedge RET1N, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CLKB, negedge RET1N, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CLKA &&& RET1Neq1aSEAeq1, posedge SIA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIA1);
    $setuphold(posedge CLKA &&& RET1Neq1aSEAeq1, posedge SIA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIA0);
    $setuphold(posedge CLKA &&& RET1Neq1aSEAeq1, negedge SIA[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIA1);
    $setuphold(posedge CLKA &&& RET1Neq1aSEAeq1, negedge SIA[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIA0);
    $setuphold(posedge CLKA &&& RET1Neq1, posedge SEA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SEA);
    $setuphold(posedge CLKA &&& RET1Neq1, negedge SEA, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SEA);
    $setuphold(posedge CLKA &&& RET1Neq1, posedge DFTRAMBYP, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DFTRAMBYP_CLKA);
    $setuphold(posedge CLKA &&& RET1Neq1, negedge DFTRAMBYP, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DFTRAMBYP_CLKA);
    $setuphold(posedge CLKB &&& RET1Neq1, posedge DFTRAMBYP, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DFTRAMBYP_CLKB);
    $setuphold(posedge CLKB &&& RET1Neq1, negedge DFTRAMBYP, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_DFTRAMBYP_CLKB);
    $setuphold(posedge CLKB &&& RET1Neq1aSEBeq1, posedge SIB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIB1);
    $setuphold(posedge CLKB &&& RET1Neq1aSEBeq1, posedge SIB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIB0);
    $setuphold(posedge CLKB &&& RET1Neq1aSEBeq1, negedge SIB[1], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIB1);
    $setuphold(posedge CLKB &&& RET1Neq1aSEBeq1, negedge SIB[0], `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SIB0);
    $setuphold(posedge CLKB &&& RET1Neq1, posedge SEB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SEB);
    $setuphold(posedge CLKB &&& RET1Neq1, negedge SEB, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_SEB);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0oTENAeq0aTCENAeq0, posedge COLLDISN, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_COLLDISN);
    $setuphold(posedge CLKA &&& RET1Neq1aTENAeq1aCENAeq0oTENAeq0aTCENAeq0, negedge COLLDISN, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_COLLDISN);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0oTENBeq0aTCENBeq0, posedge COLLDISN, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_COLLDISN);
    $setuphold(posedge CLKB &&& RET1Neq1aTENBeq1aCENBeq0oTENBeq0aTCENBeq0, negedge COLLDISN, `ARM_MEM_SETUP, `ARM_MEM_HOLD, NOT_COLLDISN);
    $setuphold(negedge RET1N, negedge CENA, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge RET1N, negedge CENA, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge RET1N, negedge CENB, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge RET1N, negedge CENB, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge RET1N, negedge TCENA, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge RET1N, negedge TCENA, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge RET1N, negedge TCENB, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge RET1N, negedge TCENB, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge DFTRAMBYP, posedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge DFTRAMBYP, negedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CENB, negedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CENA, negedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge TCENA, negedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge TCENB, negedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge TCENB, posedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge TCENA, posedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CENB, posedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge CENA, posedge RET1N, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(negedge RET1N, posedge DFTRAMBYP, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
    $setuphold(posedge RET1N, posedge DFTRAMBYP, 0.000, `ARM_MEM_HOLD, NOT_RET1N);
  endspecify


endmodule
`endcelldefine
  `endif
`endif
`timescale 1ns/1ps
module sram_dp_hde_ibuf_error_injection (Q_out, Q_in, CLK, A, CEN, DFTRAMBYP, SE, WEN);
   output [15:0] Q_out;
   input [15:0] Q_in;
   input CLK;
   input [9:0] A;
   input CEN;
   input DFTRAMBYP;
   input SE;
   input WEN;
   parameter LEFT_RED_COLUMN_FAULT = 2'd1;
   parameter RIGHT_RED_COLUMN_FAULT = 2'd2;
   parameter NO_RED_FAULT = 2'd0;
   reg [15:0] Q_out;
   reg entry_found;
   reg list_complete;
   reg [18:0] fault_table [99:0];
   reg [18:0] fault_entry;
initial
begin
   `ifdef DUT
      `define pre_pend_path TB.DUT_inst.CHIP
   `else
       `define pre_pend_path TB.CHIP
   `endif
   `ifdef ARM_NONREPAIRABLE_FAULT
      `pre_pend_path.SMARCHCHKBVCD_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.MEM0_MEM_INST.u1.add_fault(10'd367,4'd6,2'd1,2'd0);
   `endif
end
   task add_fault;
   //This task injects fault in memory
   //In order to inject fault in redundant column for Bit 0 to 7, column address
   //should have value in range of 4 to 7
   //In order to inject fault in redundant column for Bit 8 to 15, column address
   //should have value in range of 0 to 3
      input [9:0] address;
      input [3:0] bitPlace;
      input [1:0] fault_type;
      input [1:0] red_fault;
 
      integer i;
      reg done;
   begin
      done = 1'b0;
      i = 0;
      while ((!done) && i < 99)
      begin
         fault_entry = fault_table[i];
         if (fault_entry[0] === 1'b0 || fault_entry[0] === 1'bx)
         begin
            fault_entry[0] = 1'b1;
            fault_entry[2:1] = red_fault;
            fault_entry[4:3] = fault_type;
            fault_entry[8:5] = bitPlace;
            fault_entry[18:9] = address;
            fault_table[i] = fault_entry;
            done = 1'b1;
         end
         i = i+1;
      end
   end
   endtask
//This task removes all fault entries injected by user
task remove_all_faults;
   integer i;
begin
   for (i = 0; i < 100; i=i+1)
   begin
      fault_entry = fault_table[i];
      fault_entry[0] = 1'b0;
      fault_table[i] = fault_entry;
   end
end
endtask
task bit_error;
// This task is used to inject error in memory and should be called
// only from current module.
//
// This task injects error depending upon fault type to particular bit
// of the output
   inout [15:0] q_int;
   input [1:0] fault_type;
   input [3:0] bitLoc;
begin
   if (fault_type === 2'd0)
      q_int[bitLoc] = 1'b0;
   else if (fault_type === 2'd1)
      q_int[bitLoc] = 1'b1;
   else
      q_int[bitLoc] = ~q_int[bitLoc];
end
endtask
task error_injection_on_output;
// This function goes through error injection table for every
// read cycle and corrupts Q output if fault for the particular
// address is present in fault table
//
// If fault is redundant column is detected, this task corrupts
// Q output in read cycle
//
// If fault is repaired using repair bus, this task does not
// courrpt Q output in read cycle
//
   output [15:0] Q_output;
   reg list_complete;
   integer i;
   reg [6:0] row_address;
   reg [2:0] column_address;
   reg [3:0] bitPlace;
   reg [1:0] fault_type;
   reg [1:0] red_fault;
   reg valid;
   reg [2:0] msb_bit_calc;
begin
   entry_found = 1'b0;
   list_complete = 1'b0;
   i = 0;
   Q_output = Q_in;
   while(!list_complete)
   begin
      fault_entry = fault_table[i];
      {row_address, column_address, bitPlace, fault_type, red_fault, valid} = fault_entry;
      i = i + 1;
      if (valid == 1'b1)
      begin
         if (red_fault === NO_RED_FAULT)
         begin
            if (row_address == A[9:3] && column_address == A[2:0])
            begin
               if (bitPlace < 8)
                  bit_error(Q_output,fault_type, bitPlace);
               else if (bitPlace >= 8 )
                  bit_error(Q_output,fault_type, bitPlace);
            end
         end
      end
      else
         list_complete = 1'b1;
      end
   end
   endtask
   always @ (Q_in or CLK or A or CEN or WEN)
   begin
   if (CEN === 1'b0 && &WEN === 1'b1 && DFTRAMBYP === 1'b0 && SE === 1'b0)
      error_injection_on_output(Q_out);
   else
      Q_out = Q_in;
   end
endmodule
