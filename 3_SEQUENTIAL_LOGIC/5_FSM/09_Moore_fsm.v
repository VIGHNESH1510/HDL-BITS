module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter [2:0] above_s3  = 3'd5,btw_s3_s2_fall = 3'd3,btw_s3_s2_rise = 3'd4,btw_s1_s2_fall = 3'd1,
    btw_s1_s2_rise = 3'd2, below_s1  = 3'd0;

    reg [2:0] state, next;
    always @(posedge clk) begin
        if (reset) 
            state <= below_s1;
        else
            state <= next;
    end
    always @(*) begin
        case (state)
            below_s1 : next = s[1] ? btw_s1_s2_rise : below_s1;
            btw_s1_s2_fall : next = s[2] ? btw_s3_s2_rise : (s[1] ? btw_s1_s2_fall : below_s1);
            btw_s1_s2_rise : next = s[2] ? btw_s3_s2_rise : (s[1] ? btw_s1_s2_rise : below_s1);
            btw_s3_s2_fall : next = s[3] ? above_s3 : (s[2] ? btw_s3_s2_fall : btw_s1_s2_fall);
            btw_s3_s2_rise : next = s[3] ? above_s3 : (s[2] ? btw_s3_s2_rise : btw_s1_s2_fall);
            above_s3 : next = s[3] ? above_s3 : btw_s3_s2_fall;
            default : next = below_s1;
        endcase
    end
    always @(*) begin
        fr3 = 0; fr2 = 0; fr1 = 0; dfr = 0;
        case (state)
            below_s1       : {fr3, fr2, fr1, dfr} = 4'b1111;
            btw_s1_s2_fall : {fr3, fr2, fr1, dfr} = 4'b0111; 
            btw_s1_s2_rise : {fr3, fr2, fr1, dfr} = 4'b0110; 
            btw_s3_s2_fall : {fr3, fr2, fr1, dfr} = 4'b0011; 
            btw_s3_s2_rise : {fr3, fr2, fr1, dfr} = 4'b0010; 
            above_s3       : {fr3, fr2, fr1, dfr} = 4'b0000;
            default        : {fr3, fr2, fr1, dfr} = 4'bxxxx;
        endcase
    end

endmodule
