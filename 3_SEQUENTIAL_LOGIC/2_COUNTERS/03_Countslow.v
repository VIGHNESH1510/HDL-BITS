module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    always@(posedge clk )
        begin
            if(reset || (q==9 && slowena==1))
                q <= 0;
            else
                begin
                    if(!slowena)
                        q <= q;
                    else
                        q <= q+1;
                end
        end

endmodule
