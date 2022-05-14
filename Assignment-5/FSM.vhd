----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2022 10:42:22 AM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
  Port (but: in STD_LOGIC_VECTOR(0 TO 1);
        clk: in STD_LOGIC;
        invect:in STD_LOGIC_VECTOR(0 TO 15);
        Z:  out STD_LOGIC_VECTOR(0 to 6);
        anode : inout STD_LOGIC_VECTOR(0 to 3);
        reset : in STD_LOGIC
        );
end FSM;

architecture Behavioral of FSM is




component Debouncer is 
  Port ( button_input : in std_logic;
         clk : in std_logic;
         button_output : out std_logic
         );
end component;

component sevensegref is
	  Port ( invect : in STD_LOGIC_VECTOR (0 to 3);
			 outvect : out STD_LOGIC_VECTOR (0 to 6);
             clk: in STD_LOGIC
			);
	end component;
	
component Counter is 
  port (Clock : in Std_logic;
    Q:   out Std_LOGIC_VECTOR(0 to 4);
    R: out  STD_LOGIC_VECTOR(0 to 1)
    );
end component;



TYPE M_State is (A,B,C);
signal State: M_State := A;
signal input: STD_LOGIC_VECTOR(0 TO 15):="0000000000000000";
signal V:STD_LOGIC_VECTOR(0 TO 1);
signal S:STD_LOGIC_VECTOR(0 TO 3);
signal Q1: STD_LOGIC_VECTOR (0 to 4);
signal Q2: STD_LOGIC_VECTOR (0 to 1);
signal Br:STD_LOGIC_VECTOR(0 TO 7):= "00000000";
signal Al:STD_LOGIC:='0';




begin

uut1: Debouncer port map(but(0),clk,V(0));
uut2: Debouncer port map(but(1),clk,V(1));
uut3: sevensegref port map (S,Z,clk);		  
uut4: Counter port map (clk,Q1,Q2);



process(V,reset)


begin

if(reset='1') then
State <= A;
Al <= '0';
else
  if(State=A) then
      if(V="10") then
      State <= B;
      
      else
      State <=A;
      end if;
      
      
  elsif(State=B) then
   
   if(V="01") then
    State <= C;
   else
     State <=B;
   end if;
   
 elsif(State=C) then
    if(V="10") then
      State <= B;
      Al <= '1';
    else
      State <= C;      
    end if;
    
    
end if;
end if;

end process;

process(State)
begin

case State is

WHEN B => 
input<=invect;
if(Al ='0') then 

if("00000" <= Q1 and Q1<="00111") then S<=input(0 TO 3); 
if(Q2="00") then anode <= "0111";
elsif(Q2="01") then anode <= "1110";
elsif(Q2="10") then anode <= "1101";
elsif(Q2="11") then anode <= "1011";
end if;

elsif("01000" <= Q1 and Q1 <= "01111") then S<=input(4 TO 7); 
if(Q2="00") then anode <= "1011";
elsif(Q2="01") then anode <= "0111";
elsif(Q2="10") then anode <= "1110";
elsif(Q2="11") then anode <= "1101";
end if;

elsif("10000" <= Q1 and Q1 <= "10111") then S<=input(8 TO 11); 
if(Q2="00") then anode <= "1101";
elsif(Q2="01") then anode <= "1011";
elsif(Q2="10") then anode <= "0111";
elsif(Q2="11") then anode <= "1110";
end if;

elsif("11000" <= Q1 and Q1 <= "11111") then S<=input(12 TO 15); 
if(Q2="00") then anode <= "1110";
elsif(Q2="01") then anode <= "1101";
elsif(Q2="10") then anode <= "1011";
elsif(Q2="11") then anode <= "0111";
end if;



end if;


else 

case Br(0 TO 1) is 

WHEN "00" => 
if("00000" <= Q1 and Q1<="00001") then S<=input(0 TO 3); 
if(Q2="00") then anode <= "0111";
elsif(Q2="01") then anode <= "1110";
elsif(Q2="10") then anode <= "1101";
elsif(Q2="11") then anode <= "1011";
end if;
elsif("00010" <= Q1 and Q1 <= "00111") then  anode<="1111";end if;

