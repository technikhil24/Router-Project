class router_agent extends uvm_agent;

  `uvm_component_utils(router_agent)

  router_driver     drv;
  router_monitor    mon;
  router_sequencer  sequencer; // Use custom sequencer

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	if(get_is_active == UVM_ACTIVE) begin
      drv       = router_driver::type_id::create("drv", this);
      sequencer = router_sequencer::type_id::create("sequencer", this);
    end
    mon       = router_monitor::type_id::create("mon", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    //super.connect_phase(phase);
    if(get_is_active == UVM_ACTIVE) begin 
     drv.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction

endclass
