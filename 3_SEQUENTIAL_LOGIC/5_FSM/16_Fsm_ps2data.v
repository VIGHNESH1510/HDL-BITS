module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
     parameter[1:0] first=0,second=1,third=2,finish=3;
    reg [1:0] state, next;
    reg [23:0]out_reg;
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
            if(reset) begin
                state <= first;
                out_reg <= 24'bx;
            end
            else begin
                state <= next;
                out_reg <= {out_reg[15:8],out_reg[7:0],in};
            end
        end
 
    // Output logic
    assign done = (state==finish);
    // New: Datapath to store incoming bytes.
    assign out_bytes = (state == finish) ? out_reg : 24'bx;

endmodule
