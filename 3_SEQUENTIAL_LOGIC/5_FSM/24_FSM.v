module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    localparam A=0,B=1;
    reg state , next;
    reg [1:0]count,out;
    always @(posedge clk)
        begin
            if(reset) begin
                state <= A;
                count <=0;
                out <=0;
                z<=0;
            end
            else begin
                state <= next;
                z<=0;
                if(state == B) begin
                    count <= count +1;
                    if(count == 2) begin
                        z <= (out + w == 2);
                        count <=0;
                        out <=0;
                    end
                    else begin
                        if(w==1)
                            out<= out+1;
                    end
                end
            end
        end
    always @(*)
        begin
            case(state)
                A: next = s ? B : A;
                B: begin
                    next = B;
                end
            endcase
                
        end
   // assign z = ( count ==2 && out ==1);

endmodule
