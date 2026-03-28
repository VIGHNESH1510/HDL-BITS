// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations
    localparam B=1, A=0;

    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            // Fill in reset logic
            present_state = B;
            out =1;
        end else begin
            case (present_state)
                // Fill in state transition logic
                B: next_state = (in==1) ? B:A;
                A: next_state = (in==1) ? A:B;
                default : next_state=B;
                
            endcase

            // State flip-flops
            present_state = next_state;   

            case (present_state)
                // Fill in output logic
                A : out =0;
                default : out =1;
            endcase
        end
    end

endmodule
