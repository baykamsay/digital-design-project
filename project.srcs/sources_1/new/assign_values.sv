`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Baykam Say
// 21802030
// Part 1, assigns values to the seven segment from switches
//////////////////////////////////////////////////////////////////////////////////


module assign_values( input [3:0] generator, input [1:0] selector, input assigner, clk, reset,
                      output s6, s5, s4, s3, s2, s1, s0, dp, [3:0] an, [15:0] result);
    reg [3:0] in0, in1, in2, in3, prev0 , prev1, prev2, prev3;
    
    always @ (posedge clk) begin
        
        if (reset) begin
            prev0 = 1'b0;
            prev1 = 1'b0;
            prev2 = 1'b0;
            prev3 = 1'b0;
        end
        
        case(selector)
            2'b00: begin
                in0 = prev0;
                if (assigner) begin
                    prev0 = generator;
                end
                in1 = prev1;
                in2 = prev2;
                in3 = prev3;
            end
            2'b01: begin
                in1 = prev1;
                if (assigner) begin
                    prev1 = generator;
                end
                in0 = prev0;
                in2 = prev2;
                in3 = prev3;
            end
            2'b10: begin
                in2 = prev2;
                if (assigner) begin
                    prev2 = generator;
                end
                in0 = prev0;
                in1 = prev1;
                in3 = prev3;
            end
            2'b11: begin
                in3 = prev3;
                if (assigner) begin
                    prev3 = generator;
                end
                in0 = prev0;
                in1 = prev1;
                in2 = prev2;
            end
        endcase
    end
    
    assign result[3:0] = prev0;
    assign result[7:4] = prev1;
    assign result[11:8] = prev2;
    assign result[15:12] = prev3;
    SevSeg_4digit sevSeg(clk, in0, in1, in2, in3, s6, s5, s4, s3, s2, s1, s0, dp, an);
endmodule
