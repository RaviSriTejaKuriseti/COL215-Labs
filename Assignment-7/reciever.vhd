LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


entity reciever is

 port(
 
	 clk: in STD_LOGIC;
	 button_in : in STD_LOGIC;
	 Z : out STD_LOGIC_VECTOR(0 to 6);
	 anode : out STD_LOGIC_VECTOR(0 to 3);
	 rx_in : in STD_LOGIC
	 
  );
  
end reciever;



architecture behav of reciever is

component mux_4to1 is

	 port(
	 
		 
		 A : in STD_LOGIC_VECTOR(0 to 3);
		 B : in STD_LOGIC_VECTOR(0 to 3);
		 C : in STD_LOGIC_VECTOR(0 to 3);
		 D : in STD_LOGIC_VECTOR(0 to 3);
		 Z:  out STD_LOGIC_VECTOR(0 to 6);
		 anode : out STD_LOGIC_VECTOR(0 to 3);
		 clk: in STD_LOGIC
		 
	  );
	  
	 end component;
	 
	 
	 component Debouncer is
	 
		port (
		  button_input : in std_logic;
		  clk : in std_logic;
		  button_output : out std_logic
		);

	 end component;



	signal rxclk : STD_LOGIC;
	signal clk_counter : integer := 0;


	signal A : STD_LOGIC_VECTOR(0 to 3) := "0000";
	signal B : STD_LOGIC_VECTOR(0 to 3) := "0000"; 
	signal C : STD_LOGIC_VECTOR(0 to 3) := "0000"; 
	signal D : STD_LOGIC_VECTOR(0 to 3) := "0000"; 

	signal reset : STD_LOGIC := '0';
	
	TYPE M_State is (idle,start,recieve,stop);
	signal state: M_State := idle;

	signal rx_reg : STD_LOGIC_VECTOR(0 to 7) := "00000000";
	signal reg : STD_LOGIC_VECTOR(0 to 8) := "000000000";
	
	signal ticks : integer := 0;
	signal i : integer := 0;
	
	
	
	 
	 
  
--end mux_4to1;



begin


uut1 :  mux_4to1 port map  (A,B,C,D,Z,anode,clk);
uut2 :  Debouncer port map  ( button_in,clk ,reset);


-- creating a clock of frequency 9600x8 times the board clock.
process(clk)

begin

	if(rising_edge(clk)) then 
		clk_counter <= clk_counter + 1;
		
		if(clk_counter = 650) then
			rxclk <= '1';
			clk_counter <= 0;
		else
			rxclk <= '0';
		end if;
		
	end if;

end process;





process(rx_in,rxclk,reset) 


begin

	if(rxclk'event and rxclk = '1') then
	
	   --if  reset is pressed fsm enters idle state.
		
		if(reset = '1') then
			state <= idle;
--			A <= "0000";
--            B <= "0000";
		
		else
		
		    --if fsm in idle state it waits for start bit i.e; untill rx_in = 1 it remains in idle state when rx_in = 0 fsm enters start state.
		
			if(state = idle) then
			
				if(rx_in = '0') then 
					ticks <= 0;
					state <= start;
				else
				    state <= idle;
--				    A <= "0000";
--                    B <= "0000";
				    
				end if;
				
			-- It lies in start state till 6 clk cycles then enters recieve state where it starts receiving data
				
				
			elsif (state = start) then
			
				if(rx_in = '1') then 
					ticks <= 0;
					state <= idle;
--					A <= "0000";
--                    B <= "0000";
					
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
			
			elsif(state = recieve ) then
			
				if(ticks < 15) then
					ticks <= ticks + 1;
				else 
					reg <= reg(1 to 8) & rx_in;
					ticks <= 0;
					i <= i+1;
				end if;
				
				if(i=8) then
					i <= 0;
					rx_reg <= reg(1 to 8);
					state <= stop;
				else
				    state <= recieve;
				end if;
				
				
					

			elsif(state = stop) then
				if(ticks <= 15) then
					ticks <= ticks+1;
				else
					ticks <=0;
					state <= idle;
--					A <= "0000";
--                    B <= "0000";
				end if;
				
			end if;
		
		
		end if;

	end if;


end process;



-- load the data recieved in rx_reg into A,B to display on fpga through component from mux_4to1.

process(rx_reg) 

begin

A(0) <= rx_reg(7);
A(1) <= rx_reg(6);
A(2) <= rx_reg(5);
A(3) <= rx_reg(4);
B(0) <= rx_reg(3);
B(1) <= rx_reg(2);
B(2) <= rx_reg(1);
B(3) <= rx_reg(0);

end process;





end behav;










