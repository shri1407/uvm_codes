class compA extends uvm_component;
	`uvm_component_utils(compA)
	
	function new(string name="compA", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
  virtual function void build_phase(uvm_phase phase);
		`uvm_info("compA","BUILD PHASE started.",UVM_LOW);
	endfunction
	
  virtual function void connect_phase(uvm_phase phase);
		`uvm_info("compA","CONNECT PHASE started.",UVM_LOW);
	endfunction
	
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("compA","END OF ELABORATION started.",UVM_LOW);
	endfunction
	
  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("compA","START OF SIMULATION started.",UVM_LOW);
	endfunction
	
	virtual task pre_reset_phase(uvm_phase phase);
		`uvm_info("compA","PRE RESET PHASE started.",UVM_LOW)
	endtask
	
	virtual task post_reset_phase(uvm_phase phase);
		`uvm_info("compA","POST RESET PHASE started.",UVM_LOW)
	endtask
	
	virtual task pre_configure_phase(uvm_phase phase);
		`uvm_info("compA","PRE CONFIGURE PHASE started.",UVM_LOW)
	endtask
	
	virtual task post_configure_phase(uvm_phase phase);
		`uvm_info("compA","POST CONFIGURE PHASE started.",UVM_LOW)
	endtask
	
	virtual task pre_main_phase(uvm_phase phase);
		`uvm_info("compA","PRE MAIN PHASE started.",UVM_LOW)
	endtask
	
	virtual task post_main_phase(uvm_phase phase);
		`uvm_info("compA","POST MAIN PHASE started.",UVM_LOW)
	endtask
	
	virtual task pre_shutdown_phase(uvm_phase phase);
		`uvm_info("compA","PRE SHUTDOWN PHASE started.",UVM_LOW)
	endtask
	
	virtual task post_shutdown_phase(uvm_phase phase);
		`uvm_info("compA","POST SHUTDOWN PHASE started.",UVM_LOW)
	endtask
	
	virtual task reset_phase(uvm_phase phase);
		phase.raise_objection(this,"OBJECTION Is RAISED FROM RESET PHASE.");
		`uvm_info("compA","RESET PHASE started.",UVM_LOW)
		#5;
		`uvm_info("compA","RESET PHASE ended.",UVM_LOW)
		phase.drop_objection(this,"OBJECTION Is DROPPED FROM RESET PHASE.");
	endtask
	
	virtual task configure_phase(uvm_phase phase);
		phase.raise_objection(this,"OBJECTION Is RAISED FROM CONFIGURE PHASE.");
		`uvm_info("compA","CONFIGURE PHASE started.",UVM_LOW)
		#5;
		`uvm_info("compA","CONFIGURE PHASE ended.",UVM_LOW)
		phase.drop_objection(this,"OBJECTION Is DROPPED FROM CONFIGURE PHASE.");
	endtask
	
	virtual task main_phase(uvm_phase phase);
		phase.raise_objection(this,"OBJECTION Is RAISED FROM MAIN PHASE.");
		`uvm_info("compA","MAIN PHASE started.",UVM_LOW)
		#5;
		`uvm_info("compA","MAIN PHASE ended.",UVM_LOW)
		phase.drop_objection(this,"OBJECTION Is DROPPED FROM MAIN PHASE.");
	endtask
	
	virtual task shutdown_phase(uvm_phase phase);
		phase.raise_objection(this,"OBJECTION Is RAISED FROM SHUTDOWN PHASE.");
		`uvm_info("compA","SHUTDOWN PHASE started.",UVM_LOW)
		#5;
		`uvm_info("compA","SHUTDOWN PHASE ended.",UVM_LOW)
		phase.drop_objection(this,"OBJECTION Is DROPPED FROM SHUTDOWN PHASE.");
	endtask
	
	
endclass