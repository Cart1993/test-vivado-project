`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2026 04:00:51 PM
// Design Name: 
// Module Name: tvalid_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tvalid_control(
    input wire clk,
    input wire reset_n,      // Active-low reset
    input wire gpio_start,    // GPIO signal from software
    input wire tready,       // DMA Signal
    input wire tlast,        // Counter signal
    output reg tvalid_out    // tvalid Signal
    );
    reg gpio_start_d;
    wire gpio_pulse;
    
    always @(posedge clk) begin
        if (!reset_n) begin
            gpio_start_d <= 1'b0;
        end else begin
            gpio_start_d <= gpio_start;
        end
     end
     
     assign gpio_pulse = gpio_start & ~gpio_start_d;
     
     always @(posedge clk) begin
         if (!reset_n) begin
             tvalid_out <= 1'b0;
         end else begin
             if (gpio_pulse) begin
                 tvalid_out <= 1'b1;
             end
             
             else if (tvalid_out && tready && tlast) begin
                 tvalid_out <= 1'b0;
             end
         end
     end
endmodule
