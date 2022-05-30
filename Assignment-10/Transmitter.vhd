----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2022 11:45:27
-- Design Name: 
-- Module Name: Transmitter - Behavioral
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

entity Transmitter is
  Port (txclk : in STD_LOGIC;
        tx_data : in STD_LOGIC_VECTOR(7 DOWNTO 0);
        reset : in STD_LOGIC;
        ld_tx  : in STD_LOGIC;
        tx_empty : out STD_LOGIC;
        tx_out  : out STD_LOGIC;
        tx_done : out STD_LOGIC
        );
end Transmitter;

architecture Behavioral of Transmitter is

TYPE M_State is (idle,start,send,stop);
signal state: M_State := idle;

signal ticks : integer := 0;  -- integer to count the no of clock cycles
signal i : integer := 0;  -- to count the no of bits recieved or transmitted.


begin

process(tx_data,txclk,reset)

begin

if(txclk'event and txclk = '1') then
	
	  --if  reset is pressed fsm enters idle state.
		
		if(reset = '1') then
			state <= idle;
			tx_done <= '0';
--			
		
		else

-- In this state  the first phase of transmission of recieved data occurs 
			-- i.e it transmitts '0' for around 16 clock cycles and enters transmit_cont state
			
			if(state=idle) then 
			 tx_empty <= '1';
			 tx_done <= '0';
			 if(ld_tx='1') then 
			   ticks <= 0;
			   i <= 0;
			   state <= start;
			 else
			   state <= idle;
			  end if;
			
			
			elsif(state = start) then
			    tx_done <= '0';
			    tx_empty <= '0';
				if(ticks < 15) then
					ticks <= ticks + 1;
				else 
					ticks  <= 0;
					state <= send;
				end if;
				tx_out <= '0';
			-- In this state there will be a continuos transmission of recieved data in the form std_logic 
			-- i.e it send 1 bit of the recieved data for 16 clock cycles and 8 bits will be transmitted and then enters transmit_stop state.
			elsif(state = send) then
			   tx_done <= '0';
			   tx_empty <= '0';			
			   if(ticks < 15 and i<8) then
				    --send to tx_out the data popped from queue.
					tx_out <= tx_data(i);
					ticks <= ticks + 1;
				elsif(ticks = 15 and i<8) then 
					ticks <= 0;
					i <= i + 1;
				end if;
					
				if(i=8) then
					i <= 0;
					ticks <= 0;
					state <= stop;
				end if;
					
			--In this state '1' will be transmitted for around 16 clock cycles 
			--and enters idle state and awaits for receiving another set of data.
			
			elsif(state = stop) then
			
			    tx_empty <= '0';
				if(ticks <= 15) then
					tx_out <= '1';
					tx_done <= '0';
					ticks <= ticks + 1;
				else 
					ticks <= 0;
					tx_done <= '1';
					state <= idle;
			    end if;
			    
		     end if;
		     
		  end if;
		  
		 end if;
		 
		end process;
		
		

end Behavioral;