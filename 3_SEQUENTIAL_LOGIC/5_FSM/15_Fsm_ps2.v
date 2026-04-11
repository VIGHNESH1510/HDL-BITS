module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    parameter[1:0] first=0,second=1,third=2,finish=3;
    reg [1:0] state, next;
    // State transition logic (combinational)
    always @(*)
        begin
            case(state)
                first: next = in[3] ? second: first;
                second: next = third;
                third: next = finish;
                finish: next = in[3] ? second:  first;
                default: next = first;
            endcase
        end

    // State flip-flops (sequential)
    always @(posedge clk)
        begin
            if(reset)
                state <= first;
            else
                state <= next;
        end
 
    // Output logic
    assign done = (state==finish);

endmodule
