--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
--Date        : Tue May 24 12:13:26 2022
--Host        : hoogly running 64-bit Ubuntu 16.04.7 LTS
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bram_wrapper is
  port (
    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 2 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 15 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 15 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_we : in STD_LOGIC
  );
end bram_wrapper;

architecture STRUCTURE of bram_wrapper is
  component design_1 is
  port (
    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 2 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 15 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 15 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_we : in STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      BRAM_PORTA_addr(2 downto 0) => BRAM_PORTA_addr(2 downto 0),
      BRAM_PORTA_clk => BRAM_PORTA_clk,
      BRAM_PORTA_din(15 downto 0) => BRAM_PORTA_din(15 downto 0),
      BRAM_PORTA_dout(15 downto 0) => BRAM_PORTA_dout(15 downto 0),
      BRAM_PORTA_en => BRAM_PORTA_en,
      BRAM_PORTA_we => BRAM_PORTA_we
    );
end STRUCTURE;
