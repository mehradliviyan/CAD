	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
#	set run_time			"1 us"
	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addSub.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/combStage.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUL.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX2x1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX4x1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/seqStage.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/top.v
	# vlog 	+acc -incr -source  +define+SIM 	$inc_path/implementation_option.vh
		
	# vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	