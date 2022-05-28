----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2022 04:06:46 PM
-- Design Name: 
-- Module Name: queue - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity queue is
  Port (invect : IN STD_LOGIC_VECTOR(0 TO 15);
        button_in : IN STD_LOGIC_VECTOR(0 TO 2);
        clk : IN STD_LOGIC;  
        LED : OUT STD_LOGIC_VECTOR(0 TO 3);
        Z   : OUT STD_LOGIC_VECTOR(0 TO 6);
        anode : OUT STD_LOGIC_VECTOR(0 TO 3)
   );
end queue;

architecture Behavioral of queue is

--component mux_4to1 is used to display values on board.
component mux_4to1 is

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
  
end component;


component Debouncer is
port (
button_input : in std_logic;
clk : in std_logic;
button_output : out std_logic);

end component;

-- BRAM with single port is used to manage memory operations  .

component bram_wrapper is
  port (
    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 2 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 15 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 15 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_we : in STD_LOGIC
  );
end component;



signal A : STD_LOGIC_VECTOR(0 to 3) := "0000";
signal B : STD_LOGIC_VECTOR(0 to 3) := "0000"; 
signal C : STD_LOGIC_VECTOR(0 to 3) := "0000"; 
signal D : STD_LOGIC_VECTOR(0 to 3) := "0000"; 
signal button_out:STD_LOGIC_VECTOR(0 TO 2) := "000"; --push_button output
signal rst:STD_LOGIC;  --reset push button output

signal E:STD_LOGIC := '0';
signal WE:STD_LOGIC := '0';
signal addr:STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
signal outvect:STD_LOGIC_VECTOR(15 DOWNTO 0);

signal rear: integer range -1 to 7 := -1;
signal front: integer range -1 to 7 := -1;
signal queue_size: integer range 0 to 8 := 0;

-- display flag is used to off the display during write operations (when fsm is in Push state).
signal display_flag: STD_LOGIC := '0';
signal temp:STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

signal clk_ctr: integer:=0; 
signal proc_clk: STD_LOGIC;

TYPE M_State is (Push,Pop,Transient);
signal State: M_State := Transient;

begin

uut1 :  Debouncer port map  (button_in(0),clk,button_out(0)); --read
uut2 :  Debouncer port map  (button_in(1),clk,button_out(1));  --write
uut3 :  Debouncer port map  (button_in(2),clk,rst);
uut4:   bram_wrapper port map(addr,clk,invect,outvect,E,WE);
uut5 :  mux_4to1 port map  (A,B,C,D,Z,anode,clk,display_flag);


-- there are 3 states pop,Push,Transient
-- when no button is pressed fsm lies in Transient state 
-- when push button is pressed fsm moves to Push state for a moment and comes back to transient state
-- when pop button is pressed fsm moves to Pop state for a moment and comes back to transient state
-- the above transitions will occur irrespective of initial state of fsm.
process(button_out) 

begin

  case State is 


	When Push =>

	
    if(button_out="100") then
        State <= Pop;

    elsif(button_out="010") then 		
        State <= Push;
      
    else 
      State<= Transient;
      end if;
      
		
  When Pop=> 
        
      
    if(button_out="100") then
        State <= Pop;

    elsif(button_out="010") then 		
        State <= Push;
      
    else 
      State<= Transient;
      end if;
                
    

    When Transient =>
            
    
        if(button_out="010") then 
        State <= Push;
        
        
        elsif(button_out="100") then 
           State <= Pop;
        
        else 
         State<= Transient;
        end if;


  



	
	

	end case;

end process;


process(clk)

begin
if (rising_edge(clk)) then

    clk_ctr <= clk_ctr + 1;
		
        if(clk_ctr = 25000000) then
--		if(clk_ctr = 200) then
			proc_clk <= '1';
			clk_ctr <= 0;
		else
			proc_clk <= '0';
		end if;

end if;


end process;


-- using very low frequency clock to slow down the memeory operation with respect to button operations.


process(proc_clk,State)

begin 

if(proc_clk='1' and proc_clk' event ) then

case State is

-- IN transient state enable and write enable is 0 also
--if rst(reset = 1) all the values like queue size,addr.front,rear will be initialised to default values

WHEN Transient =>

if(rst='1') then
    front <= -1;
    rear <= -1;
    queue_size <= 0;
    addr <= "000";
    temp <= "000";
    WE <= '0';
    E <= '0';
    display_flag <= '0';


else

    display_flag <= '0';
    WE <= '0';
    E <= '0';

end if;

--IN Pop state queuesize is decreased by 1,front will be increased by 1 , display  will be off and if queue is empty fsm remains as such

WHEN Pop => 


WE <= '0';
display_flag <= '1';


if(front=-1) then

temp <= temp+0;

elsif(front=rear) then
E <= '1';
addr <= "000";
front <= -1;
rear <= -1;
queue_size<= queue_size-1;

else
E <= '1';
addr <= std_logic_vector(to_unsigned(front,3));
front <= (front+1) mod 8;
queue_size<= queue_size-1;

end if;


--IN Push state queuesize is increased by 1,rear icreases by 1 ,display will be on and if queue is full fsm remains as such

when Push => 

display_flag <= '0';
WE <= '1';


if((rear+1) mod 8=front) then

temp <= temp+0;


elsif(front=-1) then

E <= '1';


front <= 0;
rear <= 0;
queue_size<= queue_size+1;
addr<="000";


else
E <= '1';
addr <= std_logic_vector(to_unsigned(rear,3));
rear <= (rear+1) mod 8;
queue_size<= queue_size+1;


end if;


end case;



end if;

end process;


--Signal LED is used to display the size of queue on fpga  board through LED's

process(queue_size)

begin

case queue_size is

when 0 => LED <= "0000";
when 1 to 2 => LED <= "0001";
when 3 to 5 => LED <= "0011";
when 6 to 7 => LED <= "0111";
when 8 => LED <= "1111";
end case;

end process;

-- outvect stores the popped element from the queue and place it to the mux_4to1 through signals A,B,C,D to get displayed on board
process(outvect)

begin


A(0) <= outvect(3);
A(1) <= outvect(2);
A(2) <= outvect(1);
A(3) <= outvect(0);
B(0) <= outvect(7);
B(1) <= outvect(6);
B(2) <= outvect(5);
B(3) <= outvect(4);
C(0) <= outvect(11);
C(1) <= outvect(10);
C(2) <= outvect(9);
C(3) <= outvect(8);
D(0) <= outvect(15);
D(1) <= outvect(14);
D(2) <= outvect(13);
D(3) <= outvect(12);
end process;





end Behavioral;