WHEN "01" => 
if("00000" <= Q1 and Q1<="00011") then S<=input(0 TO 3);
if(Q2="00") then anode <= "0111";
elsif(Q2="01") then anode <= "1110";
elsif(Q2="10") then anode <= "1101";
elsif(Q2="11") then anode <= "1011";
end if;
elsif("00011" <= Q1 and Q1 <= "00111") then anode<="1111";end if;

WHEN "10" => if("00000" <= Q1 and Q1<="00101") then S<=input(0 TO 3);
if(Q2="00") then anode <= "0111";
elsif(Q2="01") then anode <= "1110";
elsif(Q2="10") then anode <= "1101";
elsif(Q2="11") then anode <= "1011";
end if;
elsif("00110" <= Q1 and Q1 <= "00111") then anode<="1111";end if;

WHEN "11" =>  if("00000" <= Q1 and Q1<="00111") then S<=input(0 TO 3);
if(Q2="00") then anode <= "0111";
elsif(Q2="01") then anode <= "1110";
elsif(Q2="10") then anode <= "1101";
elsif(Q2="11") then anode <= "1011";
end if;
elsif(Q1>="01000" and Q1<="00111") then anode<="1111";end if;

WHEN OTHERS => anode<="1111";

end case;

case Br(2 TO 3) is 

WHEN "00" => 
if("01000"<=Q1 and Q1<="01001") then S<=input(4 TO 7); 
if(Q2="00") then anode <= "1011";
elsif(Q2="01") then anode <= "0111";
elsif(Q2="10") then anode <= "1110";
elsif(Q2="11") then anode <= "1101";
end if;
elsif ("01010" <=Q1 and Q1 <= "01111") then anode<="1111";end if;

WHEN "01" => 
if("01000" <= Q1 and Q1<="01011") then S<=input(4 TO 7);
if(Q2="00") then anode <= "1011";
elsif(Q2="01") then anode <= "0111";
elsif(Q2="10") then anode <= "1110";
elsif(Q2="11") then anode <= "1101";
end if;
elsif ("01100" <= Q1 and Q1 <= "01111") then anode<="1111";end if;

WHEN "10" => if("01000" <= Q1 and Q1<="01101") then S<=input(4 TO 7);
if(Q2="00") then anode <= "1011";
elsif(Q2="01") then anode <= "0111";
elsif(Q2="10") then anode <= "1110";
elsif(Q2="11") then anode <= "1101";
end if;
elsif("01110" <= Q1 and Q1 <= "01111") then anode<="1111";end if;

WHEN "11" =>  if("01000" <= Q1 and Q1<="01111") then S<=input(4 TO 7);
if(Q2="00") then anode <= "1011";
elsif(Q2="01") then anode <= "0111";
elsif(Q2="10") then anode <= "1110";
elsif(Q2="11") then anode <= "1101";
end if;
elsif (Q1>="10000" and Q1<="01111") then anode<="1111";end if;

WHEN OTHERS => anode<="1111";

end case;


case Br(4 TO 5) is 

WHEN "00" => 
if("10000"<=Q1 and Q1<="10001") then S<=input(8 TO 11); 
if(Q2="00") then anode <= "1101";
elsif(Q2="01") then anode <= "1011";
elsif(Q2="10") then anode <= "0111";
elsif(Q2="11") then anode <= "1110";
end if;
elsif("10010"<=Q1 and Q1<="10111") then anode<="1111";end if;

WHEN "01" => 
if("10000" <= Q1 and Q1<="10011") then S<=input(8 TO 11);
if(Q2="00") then anode <= "1101";
elsif(Q2="01") then anode <= "1011";
elsif(Q2="10") then anode <= "0111";
elsif(Q2="11") then anode <= "1110";
end if;
elsif("10100"<=Q1 and Q1<="10111") then anode<="1111";end if;

WHEN "10" => if("10000" <= Q1 and Q1<="10101") then S<=input(8 TO 11);
if(Q2="00") then anode <= "1101";
elsif(Q2="01") then anode <= "1011";
elsif(Q2="10") then anode <= "0111";
elsif(Q2="11") then anode <= "1110";
end if;
elsif("10110" <=Q1 and Q1<="10111") then anode<="1111";end if;

WHEN "11" =>  if("10000" <= Q1 and Q1<="10111") then S<=input(8 TO 11);
if(Q2="00") then anode <= "1101";
elsif(Q2="01") then anode <= "1011";
elsif(Q2="10") then anode <= "0111";
elsif(Q2="11") then anode <= "1110";
end if;
elsif(Q1<="10111" and Q1>="11000") then anode<="1111";end if;

