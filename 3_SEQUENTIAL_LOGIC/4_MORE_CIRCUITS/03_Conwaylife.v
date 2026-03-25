module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    reg [255:0]next;
    integer count,left,down,right,up;
    always @(*)
        begin
            for(integer r=0; r<16; r=r+1)
                begin
                    for(integer c=0; c<16;c=c+1)
                        begin
                             left = (c==0) ? 15 : c-1;
                             up = (r==0) ? 15 : r-1;
                             right = (c==15) ? 0 : c+1;
                             down = (r==15) ? 0 : r+1;
                            
                             count = q[up*16 + left] + q[up*16+c]+q[up*16 + right]+
                            q[r*16+left] + q[r*16 + right] + q[down*16 + left] + q[down*16 + c]+
                            q[down*16 +right];
                            
                            case(count)
                                2: next[r*16 +c] = q[r*16 +c];
                                3: next[r*16 +c] =1;
                                default: next[r*16+c] =0;
                            endcase
                        end
                end
        end
    always @(posedge clk)
        begin
            if(load)
                q <= data;
            else
                q <= next;
        end

endmodule
