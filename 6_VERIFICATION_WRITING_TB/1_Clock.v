module top_module ();
reg clk=0;
    dut d(clk);
    always #5 clk = ~clk;
endmodule
