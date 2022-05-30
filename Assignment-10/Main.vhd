----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2022 13:00:21
-- Design Name: 
-- Module Name: Main - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Main is
  Port (clk : in STD_LOGIC;
        button_in : IN STD_LOGIC_VECTOR(0 TO 1);
        rx_in : IN STD_LOGIC;
        anode : OUT STD_LOGIC_VECTOR(0 TO 3);
        Z : OUT STD_LOGIC_VECTOR(0 TO 6);
        tx_out : OUT STD_LOGIC
        );
end Main;

architecture Behavioral of Main is

component clk_gen is
 Port (clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        clk_9600 : out STD_LOGIC;
        clk_153600 : out STD_LOGIC);
end component;

component Debouncer is
Port (
button_input : in std_logic;
clk : in std_logic;
button_output : out std_logic);

end component;


component Transmitter is
  Port (txclk : in STD_LOGIC;
        tx_data : in STD_LOGIC_VECTOR(7 DOWNTO 0);
        reset : in STD_LOGIC;
        ld_tx  : in STD_LOGIC;
        tx_empty : out STD_LOGIC;
        tx_out  : out STD_LOGIC;
        tx_done : out STD_LOGIC 
        
        );
end component;

component Receiver is
  Port (rxclk : in STD_LOGIC;
        rx_in : in STD_LOGIC;
        reset : in STD_LOGIC;
        rx_full : out STD_LOGIC;
        rx_reg : out STD_LOGIC_VECTOR(7 DOWNTO 0);
        rx_done : out STD_LOGIC      
        );
end component;

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

