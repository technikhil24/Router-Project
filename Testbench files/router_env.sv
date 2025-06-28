class router_env extends uvm_env;

  `uvm_component_utils(router_env)

  router_agent       agent;
  router_scoreboard  sb;
  //virtual router_if  vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    agent = router_agent::type_id::create("agent", this);
    sb    = router_scoreboard::type_id::create("sb", this);

    //if (!uvm_config_db #(virtual router_if)::get(this, "", "vif", vif)) begin
     // `uvm_fatal("VIF", "Failed to get virtual interface from config DB")
  //  end
  endfunction

  function void connect_phase(uvm_phase phase);
    //super.connect_phase(phase);

    agent.mon.ap.connect(sb.imp);
    //agent.sequencer.vif = this.vif;
  endfunction

endclass
