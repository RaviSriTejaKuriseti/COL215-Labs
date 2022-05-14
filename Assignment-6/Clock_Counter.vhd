

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity Clock_Counter is
  port (Clock: in STD_LOGIC;
        P    : in STD_LOGIC;
        Q    : in STD_LOGIC;
        decisec : inout integer;
		sec : inout integer;
		tensec : inout integer;
		min : inout integer
        );
end;


architecture RTL of Clock_Counter is
signal clock_ticks: integer:= 1;

--decisec<=0;
--sec<=0;
--signal tensec : integer := 0;
--signal min : integer := 0;



  
begin

	  process (Clock)
	  
	  begin   
	   
	   
		if (rising_edge(Clock)) then
		   if(Q='1') then
		    decisec<=0;
		    sec<=0;
		    tensec<=0;
		    min<=0;
		   
		   else
		   
               if(P='0') then
                if(clock_ticks=10000000) then
                    clock_ticks <=0 ;
                    if(decisec=9) then
                      decisec<=0;          
                      if(sec=9)  then 
                        sec<=0;
                        if(tensec=5) then
                          tensec<=0;
                          if(min=9) then
                            min <=0;
                            decisec<=0;
                            sec<=0;
                            tensec<=0;
                          else
                            min<= min+1;
                            end if;
                        else
                          tensec<= tensec+1;
                          end if;
                       
                        
                      
                      else
                        sec <= sec+1;
                        end if;
                        
                          
                    else
                      decisec <= decisec+1;
                      end if; 
                      
				
                else
                    clock_ticks <= clock_ticks + 1;
                    end if;
                end if;
                
            end if;
			
		end if;
			
		
	end process; 

end;



