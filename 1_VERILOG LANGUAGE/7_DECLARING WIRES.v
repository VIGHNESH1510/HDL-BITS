`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire a1,b1,c1;
    assign  a1=a&b;
    assign b1=c&d;
    assign c1= a1|b1;
    assign out=c1;
    assign out_n= ~c1;

endmodule
