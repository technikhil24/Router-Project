class router_scoreboard extends uvm_component;
  uvm_analysis_imp#(router_transaction, router_scoreboard) imp;

  `uvm_component_utils(router_scoreboard)

  function new(string name = "router_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    imp = new("imp", this);
  endfunction
  
function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  virtual function void write(router_transaction t);
    `uvm_info("SCOREBOARD", $sformatf("Monitored header = %0h", t.header), UVM_LOW)
    
  endfunction
endclass
