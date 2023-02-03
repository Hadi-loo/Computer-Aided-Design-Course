	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"encoder_testbench"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"20 ms"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/consts.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter5.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter64.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg25.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC_func.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC_read_from_file.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC_write_to_file.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/parity_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/parity_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/parity.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity_read_from_file.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity_write_to_file.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permutaion.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute_read_file.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute_write_file.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate_func.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate_read_file.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate_write_file.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate_func.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate_read_from_file.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate_write_to_file.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate.v
		
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
	