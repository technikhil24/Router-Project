`include "router_transaction.sv"
`include "router_sequence.sv"
`include "router_sequencer.sv"
`include "router_driver.sv"
`include "router_monitor.sv"
`include "router_scoreboard.sv"
`include "router_agent.sv"
`include "router_env.sv"

class router_test extends uvm_test;
  
  router_env       env;
  router_sequence  seq;
  
  `uvm_component_utils(router_test)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    $display("entering build phase");
    super.build_phase(phase);
    env = router_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    $display("entering run phase 1");
    phase.raise_objection(this);
    seq = router_sequence::type_id::create("seq");
    //seq.vif = env.agent.sequencer.vif;
    //seq.start(env.agent.sequencer);
    $display("entering run phase 2");
    repeat(10) begin 
      #5; seq.start(env.agent.sequencer);
    end
    $display("entering run phase 3");
    #1000ns;
    phase.drop_objection(this);
    $display("entering run phase 4");
    `uvm_info(get_type_name, "End of testcase", UVM_LOW);
    $finish;
  endtask
endclass
