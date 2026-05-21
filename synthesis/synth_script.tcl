set_attribute init_lib_search_path /home/vlsi4/Downloads/scl_pdk/stdlib/fs120/liberty/lib_flow_ss
set_attribute library tsl18fs120_scl_ss.lib
set_attribute init_hdl_search_path /home/vlsi4/Desktop/Saptarshi_designs/counter/simulation

set_attribute information_level 6

set myFiles [list counter.v] ;	# All your HDL files
set basename counter ;		# name of top level module
set myClk clk ;				# clock name
set myPeriod_ps 5;			# Clock period in ps
set myInDelay_ns 1 ;			# delay from clock to inputs valid
set myOutDelay_ns 1 ;		# delay from clock to output valid
set runname synth_report ;	# name appended to output files

# Analyze and Elaborate the HDL files
read_hdl ${myFiles}
elaborate ${basename}

# Apply Constraints and generate clocks
set clock [define_clock -period ${myPeriod_ps} -name ${myClk} [clock_ports]]
external_delay -input $myInDelay_ns -clock ${myClk} [find / -port ports_in/*]
external_delay -output $myOutDelay_ns -clock ${myClk} [find / -port ports_out/*]

# Sets transition to default values for Synopsys SDC format, fall/rise 400ps

dc::set_clock_transition 0.1 $myClk

# check that the design is OK so far
check_design -unresolved
report timing -lint

#Setting Synthesis Effort Levels
set_attribute syn_generic_effort high
set_attribute syn_map_effort high
set_attribute syn_opt_effort high

# Synthesize the design to the target library
#synthesize -to_mapped
syn_generic
syn_map
syn_opt

# Write Files
write_hdl > counter_netlist.v
write_sdc > counter.sdc

# Generate Reports
report_timing > counter_timing.rep # Timing Report
report_gates > counter_area.rep # Area Report
report_power > counter_power.rep # Power Report
