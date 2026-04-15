module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    localparam [2:0] s0=0,s1=1,s2=2,s3=3,s4=4;
    reg[2:0] state,next;
	always @(posedge clk)
        begin
            if(reset)
                state <=s1;
            else
                state <=next;
        end
    always @(*)
        begin
            case(state)
                s0: next = reset ? s1:s0;
                s1: next = s2;
                s2: next = s3;
                s3: next = s4;
                s4: next = s0;
                default: next =s1;
            endcase
        end
    assign shift_ena = (state==s1 | state==s2 | state ==s3 | state==s4);
                
    
    /*reg[2:0] count;
    always @(posedge clk)
        begin
            count <=0;
            if(reset || count !=0)
                begin
                    if(count <4) begin
                        shift_ena <= 1;
                        count <= count+1;
                    end
                    else begin
                        shift_ena <=0;
                        //count <=0;
                    end
                end
            else
                shift_ena <=0;
        end*/
    

endmodule
