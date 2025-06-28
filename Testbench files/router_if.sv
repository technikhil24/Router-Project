interface router_if(input logic clk);
  logic resetn;
  logic read_enb_0, read_enb_1, read_enb_2;
  logic packet_valid;
  logic [7:0] datain;
  logic [7:0] data_out_0, data_out_1, data_out_2;
  logic vldout_0, vldout_1, vldout_2;
  logic err, busy;
  logic detect_add,lfd_state,ld_state;
endinterface
