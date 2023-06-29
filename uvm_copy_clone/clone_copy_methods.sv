

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
	sa inside {[1:4]};
	da inside {[1:4]};
	addr inside {[0:15]};
	data inside {[10:500]};
	}
	
	function new(string name="packet");
		super.new(name);
	endfunction
	
	virtual function string convert2string();
		return $sformatf("sa=%0d, da=%0d, addr=%0d, data=%0d",sa,da,addr,data);
	endfunction
	
endclass

program test;
	
	initial begin
		packet pkt1,pkt2,pkt3;
		
		pkt1=packet::type_id::create("pkt1");
		void'(pkt1.randomize());
		pkt1.print();
		pkt1.convert2string();
      
      	//Copy
      	pkt2=packet::type_id::create("pkt2");
      	pkt2.copy(pkt1);
      	pkt2.print();
      
      
      	//cloning.
      	$cast(pkt3,pkt1.clone());
      	pkt3.print();
		
	end
endprogram