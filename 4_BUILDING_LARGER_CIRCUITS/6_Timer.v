module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    localparam [4:0]idle=0,s1=1,s11=2,s110=3,shift=4,count_r=5,done_r=6;
    reg[4:0] state,next;
    reg[3:0] cnt,sh;
    reg[9:0] frame;
    always@(posedge clk)
        begin
            if(reset) begin 
                state <= idle;
                cnt <=0;
                sh <=0;
                frame <= 999;
            end
            else begin 
                state <= next;
                if(state == shift) begin
                    cnt <= cnt+1;
                    sh <={sh[2:0],data};
                    
                end
                else cnt <= 0;
                if(state == count_r )
                    begin
                       
                        if(frame == 0) begin
                            if(sh!= 0)
                            	sh <= sh-1;
                            frame <= 999;
                        end 
                        else
                        frame <= frame-1;
                    end
                    
            end
        end
    always @(*)
        begin
            case(state)
                idle: next = data ? s1: idle;
                s1: next = data ? s11: idle;
                s11: next = ~data ? s110: s11;
                s110: next = data ? shift: idle;
                shift: next = (cnt == 3) ? count_r : shift;
                count_r: next = (sh == 0 && frame==0) ? done_r : count_r;
                done_r : next = ack ? idle : done_r;
            endcase
        end
    assign done =(state == done_r);
    assign counting =(state == count_r);
    assign count = (state==count_r) ? sh : 0;
    

endmodule
