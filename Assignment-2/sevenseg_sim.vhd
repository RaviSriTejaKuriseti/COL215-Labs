----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2022 10:06:11 AM
-- Design Name: 
-- Module Name: sevenseg_sim - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sevenseg_sim is
--  Port ( );
end sevenseg_sim;

architecture Behavioral of sevenseg_sim is

component sevenseg_code is
      Port ( invect : in STD_LOGIC_VECTOR (0 to 3);
             outvect : out STD_LOGIC_VECTOR (0 to 6);
             anode: out STD_LOGIC_VECTOR(0 to 3)
             );
end component;

  signal A: STD_LOGIC_VECTOR (0 to 3);
  signal B: STD_LOGIC_VECTOR (0 to 6);
  signal C: STD_LOGIC_VECTOR(0 to 3);

begin

  DUT: sevenseg_code port map (A,B,C);

  process
  
  begin
  
  C <= "1110";
  
    A <= "0000";
    WAIT FOR 1 ns;
    ASSERT (B="0000001") REPORT "FAIL 0" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "0001";
    WAIT FOR 1 ns;
    ASSERT (B="1001111") REPORT "FAIL 1" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "0010";
    WAIT FOR 1 ns;
    ASSERT (B="0010010") REPORT "FAIL 2" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "0011";
    WAIT FOR 1 ns;
    ASSERT (B="0000110") REPORT "FAIL 3" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "0100";
    WAIT FOR 1 ns;
    ASSERT (B="1001100") REPORT "FAIL 4" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "0101";
    WAIT FOR 1 ns;
    ASSERT (B="0100100") REPORT "FAIL 5" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "0110";
    WAIT FOR 1 ns;
    ASSERT (B="0100000") REPORT "FAIL 6" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "0111";
    WAIT FOR 1 ns;
    ASSERT (B="0001111") REPORT "FAIL 7" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "1000";
    WAIT FOR 1 ns;
    ASSERT (B="0000000") REPORT "FAIL 8" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;

    A <= "1001";
    WAIT FOR 1 ns;
    ASSERT (B="0000100") REPORT "FAIL 9" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "1010";
    WAIT FOR 1 ns;
    ASSERT (B="0001000") REPORT "FAIL a" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "1011";
    WAIT FOR 1 ns;
    ASSERT (B="1100000") REPORT "FAIL b" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "1100";
    WAIT FOR 1 ns;
    ASSERT (B="0110001") REPORT "FAIL c" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "1101";
    WAIT FOR 1 ns;
    ASSERT (B="1000010") REPORT "FAIL d" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "1110";
    WAIT FOR 1 ns;
    ASSERT (B="0110000") REPORT "FAIL e" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;


    A <= "1111";
    WAIT FOR 1 ns;
    ASSERT (B="0111000") REPORT "FAIL f" SEVERITY ERROR;
--    report "value: " & to_string(B) severity note;

     A <= "0000";
     assert false report "Test done." severity note;
     
     wait;
     
  end process;


end Behavioral;
