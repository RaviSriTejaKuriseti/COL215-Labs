## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 


##7 segment display
set_property PACKAGE_PIN W7 [get_ports {Z[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Z[0]}]
set_property PACKAGE_PIN W6 [get_ports {Z[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Z[1]}]
set_property PACKAGE_PIN U8 [get_ports {Z[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Z[2]}]
set_property PACKAGE_PIN V8 [get_ports {Z[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Z[3]}]
set_property PACKAGE_PIN U5 [get_ports {Z[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Z[4]}]
set_property PACKAGE_PIN V5 [get_ports {Z[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Z[5]}]
set_property PACKAGE_PIN U7 [get_ports {Z[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Z[6]}]


set_property PACKAGE_PIN U2 [get_ports {anode[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[3]}]
set_property PACKAGE_PIN U4 [get_ports {anode[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[2]}]
set_property PACKAGE_PIN V4 [get_ports {anode[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[1]}]
set_property PACKAGE_PIN W4 [get_ports {anode[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[0]}]


##Buttons

set_property PACKAGE_PIN U18 [get_ports button_in[0]]						
   set_property IOSTANDARD LVCMOS33 [get_ports button_in[0]]
set_property PACKAGE_PIN T18 [get_ports button_in[1]]                        
    set_property IOSTANDARD LVCMOS33 [get_ports button_in[1]]
	
	
##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports rx_in]						
	set_property IOSTANDARD LVCMOS33 [get_ports rx_in]
set_property PACKAGE_PIN A18 [get_ports tx_out]						
	set_property IOSTANDARD LVCMOS33 [get_ports tx_out]

 


