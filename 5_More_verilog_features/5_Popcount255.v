module top_module( 
    input [254:0] in,
    output [7:0] out );
    always @(*)
        begin
            out = 0;
            for(integer i=0;i<$bits(in);i=i+1)
                out = in[i] ? out+1:out;
        end
endmodule
