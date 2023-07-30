// or browse Examples
import uvm_pkg::*;

class packet extends uvm_sequence_item;
	`uvm_object_utils(packet)
	rand bit [7:0] data;
	
  function new(input string name="packet");
		super.new(name);
	endfunction
	
	virtual function string covert2string();
      return ($sformatf("data=%0d",data));
	endfunction
	
endclass

class producer_seqr extends uvm_component;
	`uvm_component_utils(producer_seqr);
	
	uvm_blocking_get_imp#(packet,producer_seqr) seqr_get_imp;
	
	function new(input string name="producer_seqr", uvm_component parent);
		super.new(name,parent);
		seqr_get_imp=new("seqr_get_imp",this);
	endfunction
	
	task get(output packet pkt);
	pkt=packet::type_id::create("pkt",this);
	void'(pkt.randomize());
	endtask
endclass

class consumer extends uvm_component;
	`uvm_component_utils(consumer);
	packet pkt;
	
	uvm_blocking_get_port#(packet,consumer) consumer_get_port;
	
	function new(input string name="consumer", uvm_component parent);
		super.new(name,parent);
		consumer_get_port=new("consumer_get_port",this);
	endfunction
	
	task run_phase(uvm_phase phase);
		`uvm_info("consumer","Starting Run phase.", UVM_NONE)
      phase.raise_objection(this,"OBJECTION IS RAISED FROM CONSUMER.");
		repeat(5)begin
		consumer_get_port.get(pkt);
		`uvm_info("consumer",pkt.covert2string,UVM_NONE)
		end
      phase.drop_objection(this,"OBJECTION IS DROPPED FROM CONSUMER.");
	endtask
endclass

class tlm_get_pull_test extends uvm_test;
	`uvm_component_utils(tlm_get_pull_test)
	
	consumer cnsm;
	producer_seqr producer;
	
	function new(input string name="tlm_get_pull_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		cnsm=consumer::type_id::create("cnsm",this);
		producer=producer_seqr::type_id::create("producer",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		cnsm.consumer_get_port.connect(producer.seqr_get_imp);
	endfunction
	
endclass

program top;

	initial begin
		run_test();
	end
endprogram
