----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2022 10:18:59 AM
-- Design Name: 
-- Module Name: Counter - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity Counter is
  port (Clock: in STD_LOGIC;
        Q:   out STD_LOGIC_VECTOR (0 to 3);
        R: out  STD_LOGIC_VECTOR(0 to 1)
        );
end;


architecture RTL of Counter is
signal counter : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
--signal rot_counter:std_logic_vector(1 downto 0):= "00";
  
begin
  process (Clock)
  
  begin
    if (rising_edge(Clock)) then
       counter <= counter + 1;
    end if;
  end process;
  Q <= counter(19 downto 16);
  R <= counter(27 downto 26);
end;

