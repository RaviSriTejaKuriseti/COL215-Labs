----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2022 12:31:01 PM
-- Design Name: 
-- Module Name: Debouncer - Behavioral
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

entity Debouncer is
Port (
button_input : in std_logic;
clk : in std_logic;
button_output : out std_logic);

end Debouncer;

architecture Behavioral of Debouncer is

signal t1: STD_LOGIC;
signal t2: STD_LOGIC;
signal t3: STD_LOGIC;

begin

process(clk)

begin

if rising_edge(clk) then
t1 <= button_input;
t2 <= t1;
t3 <= t2;
end if;
end process;

button_output <= t1 AND t2 AND t3;


end Behavioral;
