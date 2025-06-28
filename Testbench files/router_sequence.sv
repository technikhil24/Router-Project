class router_sequence extends uvm_sequence#(router_transaction);
  router_transaction txn;
  `uvm_object_utils(router_sequence)
  //virtual router_if  vif;
  
  function new(string name="router_sequence");
    super.new(name);
  endfunction
  

  
  virtual task body();
    repeat (2) begin
      txn = router_transaction::type_id::create("txn");
      assert(txn.randomize());
      txn.compute_parity();
      start_item(txn);
      finish_item(txn);
	  //`uvm_do(txn);
      // Small pause
     //repeat(5) @(posedge vif.clk);
    end
  endtask
endclass
