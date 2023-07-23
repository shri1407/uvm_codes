import uvm_pkg::*;
`include "uvm_macros.svh"
`include "compA.sv"
`include "compB.sv"
`include "compC.sv"
`include "env.sv"
`include "test.sv"

module top;
  initial begin
    run_test();
  end
endmodule
