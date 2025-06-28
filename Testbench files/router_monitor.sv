class router_monitor extends uvm_component;
  virtual router_if vif;

  uvm_analysis_port#(router_transaction) ap;

  `uvm_component_utils(router_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual router_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    router_transaction txn = router_transaction::type_id::create("mon_txn");


    //@(posedge vif.clk);
    while (vif.packet_valid !== 1) @(posedge vif.clk); // wait for packet
      
      txn.payload_data = vif.datain;

    forever begin
      @(posedge vif.clk);
      //$display("M_dataout0 = %0b",vif.data_out_0);
      //$display("M_dataout1 = %0b",vif.data_out_1);
      //$display("M_dataout2 = %0b",vif.data_out_2);
      
      if (vif.vldout_0 || vif.vldout_1 || vif.vldout_2) begin
        // reconstruct header or payload as needed; here we only capture datain
        txn.header        = vif.datain;  
        txn.payload = new[0];            // empty, or extend if needed
        txn.parity = 0;                  // unused
        ap.write(txn);
      end
    end
  endtask
endclass
