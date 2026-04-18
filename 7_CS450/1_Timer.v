module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9:0]count ;
    always @ (posedge clk)
        begin
            if(load) begin
                count <= data;
                 tc <= data==0 ? 1:0;
            end
            else
                begin
                    if(count == 0 || count ==1) begin
                        tc <=1;
                        count <=0;
                    end
                    else begin
                        tc <=0;
                        count <= count -1;
                    end
                end
        end

endmodule
