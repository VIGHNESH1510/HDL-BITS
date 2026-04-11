module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7,s8=8,s9=9;
    always @(*)
        begin
            next_state[0] = (~in & state[s0]) | (state[s1] & ~in) | (~in & state[s2]) | (~in & state[s3]) | (~in & state[s4]) 
            | (~in & state[s7]) | (~in & state[s8]) | (~in & state[s9]);
            next_state[1] = (in & state[s0]) | (in & state[s8]) | (in & state[s9]);
            next_state[2] = (in & state[s1]);
            next_state[3] = (in & state[s2]);
            next_state[4] = (in & state[s3]);
            next_state[5] = (in & state[s4]);
            next_state[6] = (in & state[s5]);
            next_state[7] = (in & state[s6]) | (in & state[s7]);
            next_state[8] = (~in & state[s5]);
            next_state[9] = (~in & state[s6]);
            out1 = state[s8] | state[s9];
            out2 = state[s7] | state[s9];
        end
endmodule
