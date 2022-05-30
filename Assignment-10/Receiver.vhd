----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2022 11:45:40
-- Design Name: 
-- Module Name: Receiver - Behavioral
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

entity Receiver is
  Port (rxclk : in STD_LOGIC;
        rx_in : in STD_LOGIC;
        reset : in STD_LOGIC;
        rx_full : out STD_LOGIC;
        rx_reg : out STD_LOGIC_VECTOR(7 DOWNTO 0);
        rx_done : out STD_LOGIC 
        );
end Receiver;

architecture Behavioral of Receiver is

TYPE M_State is (idle,start,recieve,stop);
signal state: M_State := idle;


signal reg : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";

signal ticks : integer := 0;  -- integer to count the no of clock cycles
signal i : integer := 0;  -- to count the no of bits recieved or transmitted.
	
begin

process(rx_in,rxclk,reset)

begin

if(rxclk'event and rxclk = '1') then
	
	   --if  reset is pressed fsm enters idle state.
		
		if(reset = '1') then
			state <= idle;
			rx_done <= '0';
--			
		
		else
		
		    --if fsm in idle state it waits for start bit i.e; untill rx_in = 1 it remains in idle state when rx_in = 0 fsm enters start state.
		
			if(state = idle) then
			   rx_full <= '1';			
				if(rx_in = '0') then 
					ticks <= 0;
					i <= 0;
					state <= start;
				else
				    state <= idle;
			    
				    
				end if;
				
			-- It lies in start state till 6 clk cycles then enters recieve state where it starts receiving data
				
				
			elsif (state = start) then
			   rx_full <= '1';			
				if(rx_in = '1') then 
					ticks <= 0;
					state <= idle;
--					
					
				elsif rx_in = '0' then
					ticks <= ticks + 1;
					
					if(ticks = 6) then 
						state <= recieve;
						ticks <= 0;
						i <=0;
					end if;
				else
				    state <= start;
					
				end if;
						
			-- In recieve state fsm recives 1 one bit for every 15 clk cycles and then store into a temp variable reg 
			-- and loads it into rx_reg after recieving 8 bits and enters stop state
			
			elsif(state = recieve) then
			    rx_full <= '0';
				if(ticks < 15) then
					ticks <= ticks + 1;
				else 
					reg <= reg(7 DOWNTO 0) & rx_in;
					ticks <= 0;
					i <= i+1;
				end if;
				
				if(i=8) then
					i <= 0;
					rx_reg <= reg(7 DOWNTO 0);
					----Push into queue here----
					state <= stop;
				else
				    state <= recieve;
				end if;

			-- It lies in stop state for 16 clock cycles and enters into transmit_start state 
			elsif(state = stop) then
			    rx_full <= '0';
				if(ticks <= 15) then
					ticks <= ticks+1;
				else
					ticks <=0;
					rx_done <= '1';
					state <= idle;
					end if;
--		
				end if;
				
				
		end if;
		
	end if;


end process;


end Behavioral;