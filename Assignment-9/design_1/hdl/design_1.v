//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
//Date        : Tue May 24 14:50:40 2022
//Host        : satluj running 64-bit Ubuntu 16.04.5 LTS
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (BRAM_PORTA_addr,
    BRAM_PORTA_clk,
    BRAM_PORTA_din,
    BRAM_PORTA_dout,
    BRAM_PORTA_en,
    BRAM_PORTA_we);
  input [2:0]BRAM_PORTA_addr;
  input BRAM_PORTA_clk;
  input [15:0]BRAM_PORTA_din;
  output [15:0]BRAM_PORTA_dout;
  input BRAM_PORTA_en;
  input [0:0]BRAM_PORTA_we;

  wire [2:0]BRAM_PORTA_1_ADDR;
  wire BRAM_PORTA_1_CLK;
  wire [15:0]BRAM_PORTA_1_DIN;
  wire [15:0]BRAM_PORTA_1_DOUT;
  wire BRAM_PORTA_1_EN;
  wire [0:0]BRAM_PORTA_1_WE;

  assign BRAM_PORTA_1_ADDR = BRAM_PORTA_addr[2:0];
  assign BRAM_PORTA_1_CLK = BRAM_PORTA_clk;
  assign BRAM_PORTA_1_DIN = BRAM_PORTA_din[15:0];
  assign BRAM_PORTA_1_EN = BRAM_PORTA_en;
  assign BRAM_PORTA_1_WE = BRAM_PORTA_we[0];
  assign BRAM_PORTA_dout[15:0] = BRAM_PORTA_1_DOUT;
  design_1_blk_mem_gen_0_0 blk_mem_gen_0
       (.addra(BRAM_PORTA_1_ADDR),
        .clka(BRAM_PORTA_1_CLK),
        .dina(BRAM_PORTA_1_DIN),
        .douta(BRAM_PORTA_1_DOUT),
        .ena(BRAM_PORTA_1_EN),
        .wea(BRAM_PORTA_1_WE));
endmodule