component design_1_wrapper is
  port (
    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 10 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 7 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_we : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end component;

component timing_circuit is
Port ( 
        clk : IN STD_LOGIC;
        reset   : IN STD_LOGIC;
        rx_full  : IN STD_LOGIC;
        tx_empty : IN STD_LOGIC;
        tx_start : IN STD_LOGIC;
        ld_tx : OUT STD_LOGIC;
        write_addr: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
        read_addr : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
        wen : OUT STD_LOGIC_VECTOR(0 TO 0);
        en : OUT STD_LOGIC;
        State_flag : OUT STD_LOGIC_VECTOR(0 TO 2)
);
end component;


SIGNAL reset: STD_LOGIC;
SIGNAL clk9600 : STD_LOGIC;
SIGNAL clk_153600 : STD_LOGIC;
signal A : STD_LOGIC_VECTOR(0 to 3) := "0000";
signal B : STD_LOGIC_VECTOR(0 to 3) := "0000"; 
signal C : STD_LOGIC_VECTOR(0 to 3) := "0000"; 
signal D : STD_LOGIC_VECTOR(0 to 3) := "0000"; 


--signal addr : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
signal read_addr :  STD_LOGIC_VECTOR(10 DOWNTO 0) := "00000000000";
signal write_addr : STD_LOGIC_VECTOR(10 DOWNTO 0) := "00000000000";
signal addr: std_logic_vector(10 DOWNTO 0) := "00000000000";

signal in_vect: STD_LOGIC_VECTOR(7 DOWNTO 0) :=  "00000000";
signal out_vect: STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";

signal en: STD_LOGIC;
signal wen : STD_LOGIC_VECTOR(0 TO 0);

signal rx_full : STD_LOGIC;
signal tx_empty : STD_LOGIC := '1';
SIGNAL tx_start: STD_LOGIC;
signal ld_tx : STD_LOGIC;

signal rxd : STD_LOGIC :='0';
signal txd : STD_LOGIC := '0';

signal REG: STD_LOGIC_VECTOR(7 DOWNTO 0);

signal State_flag : STD_LOGIC_VECTOR(0 TO 2) := "000";
signal d_flag : STD_LOGIC := '0';

TYPE M_State is (Idle,Rx_Done,Rx_Wait,Tx_Wait,Tx_Done);

signal State: M_State := Idle;
signal rear: integer range -1 to 2047 := -1;
signal front: integer range -1 to 2047 := -1;
signal queue_size: integer range 0 to 2048:= 0;
signal temp: integer range 0 to 2:= 0;


begin

uut1: Debouncer port map(button_in(0),clk,reset);
uut2: Debouncer port map(button_in(1),clk,tx_start);
uut3: clk_gen port map(clk,reset,clk9600,clk_153600);
uut4: Receiver port map (clk9600,rx_in,reset,rx_full,in_vect,rxd);
uut5: Transmitter port map (clk_153600,out_vect,reset,ld_tx,tx_empty,tx_out,txd);
uut6: design_1_wrapper port map (addr,clk_153600,in_vect,out_vect,en,wen);
uut7: mux_4to1 port map  (A,B,C,D,Z,anode,clk,d_flag);

process(reset,clk_153600)

begin

if(clk_153600' event and clk_153600='1') then

 if(reset='1') then 
      --Reset to default values--
      write_addr <= "00000000000";
      read_addr <= "00000000000";      
      ld_tx <= '0';
      front <= -1;
      rear <= -1;
      queue_size <= 0; 
      State <= Idle;
      wen <= "0";
      en <= '0';
      State_flag <= "000";     
    
else

  case State is 
  
	
  WHEN Idle =>
  
   State_flag <= "000";
   wen <= "0";
   en <= '0';
   ld_tx <= '0';
  
    
		if(rx_full='0') then 
    --Idle state--
		  State <= Rx_Wait;

        elsif(tx_start='1') then
         State <= Tx_Wait;
		 
		else
		  State <= Idle; 
		
		end if;
		
 



	WHEN Rx_Wait =>

  --Waits for receiver to finish so that it can write data to memory--
    ld_tx <= '0';
	
	State_flag <= "001";
    if(rx_full='1') then 		
		State <= Rx_Done;
		 
	else
	    State <= Rx_Wait; 
		
		
    end if;




    WHEN Rx_Done =>

    --Write data to memory--
    State_flag <=  "010";
    ld_tx <= '0';
    
    if((rear+1) mod 2048=front) then
        en <= '0';
        wen <= "0";
        State <= Idle;
    
    
    else
    
        if(front=-1) then
        
            en <= '1';
            wen <= "1";      
            front <= 0;
            rear <= 0;
            queue_size<= queue_size+1;
            write_addr<="00000000000";
            addr<=write_addr;
            State <= Idle;
        
        
        else
            en <= '1';
            wen <= "1";
            write_addr <= std_logic_vector(to_unsigned(rear,11));
            addr<= write_addr;
            rear <= (rear+1) mod 2048;
            queue_size<= queue_size+1;
            State <= Idle;
    
    
        end if;


    end if;




  When Tx_Wait =>

  --Waits to read data from memory--.
  State_flag <= "011";
  wen <= "0";
    if(front=-1) then
        State <= Idle;
        en <= '0';
    else

    if(tx_empty='1') then    
        ld_tx <= '1';
        State <= Tx_Wait;
    else
       ld_tx <= '0';
       State <= Tx_Done;
   end if; 
   
 end if;  
    


 


 When Tx_Done =>

  --Reads from memory into register--
  State_flag <= "100";
  
   if(txd='1') then
     en <= '0';
     wen <= "0";
     State <= Idle;
 
    elsif(front=rear) then 
           
        if(front=-1) then 
            State <= Idle;
            en <= '0';
            wen <= "0";
        
        else
        
        en <= '1';
        wen<="0";
        read_addr <= "00000000000";
        front <= -1;
        rear <= -1;
        queue_size<= queue_size-1;
        addr<=read_addr;
        State <= Idle;
        
        
        end if;
    
    
 else
    en <= '1';
    wen <= "0";
    read_addr <= std_logic_vector(to_unsigned(front,11));
    front <= (front+1) mod 2048;
    queue_size<= queue_size-1;
    addr<=read_addr;
    State <= Idle;
    
     
    

 end if;


  
  



	       end case;
	  end if;
	
end if;

end process;




process(clk)

begin

case State_flag is

WHEN "010" => REG<= in_vect; d_flag<='1';
WHEN "100" => REG<= out_vect; d_flag<='1';
WHEN others => d_flag<='0';
end case;

A(0) <= REG(0);
A(1) <= REG(1);
A(2) <= REG(2);
A(3) <= REG(3);
B(0) <= REG(4);
B(1) <= REG(5);
B(2) <= REG(6);
B(3) <= REG(7);

end process;

end Behavioral;
