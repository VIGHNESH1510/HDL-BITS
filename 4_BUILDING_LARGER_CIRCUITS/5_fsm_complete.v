module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    localparam [3:0]s=0,s1=1,s11=2,s110=3,B0=4,B1=5,B2=6,B3=7,count=8,wait_=9;
    reg[3:0] state,next;
    always @(posedge clk)
        begin
            if(reset)
                state <=s;
            else
                state <= next;
        end
    always @(*)
        begin
            case(state)
                s: next = data ? s1: s;
                s1: next = data ? s11: s;
                s11: next = data ? s11: s110;
                s110: next = data ? B0: s;
                B0: next = B1;
                B1: next = B2;
                B2: next = B3;
                B3: next = count;
                count : next = done_counting ? wait_: count;
                wait_ : next =ack ? s: wait_;
            endcase
        end
    assign shift_ena = (state == B0 || state == B1 || state == B2 || state == B3);
    assign counting = (state == count);
    assign done = (state == wait_);

endmodule
