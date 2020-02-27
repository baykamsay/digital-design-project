`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Baykam Say
// 21802030
// driver module for the project
//////////////////////////////////////////////////////////////////////////////////


module main(input [3:0] generator, input [1:0] selector, show, input assigner, clk, select, reset, start, btn_up, btn_left, btn_right, btn_down,
            output reg s6, s5, s4, s3, s2, s1, s0, dp, [3:0] an, [15:0] led, output logic[7:0] rowsOut,
            output logic shcp, stcp, mr, oe, ds );
    
    wire [15:0] value; // value of 2 rows
    reg [63:0] matrix; // initial matrix value
    reg state = 1'b0; // if in game or not
    wire av6, av5, av4, av3, av2, av1, av0, av_dp; // sevSeg output for assignValues
    wire g6, g5, g4, g3, g2, g1, g0, g_dp; // sevSeg output for game score
    wire [3:0] g_an;
    wire [3:0] av_an;
    wire [63:0] num; // stored value in storage
    wire [15:0] leds; // output leds
    wire game_over; // is game is over
    
    assign_values assignValues(generator, selector, assigner, clk, reset, av6, av5, av4, av3, av2, av1, av0, av_dp, av_an, value);
    storage store(clk, reset, select, show, value, leds, num);
    game(clk, start, reset, btn_up, btn_left, btn_right, btn_down, matrix, g6, g5, g4, g3, g2, g1, g0, g_dp, g_an, rowsOut, shcp, stcp, mr, oe, ds, game_over);
    
    // clock div
    reg [25:0] limit = 26'd25000000;
    reg blink;
    reg [25:0] cnt;
    always @ (posedge clk) begin
        if (reset || limit == 26'd0) begin
            blink = 0;
            cnt = 26'b0;
        end
        else if (cnt == limit) begin
            cnt = 26'b0;
            blink = ~blink;
        end
        else begin
            cnt++;
        end
    end
    // clock div end
    
    always @ (posedge clk) begin
        if (reset) begin
            state <= 1'b0;
            matrix <= 64'b0;
        end
        
        if (start) begin
            state <= 1'b1;
            matrix <= num;
            led <= 16'b0;
        end
        
        case(state)
            1'b0: begin // generating the initial number
                s6 <= av6;
                s5 <= av5;
                s4 <= av4;
                s3 <= av3;
                s2 <= av2;
                s1 <= av1;
                s0 <= av0;
                dp <= av_dp;
                an <= av_an;
                led <= leds;
            end
            1'b1: begin // in the game
                if (game_over) begin
                    if (blink) begin
                        s6 <= 1'b1;
                        s5 <= 1'b1;
                        s4 <= 1'b1;
                        s3 <= 1'b1;
                        s2 <= 1'b1;
                        s1 <= 1'b1;
                        s0 <= 1'b1;
                        dp <= 1'b1;
                        an <= 3'b111;
                    end
                    else begin
                        s6 <= g6;
                        s5 <= g5;
                        s4 <= g4;
                        s3 <= g3;
                        s2 <= g2;
                        s1 <= g1;
                        s0 <= g0;
                        dp <= g_dp;
                        an <= g_an;
                    end
                end
                else begin
                    s6 <= g6;
                    s5 <= g5;
                    s4 <= g4;
                    s3 <= g3;
                    s2 <= g2;
                    s1 <= g1;
                    s0 <= g0;
                    dp <= g_dp;
                    an <= g_an;
                end
            end
       endcase
    end

endmodule
