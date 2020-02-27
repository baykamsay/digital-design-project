`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Baykam Say
// 21802030
// Part 2, gets values from assign_values and stores them while showing on the led
//////////////////////////////////////////////////////////////////////////////////


module storage(input clk, reset, select, [1:0] show, [15:0] value,
               output reg [15:0] leds, reg [63:0] num);
    reg [1:0] selected = 2'b00;
    reg sel_detected;
    
    debouncer(clk, select, sel_detected);
    
    always @ (posedge clk) begin
    
        if (reset) begin
            num = 64'b0;
            selected = 2'b00;
        end
        
        if (sel_detected) begin
            case (selected)
                2'b00: begin
                    num[15:0] = value;
                end
                2'b01: begin
                    num[31:16] = value;
                end
                2'b10: begin
                    num[47:32] = value;
                end
                2'b11: begin
                    num[63:48] = value;
                end
            endcase
            selected++;
        end
        
        case (show)
            2'b00: begin
                leds = num[15:0];
            end
            2'b01: begin
                leds = num[31:16];
            end
            2'b10: begin
                leds = num[47:32];
            end
            2'b11: begin
                leds = num[63:48];
            end
        endcase
    end
    
endmodule
