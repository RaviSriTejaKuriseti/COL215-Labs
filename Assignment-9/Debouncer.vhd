library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



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

signal clk_counter: integer:=0; 
signal deb_clk: STD_LOGIC;

begin

process(clk)

begin


if(rising_edge(clk)) then 
		clk_counter <= clk_counter + 1;
		
		if(clk_counter = 200) then
			deb_clk <= '1';
			clk_counter <= 0;
		else
			deb_clk <= '0';
		end if;
		
	end if;

end process;







process(deb_clk)

begin

if(deb_clk='1' and deb_clk' event ) then

t1 <= button_input;
t2 <= t1;
t3 <= t2;
end if;
end process;

button_output <= t1 AND t2 AND t3;


end Behavioral;