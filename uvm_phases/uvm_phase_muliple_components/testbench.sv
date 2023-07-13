module tb;
import uvm_pkg::*;
`include "A_comp.sv"
`include "B_comp.sv"
`include "C_comp.sv"
`include "environment.sv"
`include "test.sv"

initial begin
    run_test();
 $display("\n********** [tb] @%0t run_test finished %m *********** \n",$time);
end
endmodule
