//edaplayground link : https://www.edaplayground.com/x/Ld8_
import uvm_pkg::*;
`include "uvm_macros.svh"

class packet extends uvm_sequence_item;

	rand logic [31:0] addr;
	rand logic [31:0] data,data1,data2;
	rand logic [7:0]  sa,da;

	`uvm_object_utils_begin(packet)
		`uvm_field_int(sa,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(da,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(addr,UVM_ALL_ON | UVM_HEX)
		`uvm_field_int(data,UVM_ALL_ON | UVM_HEX)
		`uvm_field_int(data1,UVM_ALL_ON | UVM_HEX)
		`uvm_field_int(data2,UVM_ALL_ON | UVM_HEX)
	`uvm_object_utils_end

	constraint packet_c {
	soft sa inside {[1:4]};
	soft da inside {[1:4]};
	soft addr inside {[0:15]};
	soft data inside {[10:500]};
	}
	
	function new(string name="packet");
		super.new(name);
	endfunction
	
	virtual function string convert2string();
		return $sformatf("sa=%0d, da=%0d, addr=%0d, data=%0d",sa,da,addr,data);
	endfunction
	
endclass

class ext_packet extends packet;
  
  `uvm_object_utils(ext_packet)
  
  	constraint packet_c {
	sa inside {[5:10]};
	da inside {[5:10]};
	soft addr inside {[0:15]};
	soft data inside {[10:500]};
	}
  
  function new(string name="ext_packet");
    super.new(name);
  endfunction
  
endclass

class factory_override extends uvm_test;
	`uvm_component_utils(factory_override)
	
	packet pkt1;
	
	function new(string name="factory_override",uvm_component parent=null);
		super.new(name,parent);
	endfunction
  
  virtual function void build_phase(uvm_phase phase);
    //`uvm_info("factory_override","BUILD PHASE started.", UVM_LOW)
    super.build_phase(phase);
    //set_type_override_by_type(packet::get_type(),ext_packet::get_type());
  endfunction
                              
  //function void end_of_elaboration_phase(uvm_phase);
  //    `uvm_info("factory_override","end_of_elaboration PHASE started.", UVM_LOW)
  //endfunction
	
	virtual task run_phase(uvm_phase phase);
    	uvm_factory factory = uvm_factory::get();
		`uvm_info("factory_override","RUN PHASE started", UVM_LOW)
      	pkt1=packet::type_id::create("pkt1");
      	void'(pkt1.randomize());
		phase.raise_objection(this,"objection is raised from RUN PHASE");
      	pkt1.print();
		set_type_override_by_type(packet::get_type(),ext_packet::get_type());
    	factory.print();
      	void'(pkt1.randomize());
		pkt1.print();
      phase.drop_objection(this,"Objection is dropped from RUN PHASE");
	endtask
endclass

program test;
	
	initial begin
		run_test();
	end
endprogram