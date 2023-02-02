`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/01/2023 04:17:05 PM
// Design Name: 
// Module Name: home_screen
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


module home_screen(
input wire logic [9:0] sx, sy,
input wire logic [2:0] mouse_btn,
output     logic [3:0] paint_r,
output     logic [3:0] paint_g,
output     logic [3:0] paint_b

    );
    
    // define a square with screen coordinates
    logic IDE;
    logic screen;
    logic home;
    logic border;
    always_comb begin
        IDE = ((sx > 10 && sx < 315) || (sx > 325 && sx < 629)) && (sy > 10 && sy < 469);
    end
    
//    always_comb begin
//        if(mouse_btn && (sx > 10 && sx < 315) && (sy > 10 && sy < 469)) begin
//             screen = IDE;
//        end
//    end
    
    
    always_comb begin
        paint_r = (IDE) ? 4'h9 : 4'h9;
        paint_g = (IDE) ? 4'h9 : 4'h0;
        paint_b = (IDE) ? 4'h9 : 4'hf;
    end

endmodule
