module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    localparam [2:0] A=1,B=2,C=3,D=4;
    reg[2:0] state, next;
    always @(posedge clk)
        begin
            if(!resetn)
                state <= A;
            else
                state <=next;
            
        end
    always @(*)
        begin
            case(state)
                A: begin
                    next =  r[1] ? B: (r[2] ? C :(r[3] ? D : A));
                    /*if(r1==1) next = B;
                    else if(r2==1) next = C;
                    else if(r3==1) next = D;
                    else next =A;*/
                end
                B: next = r[1] ? B : A;
                C: next = r[2] ? C : A;
                D: next = r[3] ? D : A;
                default: next =A;
            endcase
        end
    assign g[1] = (state == B);
    assign g[2] = (state == C);
    assign g[3] = (state == D);

endmodule
