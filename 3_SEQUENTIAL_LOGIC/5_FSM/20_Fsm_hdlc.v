module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    localparam [2:0] idle=0, data=1, disc_=2, flag_=3, err_=4;
    reg [2:0] state,next;
    reg [2:0] count;
    always @(posedge clk )
        begin
            if(reset)
                begin
                    state <= idle;
                    count <= 0;
                end
            else
                begin
                    state <= next;
                    if(state == data)
                        count <= count +1;
                    else
                        count <= 0;
                end
        end
    always @(*)
        begin
            case(state)
                idle: next = in ? data : idle;
                data: begin 
                    if(in) begin
                        if(count == 5)
                            next = err_;
                        else
                            next = data;
                    end
                    else begin
                        if(count == 4)
                        	next = disc_;
                        else if(count ==5)
                            next = flag_;
                        else
                            next =idle;
                    end
                end
                disc_: next = in ? data: idle;
                flag_: next = in ? data: idle;
                err_: next = in ? err_: idle;
            endcase
        end
    assign disc = (state == disc_);
    assign flag = (state == flag_);
    assign err = (state == err_);
endmodule
