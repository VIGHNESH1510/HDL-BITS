module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    localparam [2:0] A=0,B=1,C=2,D=3,E=4,F=5;
    reg [2:0] state, next;
    always @(posedge clk)
        begin
            if(reset)
                state <= A;
            else
                state <= next;
        end
    always @(*)
        begin
            case(state)
                A: next = !w ? A:B;
                B: next = !w ? D:C;
                C: next = !w ? D:E;
                D: next = !w ? A:F;
                E: next = !w ? D:E;
                F: next = !w ? D:C;
                default: next = A;
            endcase
        end
    assign z = (state == E || state == F);

endmodule
