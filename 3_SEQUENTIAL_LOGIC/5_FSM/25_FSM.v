module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    localparam[2:0] s0=0,s1=1,s2=2,s3=3,s4=4;
    reg[2:0] state, next;
    always @(posedge clk)
        begin
            if(reset)
                state <= s0;
            else
                state <= next;
        end
    always @(*)
        begin
            case(state)
                s0: next = x ? s1: s0;
                s1: next = x ? s4: s1;
                s2: next = x ? s1: s2;
                s3: next = x ? s2: s1;
                s4: next = x ? s4: s3;
                default: next =s0;
            endcase
        end
    assign z = (state == s4 || state == s3);

endmodule
