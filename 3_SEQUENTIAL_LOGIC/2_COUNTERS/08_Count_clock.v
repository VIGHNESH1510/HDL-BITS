module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

wire sec_roll = (ss == 8'h59);
wire min_roll = (mm == 8'h59);

always @(posedge clk) begin
    if (reset) begin
        hh <= 8'h12;
        mm <= 8'h00;
        ss <= 8'h00;
        pm <= 0;
    end 
    else if (ena) begin

        // -------- Seconds --------
        if (sec_roll)
            ss <= 8'h00;
        else if (ss[3:0] == 9)
            ss <= {ss[7:4] + 1, 4'h0};
        else
            ss <= ss + 1;

        // -------- Minutes --------
        if (sec_roll) begin
            if (min_roll)
                mm <= 8'h00;
            else if (mm[3:0] == 9)
                mm <= {mm[7:4] + 1, 4'h0};
            else
                mm <= mm + 1;
        end

        // -------- Hours --------
        if (sec_roll && min_roll) begin
    if (hh == 8'h11) begin
        hh <= 8'h12;
        pm <= ~pm;
    end
    else if (hh == 8'h12)
        hh <= 8'h01;
    else if (hh[3:0] == 9)
        hh <= {hh[7:4] + 1, 4'h0};
    else
        hh <= hh + 1;
end

    end
end

endmodule
