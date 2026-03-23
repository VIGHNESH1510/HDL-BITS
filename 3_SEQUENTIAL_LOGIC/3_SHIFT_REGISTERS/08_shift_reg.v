module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    genvar i;
    generate
        for(i=3; i>=0; i=i-1)
            begin: SR
                MUXDFF(.clk(KEY[0]),.E(KEY[1]),.L(KEY[2]),.A((i==3)?KEY[3]:LEDR[i+1]),.B(LEDR[i]),.R(SW[i]),.Q(LEDR[i]));
            end
    endgenerate

endmodule

module MUXDFF (input E,L,A,B,clk,R,output Q);
    always @(posedge clk)
        Q <= L ? R:(E ? A:B);
endmodule
