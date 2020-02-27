`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Baykam Say
// 21802030
// Debouncer for the buttons
//////////////////////////////////////////////////////////////////////////////////


module debouncer(input clk, btn, output reg btn_detected);
        
    reg btn1=1'b0, btn2=1'b0;
    reg [15:0] btn_history = 16'h0; // see what the number was in the past
    
    // to avoid metastability issues
    always @(posedge clk) begin
        btn1 <= btn;
        btn2 <= btn1;
    end
    reg btn_synched = btn2;
    
    always @(posedge clk) begin
        btn_history <= { btn_history[14:0] , btn_synched };
        if (btn_history == 16'b0011111111111111) begin
            btn_detected <= 1'b1;
        end
        else begin
            btn_detected <= 1'b0;
        end
    end

endmodule
