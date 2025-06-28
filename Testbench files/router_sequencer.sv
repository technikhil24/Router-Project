class router_sequencer extends uvm_sequencer #(router_transaction);
  `uvm_component_utils(router_sequencer)

  virtual router_if vif;

  function new(string name = "router_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
endclass
