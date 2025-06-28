class router_transaction extends uvm_sequence_item;
  rand bit [7:0] header;
  rand bit [7:0] payload[];
  bit[7:0] payload_data;
  rand bit[5:0] payload_length;
  bit [7:0] parity;
  rand bit [1:0] addr;

  `uvm_object_utils(router_transaction)

  function new(string name="router_transaction");
    super.new(name);
  endfunction

  function void compute_parity();
    parity = header;
    foreach(payload[i]) parity ^= payload[i];
  endfunction
  
  constraint addr_c {addr < 3;}
  constraint payload_length_c {payload_length < 9;payload_length > 5;}
endclass
