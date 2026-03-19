module top_module (
    input clk,
    input d,
    output q
);
    reg neg,pos;
    always @(negedge clk)
        begin
            neg <= d;
        end
    always @(posedge clk)
        begin
            pos <= d;
        end
    
    assign q= clk?pos:neg;
    
endmodule
