module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter SNT=0,WNT=1,WT=2,ST=3;
    reg [1:0] next;
    always @(posedge clk or posedge areset)
        begin
            if(areset)
                state <=  WNT;
            else
                state <= next;
        end
    always @(*)
        begin
            case(state)
                //SNT: next = ((train_taken & train_valid)) ? WNT : (train_valid ? SNT: WNT);
                SNT: next = (!train_valid | (train_valid & !train_taken)) ? SNT : WNT;
                WNT: next = (train_taken & train_valid) ? WT : (!train_valid ? WNT : SNT);
                WT: next = (train_taken &  train_valid) ? ST : (!train_valid ? WT : WNT);
                ST: next = ((train_taken & train_valid) | !train_valid) ? ST : WT;
            endcase
        end

endmodule
