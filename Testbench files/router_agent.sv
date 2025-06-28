`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "router_if.sv"
`include "router_test.sv"

module testbench;
  
  bit clk;
  logic resetn;
  always #2 clk = ~clk;
  initial begin
    clk = 0;
    resetn = 0;
    #5; 
    resetn = 1;
  end
    // Instantiate the interface
  router_if i_vif(clk);
  
  // DUT
  router_top dut (
    .clk          (i_vif.clk),
    .resetn       (i_vif.resetn),
    .read_enb_0   (i_vif.read_enb_0),
    .read_enb_1   (i_vif.read_enb_1),
    .read_enb_2   (i_vif.read_enb_2),
    .packet_valid (i_vif.packet_valid),
    .datain       (i_vif.datain),
    .detect_add   (i_vif.detect_add),
    .lfd_state 	  (i_vif.lfd_state),
    .ld_state     (i_vif.ld_state),
    .data_out_0   (i_vif.data_out_0),
    .data_out_1   (i_vif.data_out_1),
    .data_out_2   (i_vif.data_out_2),
    .vldout_0     (i_vif.vldout_0),
    .vldout_1     (i_vif.vldout_1),
    .vldout_2     (i_vif.vldout_2),
    .err          (i_vif.err),
    .busy         (i_vif.busy)
  );





  initial begin
    // Make the virtual interface available to all uvm components
    uvm_config_db#(virtual router_if)::set(null, "env.agent.drv", "vif", i_vif);
    uvm_config_db#(virtual router_if)::set(null, "env.agent.mon", "vif", i_vif);
    uvm_config_db #(virtual router_if)::set(null, "*", "vif", i_vif);
    $dumpfile("dump.vcd");
    $dumpvars();
    $display("entering1");
    run_test("router_test");
  end
endmodule
