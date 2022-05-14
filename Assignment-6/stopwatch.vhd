LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


entity stopwatch is

port (
   clk: in std_logic; -- 100MHz clock input 
   Z : out std_logic_vector(0 to 6);
   button_in : in std_logic_vector(0 to 2);
   anode : out STD_LOGIC_VECTOR(0 to 3)
   
  );
  
end stopwatch;


architecture Behavioral of stopwatch is


component Clock_Counter is

  port (Clock: in STD_LOGIC;
        P    : in STD_LOGIC;
        Q    : in STD_LOGIC;
        decisec : inout integer;
		sec : inout integer;
		tensec : inout integer;
		min : inout integer
        );
end component;
	
	
	
	component Debouncer is 
	
	Port ( button_input : in std_logic;
		clk : in std_logic;
		button_output : out std_logic);
	
	end component;
	
	
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
	
	
	
	
	
	signal C1: integer;
	signal C2: integer;
	signal C3: integer;
	signal C4: integer;
	signal button_out : std_logic_vector(0 to 2);
	
	
	
	signal A : std_logic_vector(0 to 3) := "0000";
	signal B : std_logic_vector(0 to 3) := "0000";
	signal C : std_logic_vector(0 to 3) := "0000";
	signal D : std_logic_vector(0 to 3) := "0000";
	signal P: STD_LOGIC:= '0';
	signal Q: STD_LOGIC:= '1';

	
	
	TYPE M_State is (S0,S1,S2);
	signal State: M_State := S0;
	
	
	
begin


uut1: mux_4to1 port map (A,B,C,D,Z,anode,clk);
--uut2: Clock_Counter port map (clk,P,Q,C1,C2,C3,C4);
uut2: Debouncer port map ( button_in(0) , clk , button_out(0));
uut3: Debouncer port map ( button_in(1) , clk , button_out(1));
uut4: Debouncer port map ( button_in(2) , clk , button_out(2));
uut5: Clock_Counter port map (clk,P,Q,C1,C2,C3,C4);







--process(button_in) 

--begin


--	if(State = S0) then
--	    P <= '1';
--	    Q <='1';
----         C1 <= 0;
----         C2 <= 0;
----         C3 <= 0;
----         C4 <= 0;
	 
--		if(button_in="100") then 
		
--		State <= S1; 
		
--		end if;



--	elsif(State = S1) then
--	    P <= '0';
--	    Q <= '0';
	
--		if(button_in="001") then 
--		State <= S0;
--		end if;
		
--		if(button_in="010") then 
--		State <= S2;
--		end if;



--	elsif(State = S2) then 
--	    P <= '1';
--	    Q <= '0';
--		if(button_in="100") then 
--		State <= S1; 
--		end if;
		
--		if(button_in="001") then 
--		State <= S0;
--		end if;
		
	

--	end if;

--end process;



process(button_out) 

begin


	if(State = S0) then
	    P <= '1';
	    Q <='1';
--         C1 <= 0;
--         C2 <= 0;
--         C3 <= 0;
--         C4 <= 0;
	 
		if(button_out="100") then 
		
		State <= S1;
		
		else
		 State<=S0; 
		
		end if;



	elsif(State = S1) then
	    P <= '0';
	    Q <= '0';
	
		if(button_out="001") then 
		State <= S0;
		
		elsif(button_out="010") then 
		State <= S2;
		
		else State<=S1;
		end if;



	elsif(State = S2) then 
	    P <= '1';
	    Q <= '0';
		if(button_out="100") then 
		State <= S1; 
		
		elsif(button_out="001") then 
		State <= S0;
		
		else
		State<=S2;
		end if;
		
	

	end if;

end process;





process (State)


begin 


if(State = S0) then


   A <= "0000";
   B <= "0000";
   C <= "0000";
   D <= "0000";
   
   

else 

--	if(rising_edge(clk)) then
	
	case C1 is
    
    WHEN 0 => D <="0000";
    WHEN 1 => D <="0001";
    WHEN 2 => D <="0010";
    WHEN 3 => D <="0011";
    WHEN 4 => D <="0100";
    WHEN 5 => D <="0101";
    WHEN 6 => D <="0110";
    WHEN 7 => D <="0111";
    WHEN 8 => D <="1000";
    WHEN 9 => D <="1001";
    WHEN others => D<="1111";
    
    end case;
    
    case C2 is
        
    WHEN 0 => C <="0000";
    WHEN 1 => C <="0001";
    WHEN 2 => C <="0010";
    WHEN 3 => C <="0011";
    WHEN 4 => C <="0100";
    WHEN 5 => C <="0101";
    WHEN 6 => C <="0110";
    WHEN 7 => C <="0111";
    WHEN 8 => C <="1000";
    WHEN 9 => C <="1001";
    WHEN others => C<="1111";
    
    end case;
        
        
    case C3 is
        
    WHEN 0 => B <="0000";
    WHEN 1 => B <="0001";
    WHEN 2 => B <="0010";
    WHEN 3 => B <="0011";
    WHEN 4 => B <="0100";
    WHEN 5 => B <="0101";
    WHEN others => B<="1111";
    
    end case;
            
            
    
    case C4 is
        
    WHEN 0 => A <="0000";
    WHEN 1 => A <="0001";
    WHEN 2 => A <="0010";
    WHEN 3 => A <="0011";
    WHEN 4 => A <="0100";
    WHEN 5 => A <="0101";
    WHEN 6 => A <="0110";
    WHEN 7 => A <="0111";
    WHEN 8 => A <="1000";
    WHEN 9 => A <="1001";
    WHEN others => A<="1111";
    
    end case;
	
	


	
end if;



end process;


end Behavioral;




