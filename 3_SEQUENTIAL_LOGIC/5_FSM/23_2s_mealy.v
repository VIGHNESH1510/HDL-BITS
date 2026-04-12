module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    localparam s0=0,s1=1;
    reg state,next;
    always @(posedge clk or posedge areset)
        begin
            if(areset)
                state <=  s0;
            else
                state <= next;
        end
    always @(*)
        begin
            case(state)
                s0: begin
                    next = x ? s1: s0;
                    z = x ? 1'b1:1'b0;
                end
                s1: begin 
                    next = s1;
                    z= x ? 1'b0:1'b1;
                    
                end
                default: begin 
                    next =s0;
                    z=0;
                end
            endcase
        end
endmodule
