# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Sat Jan 10 12:25:06 IST 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design counter

create_clock -name "clk" -period 0.005 -waveform {0.0 0.0025} [get_ports clk]
set_clock_transition 0.1 [get_clocks clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 0.001 [get_ports rst]
set_input_delay -clock [get_clocks clk] -add_delay 0.001 [get_ports clk]
set_output_delay -clock [get_clocks clk] -add_delay 0.001 [get_ports {out[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.001 [get_ports {out[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.001 [get_ports {out[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.001 [get_ports {out[3]}]
set_wire_load_mode "enclosed"
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb2]
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb1]
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb4]
