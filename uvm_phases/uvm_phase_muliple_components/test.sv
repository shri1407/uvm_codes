class env extends uvm_env;
	`uvm_component_utils(env)
	compA a_comp;
	compB b_comp;
	compC c_comp;	
	
  function new(string name="env",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("ENV","BUILD PHASE Started.",UVM_LOW)
      a_comp=compA::type_id::create("a_comp",this);
      b_comp=compB::type_id::create("b_comp",this);
      c_comp=compC::type_id::create("c_comp",this);
	endfunction
endclass