----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2022 04:15:35 PM
-- Design Name: 
-- Module Name: sevensegref - Behavioral
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

entity sevensegref is
--  Port ( );
Port (     invect : in STD_LOGIC_VECTOR (0 to 3);
           outvect : out STD_LOGIC_VECTOR (0 to 6);
           clk: in STD_LOGIC
           );
end sevensegref;

architecture Behavioral of sevensegref is

begin
process(invect) is
    begin
    
    

 	outvect(0) <= not ((invect(0) and (not invect(1)) and (not invect(2))) 
 					or ((not invect(0)) and invect(1) and invect(3))
                    or (invect(0) and (not invect(3))) 
 					or ((not invect(0)) and invect(2)) 
					or (invect(1) and invect(2)) 
					or  ((not invect(1)) and (not invect(3))));
	
 	outvect(1) <= not (((not invect(0)) and (not invect(2)) and (not invect(3))) 
 					or ((not invect(0)) and invect(2) and invect(3)) 
 					or (invect(0) and (not invect(2)) and invect(3)) 
					or ((not invect(1)) and (not invect(2))) 
					or ((not invect(1)) and (not invect(3))));
					
	outvect(2) <= not (((not invect(0)) and (not invect(2))) 
					or ((not invect(0)) and invect(3)) 
					or ((not invect(2)) and invect(3)) 
					or ((not invect(0)) and invect(1)) 
					or (invect(0) and (not invect(1))));
					
	outvect(3) <= not (((not invect(0)) and (not invect(1)) and (not invect(3))) 
					or ((not invect(1)) and invect(2) and invect(3)) 
					or (invect(1) and (not invect(2)) and invect(3)) 
					or (invect(1) and invect(2) and (not invect(3)))
					or (invect(0) and (not invect(2))));
					
	outvect(4) <= not (((not invect(1)) and (not invect(3))) 
					or (invect(2) and (not invect(3))) 
					or (invect(0) and invect(2)) 
					or ( invect(0) and invect(1)));
					
	outvect(5) <= not (((not invect(0)) and invect(1) and (not invect(2))) 
					or ((not invect(2)) and (not invect(3))) 
					or (invect(1) and (not invect(3))) 
					or ( invect(0) and (not invect(1))) 
					or (invect(0) and invect(2)));
					
	outvect(6) <= not (((not invect(0)) and invect(1) and (not invect(2))) 
					or ((not invect(1)) and invect(2)) 
					or (invect(2) and (not invect(3))) 
					or (invect(0) and (not invect(1))) 
					or (invect(0) and invect(3)));

	end process;



end Behavioral;