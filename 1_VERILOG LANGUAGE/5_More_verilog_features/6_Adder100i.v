module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    wire [100:0] carry;
    assign carry[0] = cin;
    assign cout = carry[100:1];
    genvar i;
    generate
        for(i=0;i<100;i=i+1) 
        begin: full_add
            fa ins(a[i],b[i],carry[i],sum[i],carry[i+1]);
        end
    endgenerate
endmodule

module fa(input a,b,cin,output sum,carry);
    assign {carry,sum} = a+b+cin;
endmodule
