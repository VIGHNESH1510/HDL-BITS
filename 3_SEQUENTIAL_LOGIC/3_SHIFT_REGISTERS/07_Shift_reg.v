module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg [2:0] q;
    always @(posedge clk)
        begin
            if(!resetn)
                begin
                  out <=0;
                  q <= 3'd0;
                end
            else
                begin
                    out <= q[0];
                    q <= {in,q[2:1]};
                end
        end

endmodule
