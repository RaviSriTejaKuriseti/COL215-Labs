//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
//Date        : Tue May 24 14:50:40 2022
//Host        : satluj running 64-bit Ubuntu 16.04.5 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
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

  wire [2:0]BRAM_PORTA_addr;
  wire BRAM_PORTA_clk;
  wire [15:0]BRAM_PORTA_din;
  wire [15:0]BRAM_PORTA_dout;
  wire BRAM_PORTA_en;
  wire [0:0]BRAM_PORTA_we;

  design_1 design_1_i
       (.BRAM_PORTA_addr(BRAM_PORTA_addr),
        .BRAM_PORTA_clk(BRAM_PORTA_clk),
        .BRAM_PORTA_din(BRAM_PORTA_din),
        .BRAM_PORTA_dout(BRAM_PORTA_dout),
        .BRAM_PORTA_en(BRAM_PORTA_en),
        .BRAM_PORTA_we(BRAM_PORTA_we));
endmodule
