module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    
    assign out = (~a|~b|c) & (c| ~d |~b) & (~c | d|~a) & (a|b|~c|~d);

endmodule
