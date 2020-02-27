`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Baykam Say
// 21802030
// Part 3, game module for the project, a gamification of cellular automata
//////////////////////////////////////////////////////////////////////////////////


module game(input clk, restart, reset, btn_up, btn_left, btn_right, btn_down, reg [63:0] matrix_in,
            output s6, s5, s4, s3, s2, s1, s0, dp, [3:0] an, output [7:0] rowsOut, output shcp, stcp, mr, oe, ds, output reg game_over);
    
    wire [15:0] ruleset = 16'b0101100001011100; // ruleset computed from ID
    localparam int a [63:0] = {2, 3, 2, 3, 4, 3, 4, 3,
                               1, 4, 1, 4, 1, 2, 1, 2,
                               2, 3, 2, 3, 4, 3, 4, 3,
                               1, 4, 1, 4, 1, 2, 1, 2,
                               3, 4, 3, 4, 4, 3, 4, 3,
                               2, 1, 2, 1, 1, 2, 1, 2,
                               3, 4, 3, 4, 4, 3, 4, 3,
                               2, 1, 2, 1, 1, 2, 1, 2}; // matrix seperated into groups
    
    reg [63:0] matrix = matrix_in; // get the matrix
    reg [63:0] new_matrix = matrix; // create next matrix
    reg [3:0] neighbourhood; // cells neighbourhood
    reg [15:0] disp; // number for sevSeg diplay
    reg [3:0] in0, in1, in2, in3; // for sevSeg display
    
    // debouncers
    reg btn_up_detected;
    reg btn_left_detected;
    reg btn_right_detected;
    reg btn_down_detected;
    debouncer(clk, btn_up, btn_up_detected);
    debouncer(clk, btn_left, btn_left_detected);
    debouncer(clk, btn_right, btn_right_detected);
    debouncer(clk, btn_down, btn_down_detected);
    
    always @ (posedge clk) begin
        
        if (restart || reset) begin // start from beginning
            matrix = matrix_in;
            new_matrix = matrix;
            disp = 16'b0;
            game_over = 1'b0;
        end
        
        if (matrix) begin // if there is lit up leds
        
            if (btn_up_detected) begin
                disp++;
                for (int i = 63; i >= 0 ; i--) begin
                        if (a[i] == 1) begin
                        
                            if (i < 8) begin
                                neighbourhood[0] = matrix[i + 56];
                            end
                            else begin
                                neighbourhood[0] = matrix[i - 8];
                            end
                            
                            if (i % 8 == 0) begin
                                neighbourhood[1] = matrix[i + 7];
                            end
                            else begin
                                neighbourhood[1] = matrix[i - 1];
                            end
                            
                            if (i % 8 == 7) begin
                                neighbourhood[2] = matrix[i - 7];
                            end
                            else begin
                                neighbourhood[2] = matrix[i + 1];
                            end
                            
                            if (i > 56) begin
                                neighbourhood[3] = matrix[i - 56];
                            end
                            else begin
                                neighbourhood[3] = matrix[i + 8];
                            end
                            
                            new_matrix[i] = ruleset[neighbourhood];
                        end
                end
            end
            
            if (btn_left_detected) begin
                disp++;
                for (int i = 63; i >= 0 ; i--) begin
                        if (a[i] == 2) begin
                        
                            if (i < 8) begin
                                neighbourhood[0] = matrix[i + 56];
                            end
                            else begin
                                neighbourhood[0] = matrix[i - 8];
                            end
                            
                            if (i % 8 == 0) begin
                                neighbourhood[1] = matrix[i + 7];
                            end
                            else begin
                                neighbourhood[1] = matrix[i - 1];
                            end
                            
                            if (i % 8 == 7) begin
                                neighbourhood[2] = matrix[i - 7];
                            end
                            else begin
                                neighbourhood[2] = matrix[i + 1];
                            end
                            
                            if (i > 56) begin
                                neighbourhood[3] = matrix[i - 56];
                            end
                            else begin
                                neighbourhood[3] = matrix[i + 8];
                            end
                            
                            new_matrix[i] = ruleset[neighbourhood];
                        end
                end
            end
            
            if (btn_right_detected) begin
                disp++;
                for (int i = 63; i >= 0 ; i--) begin
                        if (a[i] == 3) begin
                        
                            if (i < 8) begin
                                neighbourhood[0] = matrix[i + 56];
                            end
                            else begin
                                neighbourhood[0] = matrix[i - 8];
                            end
                            
                            if (i % 8 == 0) begin
                                neighbourhood[1] = matrix[i + 7];
                            end
                            else begin
                                neighbourhood[1] = matrix[i - 1];
                            end
                            
                            if (i % 8 == 7) begin
                                neighbourhood[2] = matrix[i - 7];
                            end
                            else begin
                                neighbourhood[2] = matrix[i + 1];
                            end
                            
                            if (i > 56) begin
                                neighbourhood[3] = matrix[i - 56];
                            end
                            else begin
                                neighbourhood[3] = matrix[i + 8];
                            end
                            
                            new_matrix[i] = ruleset[neighbourhood];
                        end
                end
            end
            
            if (btn_down_detected) begin
                disp++;
                for (int i = 63; i >= 0 ; i--) begin
                        if (a[i] == 4) begin
                        
                            if (i < 8) begin
                                neighbourhood[0] = matrix[i + 56];
                            end
                            else begin
                                neighbourhood[0] = matrix[i - 8];
                            end
                            
                            if (i % 8 == 0) begin
                                neighbourhood[1] = matrix[i + 7];
                            end
                            else begin
                                neighbourhood[1] = matrix[i - 1];
                            end
                            
                            if (i % 8 == 7) begin
                                neighbourhood[2] = matrix[i - 7];
                            end
                            else begin
                                neighbourhood[2] = matrix[i + 1];
                            end
                            
                            if (i > 56) begin
                                neighbourhood[3] = matrix[i - 56];
                            end
                            else begin
                                neighbourhood[3] = matrix[i + 8];
                            end
                            
                            new_matrix[i] = ruleset[neighbourhood];
                        end
                end
            end
//            // not to increment when there is no change
//            if (matrix != new_matrix) begin
//                disp++;
//            end
            
            matrix = new_matrix;
        end
        else begin
            game_over = 1'b1;
        end
    end
    
    converter convert(clk, matrix, rowsOut, shcp, stcp, mr, oe, ds );
    
    assign in0 = disp[3:0];
    assign in1 = disp[7:4];
    assign in2 = disp[11:8];
    assign in3 = disp[15:12];
    
    SevSeg_4digit(clk, in0, in1, in2, in3, s6, s5, s4, s3, s2, s1, s0, dp, an);

endmodule