WHEN OTHERS => anode<="1111";

end case;


case Br(6 TO 7) is 

WHEN "00" => 
if("11000"<=Q1 and Q1<="11001") then S<=input(12 TO 15); 
if(Q2="00") then anode <= "1110";
elsif(Q2="01") then anode <= "1101";
elsif(Q2="10") then anode <= "1011";
elsif(Q2="11") then anode <= "0111";
end if;
elsif("11010" <= Q1 and Q1<="11111") then anode<="1111";end if;

WHEN "01" => 
if("11000" <= Q1 and Q1<="11011") then S<=input(12 TO 15);
if(Q2="00") then anode <= "1110";
elsif(Q2="01") then anode <= "1101";
elsif(Q2="10") then anode <= "1011";
elsif(Q2="11") then anode <= "0111";
end if;
elsif("11100"<=Q1 and Q1<="11111") then anode<="1111";end if;


WHEN "10" => if("11000" <= Q1 and Q1<="11101") then S<=input(12 TO 15);
if(Q2="00") then anode <= "1110";
elsif(Q2="01") then anode <= "1101";
elsif(Q2="10") then anode <= "1011";
elsif(Q2="11") then anode <= "0111";
end if;
elsif("11110"<=Q1 and Q1<="11111") then anode<="1111";end if;

WHEN "11" =>  if("11000" <= Q1 and Q1<="11111") then S<=input(12 TO 15);
if(Q2="00") then anode <= "1110";
elsif(Q2="01") then anode <= "1101";
elsif(Q2="10") then anode <= "1011";
elsif(Q2="11") then anode <= "0111";
end if;
elsif(Q1>="11111") then anode<="1111";end if;
WHEN OTHERS => anode<="1111";

end case;

end if;


		 

WHEN C => 
Br <= invect(8 TO 15);

case Br(0 TO 1) is 

WHEN "00" => 
if("00000" <= Q1 and Q1 <="00001") then S<=input(0 TO 3); 
if(Q2="00") then anode <= "0111";
elsif(Q2="01") then anode <= "1110";
elsif(Q2="10") then anode <= "1101";
elsif(Q2="11") then anode <= "1011";
end if;
elsif("00010" <= Q1 and Q1 <= "00111") then  anode<="1111";end if;

WHEN "01" => 
if("00000" <= Q1 and Q1<="00011") then S<=input(0 TO 3);
if(Q2="00") then anode <= "0111";
elsif(Q2="01") then anode <= "1110";
elsif(Q2="10") then anode <= "1101";
elsif(Q2="11") then anode <= "1011";
end if;
elsif("00011" <= Q1 and Q1 <= "00111") then anode<="1111";end if;

WHEN "10" => if("00000" <= Q1 and Q1<="00101") then S<=input(0 TO 3);
if(Q2="00") then anode <= "0111";
elsif(Q2="01") then anode <= "1110";
elsif(Q2="10") then anode <= "1101";
elsif(Q2="11") then anode <= "1011";
end if;
elsif("00110" <= Q1 and Q1 <= "00111") then anode<="1111";end if;

WHEN "11" =>  if("00000" <= Q1 and Q1<="00111") then S<=input(0 TO 3);
if(Q2="00") then anode <= "0111";
elsif(Q2="01") then anode <= "1110";
elsif(Q2="10") then anode <= "1101";
elsif(Q2="11") then anode <= "1011";
end if;
elsif(Q1>="01000" and Q1<="00111") then anode<="1111";end if;

WHEN OTHERS => anode<="1111";

end case;

case Br(2 TO 3) is 

WHEN "00" => 
if("01000"<=Q1 and Q1<="01001") then S<=input(4 TO 7); 
if(Q2="00") then anode <= "1011";
elsif(Q2="01") then anode <= "0111";
elsif(Q2="10") then anode <= "1110";
elsif(Q2="11") then anode <= "1101";
end if;
elsif ("01010" <=Q1 and Q1 <= "01111") then anode<="1111";end if;

WHEN "01" => 
if("01000" <= Q1 and Q1<="01011") then S<=input(4 TO 7);
if(Q2="00") then anode <= "1011";
elsif(Q2="01") then anode <= "0111";
elsif(Q2="10") then anode <= "1110";
elsif(Q2="11") then anode <= "1101";
end if;
elsif ("01100" <= Q1 and Q1 <= "01111") then anode<="1111";end if;

