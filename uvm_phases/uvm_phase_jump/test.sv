class uvm_test_phase extends uvm_test;
	`uvm_component_utils(uvm_test_phase)
	
	env test_env;
	bit [3:0] jump_count;
	
	function new(string name="uvm_test_phase",uvm_component parent);
		super.new(name,parent);
	endfunction
	
  function void build_phase(uvm_phase phase);
		`uvm_info("UVM_TEST_PHASE","UVM TEST BUILD PHASE started.",UVM_LOW)
      test_env=env::type_id::create("test_env",this);
	endfunction
	
	function void phase_ready_to_end(uvm_phase phase);
      super.phase_ready_to_end(phase);
		if(phase.get_name()=="main")begin
			if(jump_count<5)begin
				jump_count++;
				phase.jump(uvm_reset_phase::get());
				`uvm_info("UVM_TEST_PHASE",$sformatf("Jumped from phase(%s) -> to (reset_phase)",phase.get_name),UVM_NONE)
			end
		end
	endfunction
	
	function void phase_started(uvm_phase phase);
		`uvm_info("UVM_TEST_PHASE",$psprintf("Current phase %s started.",phase.get_name()),UVM_NONE)
		if(phase.get_name()=="reset")begin
			`uvm_info("UVM_TEST_PHASE",$psprintf("Reset iteration count %d",phase.get_run_count),UVM_NONE)
		end
	endfunction
	
	function void phase_ended(uvm_phase phase);
      if(phase.get_name()=="main")		`uvm_info("JUMP",$psprintf("**************************jump********************************"),UVM_NONE)
	endfunction
	
endclass