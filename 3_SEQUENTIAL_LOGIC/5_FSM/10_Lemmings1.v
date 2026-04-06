module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

     parameter left=0, right=1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case (state)
            left: next_state = bump_left ? right : left;
            right : next_state = bump_right? left : right;
            default : next_state = left;
        endcase
        
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state <= left;
        else
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == left);
    assign walk_right = (state == right);

endmodule
