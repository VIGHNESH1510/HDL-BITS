module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    localparam [2:0] s0=0,s1=1,s2=2,s3=3,s4=4;
    assign z = (y == s3 || y==s4);
    //assign Y0 = ((~x && (y==s1 || y==s3 || y==s4)) || (x && (y==s0 || y==s2)) );
    assign Y0 = (~x & (y[0] | y[2])) | (x & ~y[2] & ~y[0]);

endmodule
