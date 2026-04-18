module top_module ();
	reg clk,reset,t;
    wire q=0;
    tff dut(clk,reset,t,q);
    always #5 clk = ~clk;
    initial begin
        reset =1; clk=0;
        t=0;
        #10 reset=0;
        #10 t=1;
    end
endmodule