WHEN "10" => if("01000" <= Q1 and Q1<="01101") then S<=input(4 TO 7);
if(Q2="00") then anode <= "1011";
elsif(Q2="01") then anode <= "0111";
elsif(Q2="10") then anode <= "1110";
elsif(Q2="11") then anode <= "1101";
end if;
elsif("01110" <= Q1 and Q1 <= "01111") then anode<="1111";end if;

WHEN "11" =>  if("01000" <= Q1 and Q1<="01111") then S<=input(4 TO 7);
if(Q2="00") then anode <= "1011";
elsif(Q2="01") then anode <= "0111";
elsif(Q2="10") then anode <= "1110";
elsif(Q2="11") then anode <= "1101";
end if;
elsif (Q1>="10000" and Q1<="01111") then anode<="1111";end if;

WHEN OTHERS => anode<="1111";

end case;


case Br(4 TO 5) is 

WHEN "00" => 
if("10000"<=Q1 and Q1<="10001") then S<=input(8 TO 11); 
if(Q2="00") then anode <= "1101";
elsif(Q2="01") then anode <= "1011";
elsif(Q2="10") then anode <= "0111";
elsif(Q2="11") then anode <= "1110";
end if;
elsif("10010"<=Q1 and Q1<="10111") then anode<="1111";end if;

WHEN "01" => 
if("10000" <= Q1 and Q1<="10011") then S<=input(8 TO 11);
if(Q2="00") then anode <= "1101";
elsif(Q2="01") then anode <= "1011";
elsif(Q2="10") then anode <= "0111";
elsif(Q2="11") then anode <= "1110";
end if;
elsif("10100"<=Q1 and Q1<="10111") then anode<="1111";end if;

WHEN "10" => if("10000" <= Q1 and Q1<="10101") then S<=input(8 TO 11);
if(Q2="00") then anode <= "1101";
elsif(Q2="01") then anode <= "1011";
elsif(Q2="10") then anode <= "0111";
elsif(Q2="11") then anode <= "1110";
end if;
elsif("10110" <=Q1 and Q1<="10111") then anode<="1111";end if;

WHEN "11" =>  if("10000" <= Q1 and Q1<="10111") then S<=input(8 TO 11);
if(Q2="00") then anode <= "1101";
elsif(Q2="01") then anode <= "1011";
elsif(Q2="10") then anode <= "0111";
elsif(Q2="11") then anode <= "1110";
end if;
elsif(Q1<="10111" and Q1>="11000") then anode<="1111";end if;

WHEN OTHERS => anode<="1111";

end case;


case Br(6 TO 7) is 

WHEN "00" => 
if("11000"<=Q1 and Q1<="11001") then S<=input(12 TO 15); 
if(Q2="00") then anode <= "1110";
elsif(Q2="01") then anode <= "1101";
elsif(Q2="10") then anode <= "1011";
elsif(Q2="11") then anode <= "0111";
end if;
elsif("11010" <= Q1 and Q1<="11111") then anode<="1111";end if;

WHEN "01" => 
if("11000" <= Q1 and Q1<="11011") then S<=input(12 TO 15);
if(Q2="00") then anode <= "1110";
elsif(Q2="01") then anode <= "1101";
elsif(Q2="10") then anode <= "1011";
elsif(Q2="11") then anode <= "0111";
end if;
elsif("11100"<=Q1 and Q1<="11111") then anode<="1111";end if;


WHEN "10" => if("11000" <= Q1 and Q1<="11101") then S<=input(12 TO 15);
if(Q2="00") then anode <= "1110";
elsif(Q2="01") then anode <= "1101";
elsif(Q2="10") then anode <= "1011";
elsif(Q2="11") then anode <= "0111";
end if;
elsif("11110"<=Q1 and Q1<="11111") then anode<="1111";end if;

WHEN "11" =>  if("11000" <= Q1 and Q1<="11111") then S<=input(12 TO 15);
if(Q2="00") then anode <= "1110";
elsif(Q2="01") then anode <= "1101";
elsif(Q2="10") then anode <= "1011";
elsif(Q2="11") then anode <= "0111";
end if;
elsif(Q1>="11111") then anode<="1111";end if;
WHEN OTHERS => anode<="1111";

end case;

WHEN OTHERS=> anode<="1111";

end case;



end process;

end Behavioral;
