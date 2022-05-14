library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Debouncer is
Port (
button_input : in std_logic;
clk : in std_logic;
button_output : out std_logic);

end Debouncer;



architecture Behavioral of Debouncer is

signal t1: STD_LOGIC := '0';
--signal t2: STD_LOGIC := '0';
--signal t3: STD_LOGIC;

begin

process(clk)

begin

if rising_edge(clk) then button_output <= button_input;
--t2 <= t1;
--t3 <= t2;
end if;
end process;

--button_output <= t1 AND t2 AND t3;


end Behavioral;