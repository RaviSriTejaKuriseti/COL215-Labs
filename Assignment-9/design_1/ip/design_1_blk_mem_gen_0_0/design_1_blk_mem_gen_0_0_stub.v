// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Tue May 24 14:51:47 2022
// Host        : satluj running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/btech/cs1190323/Assignment-9/Assignment-9.srcs/sources_1/bd/design_1/ip/design_1_blk_mem_gen_0_0/design_1_blk_mem_gen_0_0_stub.v
// Design      : design_1_blk_mem_gen_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_5,Vivado 2016.4" *)
module design_1_blk_mem_gen_0_0(clka, ena, wea, addra, dina, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[2:0],dina[15:0],douta[15:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [2:0]addra;
  input [15:0]dina;
  output [15:0]douta;
endmodule
