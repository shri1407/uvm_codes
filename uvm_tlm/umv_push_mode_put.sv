
import uvm_pkg::*;


class packet extends uvm_sequence_item;
    `uvm_object_utils(packet)
rand bit [3:0] data;

    function new(string name="packet");
	super.new(name);
    endfunction

    virtual function string convert2string ();
    return ($sformatf("data=%0d",data));
    endfunction
endclass

class producer_seqr extends uvm_component;
	`uvm_component_utils(producer_seqr);
  	packet pkt;
	
	uvm_blocking_put_port#(packet,producer_seqr) seqr_put_port;
	
	function new(input string name="producer_seqr", uvm_component parent);
		super.new(name,parent);
		seqr_put_port=new("seqr_put_port",this);
	endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info("producer","Producer run phase started.", UVM_NONE);
    phase.raise_objection(this,"objection raised by producer.");
    repeat(5)begin
      pkt=packet::type_id::create("pkt",this);
      void'(pkt.randomize());
      //`uvm_info("producer",$sformatf("pkt.data=%0d",pkt.data),UVM_NONE)
      `uvm_info("producer",pkt.convert2string,UVM_NONE)
      seqr_put_port.put(pkt);
    end
    phase.drop_objection(this,"objection dropped by producer.");
  endtask
	
endclass

class consumer extends uvm_component;
	`uvm_component_utils(consumer);
	packet pkt;
	
  uvm_blocking_put_imp#(packet,consumer) consumer_put_port;
	
	function new(input string name="consumer", uvm_component parent);
		super.new(name,parent);
      consumer_put_port=new("consumer_put_port",this);
	endfunction
	  
  	task put(packet pkt);
      `uvm_info("consumer",pkt.convert2string,UVM_NONE)
  	endtask
endclass

class tlm_put_push_test extends uvm_test;
	`uvm_component_utils(tlm_put_push_test)
	
	consumer cnsm;
	producer_seqr producer;
	
	function new(input string name="tlm_put_push_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		cnsm=consumer::type_id::create("cnsm",this);
		producer=producer_seqr::type_id::create("producer",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		//cnsm.consumer_put_imp.connect(producer.seqr_put_port);
      producer.seqr_put_port.connect(cnsm.consumer_put_port);
	endfunction
	
endclass

program top;

	initial begin
		run_test();
	end
endprogram