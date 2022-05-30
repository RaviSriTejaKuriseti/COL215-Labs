----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2022 12:15:14 PM
-- Design Name: 
-- Module Name: clk_gen - Behavioral
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

entity clk_gen is
  Port (clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        clk_9600 : out STD_LOGIC;
        clk_153600 : out STD_LOGIC);
end clk_gen;

architecture Behavioral of clk_gen is


signal clk_counter : integer := 0;
signal ctr_2 : integer := 0;

begin

process(clk)

begin

	if(rising_edge(clk)) then
	
	  if(reset='1') then clk_counter <=0 ; ctr_2 <= 0;
	  else 
		clk_counter <= clk_counter + 1;
		ctr_2 <= ctr_2 +1;
		
		if(clk_counter = 650) then
			clk_9600 <= '1';
			clk_counter <= 0;
		else
			clk_9600 <= '0';
		end if;
		
		if(ctr_2 = 10416) then
            clk_153600 <= '1';
            ctr_2 <= 0;
        else
            clk_153600 <= '0';
        end if;
		
	 end if;
	end if;

end process;




end Behavioral;