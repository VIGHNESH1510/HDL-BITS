module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    localparam [2:0] idle=0, data=1,stop=2,done_r=3,error=4;
    reg [2:0]state, next;
    reg [2:0]count;
    always @(posedge clk)
        begin
            if(reset) begin
                state <= idle;
                count <=0;
            end
            else begin
                state <= next;
                if(state == data)
                    count <= count+1;
                else
                    count <= 0;
                
            end
        end

    always @(*)
        begin
            case(state)
                idle : next = !in ? data: idle;
                data : next = (count ==7) ? stop:data;
                stop: next = in ? done_r:error;
                done_r : next = in ? idle : data;
                error : next = in ? idle : error;
            endcase
        end
    assign done = (state ==done_r);
    

endmodule
