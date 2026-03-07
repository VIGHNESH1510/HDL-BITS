module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire c1,c2,c3;
    wire [15:0] sum1,sum2;
    add16 ins1(  .a(a[15:0]), .b(b[15:0]),.cin(1'b0), .sum(sum[15:0]),.cout(c1) );
    add16 ins2(  .a(a[31:16]), .b(b[31:16]),.cin(1'b1), .sum(sum1),.cout(c2) );
    add16 ins3(  .a(a[31:16]), .b(b[31:16]),.cin(1'b0), .sum(sum2),.cout(c3) );
    assign sum[31:16]= c1? sum1:sum2;
    
    

endmodule
