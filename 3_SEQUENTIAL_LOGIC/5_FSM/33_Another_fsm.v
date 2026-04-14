module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    localparam [3:0] A=0,F=1,det_1=2,det_10=3,det_101=4,G=5,temp=6,G_1=7,G_0=8;
    reg[3:0] state,next;
    always @(posedge clk)
        begin
            if(!resetn) begin 
                state <= A;
            end
            else begin
                state <= next;
                
            end
        end
    always @(*)
        begin
            case(state)
                A : next = ~resetn ? A:F;
                F: next = det_1;
                det_1: next = x ? det_10 : det_1;
                det_10: next = ~x ? det_101: det_10;
                det_101: next = x ? G: det_1;
                G: next = y ? G_1:temp;
                temp: next = y ? G_1: G_0;
                G_1: next = (~resetn) ? A: G_1;
                G_0: next = (~resetn) ? A: G_0;
                default: next =A;
            endcase
        end
    assign f = (state == F);
    assign g =(state == G_1) || (state == G) || (state == temp);
                

endmodule
