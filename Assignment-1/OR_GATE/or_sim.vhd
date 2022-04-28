----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2022 02:47:36 PM
-- Design Name: 
-- Module Name: and_sim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity and_gate_tb is
end;

architecture bench of and_gate_tb is

  component or_code
      Port ( A : in STD_LOGIC;
             B : in STD_LOGIC;
             C : out STD_LOGIC);
  end component;

  signal A: STD_LOGIC;
  signal B: STD_LOGIC;
  signal C: STD_LOGIC;

begin

  DUT: or_code port map ( A => A,
                           B => B,
                           C => C );

  stimulus: process
  begin
  
  A <= '0';
  B <= '0';
  WAIT FOR 1 ps;
  ASSERT (C='0') REPORT "FAIL 0/1" SEVERITY ERROR;
  
   A <= '0';
   B <= '1';
   WAIT FOR 1 ps;
   ASSERT (C='1') REPORT "FAIL 0/1" SEVERITY ERROR;
   
    A <= '1';
    B <= '0';
    WAIT FOR 1 ps;
    ASSERT (C='1') REPORT "FAIL 0/1" SEVERITY ERROR;
    
     A <= '1';
     B <= '1';
     WAIT FOR 1 ps;
     ASSERT (C='1') REPORT "FAIL 0/1" SEVERITY ERROR;
  
    -- Put initialisation code here
     A <= '0';
     B <= '0';
   
       assert false report "Test done." severity note;
       wait;
     end process;
   end bench;



    -- Put test bench stimulus code here

   



