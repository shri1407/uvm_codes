class compC extends uvm_component;
	`uvm_component_utils(compC)
	
	function new(string name="compC", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
  virtual function void build_phase(uvm_phase phase);
		`uvm_info("compC","BUILD PHASE started.",UVM_LOW);
	endfunction
	
  virtual function void connect_phase(uvm_phase phase);
		`uvm_info("compC","CONNECT PHASE started.",UVM_LOW);
	endfunction
	
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("compC","END OF ELABORATION PHASE started.",UVM_LOW);
	endfunction
	
  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("compC","START OF SIMULATION PHASE started.",UVM_LOW);
	endfunction
	
	virtual task pre_reset_phase(uvm_phase phase);
		`uvm_info("compC","PRE RESET PHASE started.",UVM_LOW)
	endtask
	
	virtual task post_reset_phase(uvm_phase phase);
		`uvm_info("compC","POST RESET PHASE started.",UVM_LOW)
	endtask
	
	virtual task pre_configure_phase(uvm_phase phase);
		`uvm_info("compC","PRE CONFIGURE PHASE started.",UVM_LOW)
	endtask
	
	virtual task post_configure_phase(uvm_phase phase);
		`uvm_info("compC","POST CONFIGURE PHASE started.",UVM_LOW)
	endtask
	
	virtual task pre_main_phase(uvm_phase phase);
		`uvm_info("compC","PRE MAIN PHASE started.",UVM_LOW)
	endtask
	
	virtual task post_main_phase(uvm_phase phase);
		`uvm_info("compC","POST MAIN PHASE started.",UVM_LOW)
	endtask
	
	virtual task pre_shutdown_phase(uvm_phase phase);
		`uvm_info("compC","PRE SHUTDOWN PHASE started.",UVM_LOW)
	endtask
	
	virtual task post_shutdown_phase(uvm_phase phase);
		`uvm_info("compC","POST SHUTDOWN PHASE started.",UVM_LOW)
	endtask
	
	virtual task reset_phase(uvm_phase phase);
		phase.raise_objection(this,"OBJECTION Is RAISED FROM RESET PHASE.");
		`uvm_info("compC","RESET PHASE started.",UVM_LOW)
		#5;
		`uvm_info("compC","RESET PHASE ended.",UVM_LOW)
		phase.drop_objection(this,"OBJECTION Is DROPPED FROM RESET PHASE.");
	endtask
	
	virtual task configure_phase(uvm_phase phase);
		phase.raise_objection(this,"OBJECTION Is RAISED FROM CONFIGURE PHASE.");
		`uvm_info("compC","CONFIGURE PHASE started.",UVM_LOW)
		#5;
		`uvm_info("compC","CONFIGURE PHASE ended.",UVM_LOW)
		phase.drop_objection(this,"OBJECTION Is DROPPED FROM CONFIGURE PHASE.");
	endtask
	
	virtual task main_phase(uvm_phase phase);
		phase.raise_objection(this,"OBJECTION Is RAISED FROM MAIN PHASE.");
		`uvm_info("compC","MAIN PHASE started.",UVM_LOW)
		#5;
		`uvm_info("compC","MAIN PHASE ended.",UVM_LOW)
		phase.drop_objection(this,"OBJECTION Is DROPPED FROM MAIN PHASE.");
	endtask
	
	virtual task shutdown_phase(uvm_phase phase);
		phase.raise_objection(this,"OBJECTION Is RAISED FROM SHUTDOWN PHASE.");
		`uvm_info("compC","SHUTDOWN PHASE started.",UVM_LOW)
		#5;
		`uvm_info("compC","SHUTDOWN PHASE ended.",UVM_LOW)
		phase.drop_objection(this,"OBJECTION Is DROPPED FROM SHUTDOWN PHASE.");
	endtask
	
	
endclass