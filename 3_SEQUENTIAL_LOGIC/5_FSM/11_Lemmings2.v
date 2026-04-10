module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    reg [1:0]state,next;
    parameter [1:0] left=0,right=1,left_gnd=2,right_gnd=3;
    always @(posedge clk or posedge areset)
        begin
            if(areset)
                state <= left;
            else
                state <= next;
        end
    always @(*)
        begin
            case(state)
                0: next = !ground ? left_gnd :(bump_left ? right : left);
                1: next = !ground ? right_gnd :(bump_right ? left : right);
                2: next = !ground ? left_gnd : left;
                3: next = !ground ? right_gnd : right;
                default : next = left;
            endcase
        end
    assign walk_left = (state == left);
    assign walk_right = (state == right);
    assign aaah = (state == left_gnd || state == right_gnd);
    

endmodule
