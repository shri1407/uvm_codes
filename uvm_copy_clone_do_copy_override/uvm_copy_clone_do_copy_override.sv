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
  	
  	virtual function void do_copy(uvm_object rhs);
   		
  		packet ex;
    
      	`uvm_info("packet","inside packet do_copy",UVM_LOW)
      
    	if(!($cast(ex,rhs)))
     	`uvm_error(get_type_name(),"casting failed.")
        
     	super.copy(rhs);
     	addr=ex.addr;
      	sa	=ex.sa;
      	da	=ex.da;
      	data=ex.data;
      	data1=ex.data1;
      	data2=ex.data2;
  	endfunction
	
endclass

class ext_packet extends packet;
  
  rand int check;
  
  constraint check_c{
    check inside {[1:20]};
  }
  
  `uvm_object_utils_begin(ext_packet)
  `uvm_field_int(check,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name="ext_packet");
    super.new(name);
  endfunction
  
  virtual function void do_copy(uvm_object rhs);
    ext_packet ex;
    
    `uvm_info("ext_packet","inside ext_packet do_copy",UVM_LOW)
    if(!($cast(ex,rhs)))begin
      `uvm_fatal(get_type_name(),"casting failed.")
    end
    //super.do_copy(rhs);
    check=ex.check+5;
  endfunction
         
endclass

program test;
	
	initial begin
		packet pkt1,pkt2,pkt3;
      	ext_packet ex_pkt,ex_pkt1;
		
		pkt1=packet::type_id::create("pkt1");
		void'(pkt1.randomize());
		pkt1.print();
		pkt1.convert2string();
      
      	//Copy
      	pkt2=packet::type_id::create("pkt2");
      	pkt2.copy(pkt1);
      	pkt2.print();
      
      	//do_copy override
      	ex_pkt=ext_packet::type_id::create("ex_pkt");
      	ex_pkt1=ext_packet::type_id::create("ex_pkt1");
      	void'(ex_pkt1.randomize());
      	void'(ex_pkt.randomize());
      	ex_pkt.print();
      	ex_pkt1.print();
      	//pkt1=ex_pkt1;
      	ex_pkt.copy(ex_pkt1);
      	ex_pkt.print();
      
		
	end
endprogram
