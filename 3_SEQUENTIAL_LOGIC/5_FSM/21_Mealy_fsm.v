module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    reg [1:0]state,next;
    localparam [1:0] s0=0,s1=1,s2=2;
    always @(posedge clk or negedge aresetn)
        begin
            if(!aresetn)
                state <=s0;
            else
                state <= next;
        end
    always @(*)
        begin
            case(state)
                s0: next = x ? s1: s0;
                s1: next = x ? s1:s2;
                s2: next = x ? s1: s0;
            endcase
        end
    assign z = (state ==s2 && x);

endmodule
