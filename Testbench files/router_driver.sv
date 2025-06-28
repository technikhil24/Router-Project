class router_driver extends uvm_driver#(router_transaction);
  virtual router_if vif;

  integer i;
  
  `uvm_component_utils(router_driver)

  function new(string name = "router_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual router_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    router_transaction txn;
    vif.resetn = 1;
    //wait(!vif.busy)
    forever begin
      // Drive header
      @(negedge vif.clk);
      seq_item_port.get_next_item(txn);
      vif.packet_valid = 1;
      vif.detect_add = 1;
      vif.lfd_state = 1;
      //$display("addr = %0h",txn.addr);
      //$display("len = %0h",txn.payload_length);
      txn.header = {txn.payload_length,txn.addr};
      //$display("header = %0b",txn.header);
      vif.datain       = txn.header;
      // Drive payload
      
      @(negedge vif.clk);
      vif.lfd_state = 0;
      vif.detect_add = 0;
      vif.ld_state = 1;
      for (i = 0; i<txn.payload_length; i = i+ 1)
        begin
            //vif.packet_valid = 1;
          //wait(!vif.busy)
			txn.payload_data={$random}%256;
          	$display("data = %0b",txn.payload_data);
			vif.datain=txn.payload_data;						
        end
      // Drive parity and deassert valid
      
      @(negedge vif.clk);
      vif.packet_valid = 0;
      vif.ld_state = 0;
      txn.compute_parity();
      vif.datain = txn.parity;
 	  
      seq_item_port.item_done();
      //repeat(30);
    end
  endtask
endclass
    
