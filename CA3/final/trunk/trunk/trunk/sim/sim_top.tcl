	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"tb"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
#	set run_time			"1 us"
	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/bitMul.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FA.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/leftShiftReg.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/modules.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUL.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Register.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rightShiftReg.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/top.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/up_down_cnt.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/XOR.v

	
	# vlog 	+acc -incr -source  +define+SIM 	$inc_path/implementation_option.vh
		
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
	