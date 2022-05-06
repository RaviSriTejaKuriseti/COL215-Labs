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
	 clk: in STD_LOGIC
	 
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
        Q:   out Std_LOGIC_VECTOR(0 to 3);
        R: out  STD_LOGIC_VECTOR(0 to 1)
        );
	end component;
	
	signal S: STD_LOGIC_VECTOR (0 to 3);
	signal Q1: STD_LOGIC_VECTOR (0 to 3);
	signal Q2: STD_LOGIC_VECTOR (0 to 1);

begin

uut1:sevensegref port map (S,Z,clk);		  
uut2:Counter port map (clk,Q1,Q2);

  
	process (Q1,S) is
	
		begin
		
		 if(Q2="00") then 
		 
          if (Q1 = "1111") then
          S <= D;          
          anode <= "1110";
          elsif (Q1 = "1110" or Q1="1101") then
          S <= C;
          anode <="1101";
          elsif (Q1="1100" or Q1 = "1001" or Q1 = "1010" or Q1 = "1011") then    
          S <= B;    
          anode <= "1011";
          else
          S <= A;
          anode <= "0111";
          end if;
          
         elsif(Q2="01") then 
                  
           if (Q1 = "1111") then
           S <= A;          
           anode <= "1110";
           elsif (Q1 = "1110" or Q1="1101") then
           S <= D;
           anode <="1101";
           elsif (Q1="1100" or Q1 = "1001" or Q1 = "1010" or Q1 = "1011") then    
           S <= C;    
           anode <= "1011";
           else
           S <= B;
           anode <= "0111";
           end if;
          elsif(Q2="10") then 
                            
             if (Q1 = "1111") then
             S <= B;          
             anode <= "1110";
             elsif (Q1 = "1110" or Q1="1101") then
             S <= A;
             anode <="1101";
             elsif (Q1="1100" or Q1 = "1001" or Q1 = "1010" or Q1 = "1011") then    
             S <= D;    
             anode <= "1011";
             else
             S <= C;
             anode <= "0111";
             end if;
             
           else
            
                    
             if (Q1 = "1111") then
             S <= C;          
             anode <= "1110";
             elsif (Q1 = "1110" or Q1="1101") then
             S <= B;
             anode <="1101";
             elsif (Q1="1100" or Q1 = "1001" or Q1 = "1010" or Q1 = "1011") then    
             S <= A;    
             anode <= "1011";
             else
             S <= D;
             anode <= "0111";
             end if;
             
           end if;

         
		  
		
		end process;
		
end bhv;