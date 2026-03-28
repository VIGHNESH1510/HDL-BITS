module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (state)
            B: next = in ? B : A;
            A: next = in ? A : B;
            default: next = B;
        endcase
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(areset) begin
            state <= B;
        end
        else begin
            state <= next;
        end
    end

    // Output logic
    assign out = (state == B) ? 1: 0;

endmodule
