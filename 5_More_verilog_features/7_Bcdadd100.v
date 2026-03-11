module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [400:0] carry;
    assign carry[0] = cin;
    assign cout =carry[400];
    genvar i;
    generate 
        for(i=0; i<400 ;i=i+4)
            begin: bcd
                bcd_fadd ins(a[i+3:i],b[i+3:i],carry[i],carry[i+4],sum[i+3:i]);
            end
    endgenerate

endmodule
