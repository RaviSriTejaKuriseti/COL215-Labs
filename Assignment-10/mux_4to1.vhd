----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2022 10:28:54 AM
-- Design Name: 
-- Module Name: mux_4to1 - Behavioral
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

entity mux_4to1 is

 port(
 
     
	 A : in STD_LOGIC_VECTOR(0 to 3);
	 B : in STD_LOGIC_VECTOR(0 to 3);
	 C : in STD_LOGIC_VECTOR(0 to 3);
	 D : in STD_LOGIC_VECTOR(0 to 3);
     Z:  out STD_LOGIC_VECTOR(0 to 6);
	 anode : out STD_LOGIC_VECTOR(0 to 3);
	 clk: in STD_LOGIC;
	 flag: in STD_LOGIC
	 
  );
  
end mux_4to1;


architecture bhv of mux_4to1 is

	component sevensegref is
	  Port ( invect : in STD_LOGIC_VECTOR (0 to 3);
			 outvect : out STD_LOGIC_VECTOR (0 to 6);
             clk: in STD_LOGIC
			 
			 );
	end component;
	
	component Counter is 
	  port (Clock : in Std_logic;
        Q:   out Std_LOGIC_VECTOR(0 to 1)
        );
	end component;
	
	signal S: STD_LOGIC_VECTOR (0 to 3);
	signal Q1: STD_LOGIC_VECTOR (0 to 1);

begin

uut1:sevensegref port map (S,Z,clk);		  
uut2:Counter port map (clk,Q1);

  
	process (Q1,S) is
	
		begin
		
		if(flag='0') then anode <= "1111";
		else

		  if (Q1 = "00") then
		  S <= A;		  
		  anode <= "0111";
		  elsif (Q1 = "01") then
		  S <= B;
		  anode <="1011";
		  elsif (Q1 = "10") then	
		  S <= C;	
		  anode <= "1111";
		  else
		  S <= D;
		  anode <= "1111";
		  end if;
		  
	end if;
		  
		
		end process;
		
end bhv;