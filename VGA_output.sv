`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/01/2023 04:20:32 PM
// Design Name: 
// Module Name: VGA_output
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


module VGA_output(
    input  wire logic       clk_pix,
    input  wire logic       rst_pix,
    input  wire logic       hsync, vsync,
    input  wire logic       de,
    input  wire logic [9:0] sx,sy,
    input  wire logic       mouse_on,
    input  wire logic [2:0] mouse_btn,
    input  wire logic [2:0] rgb,
    output      logic       vga_hsync, vga_vsync,
    output      logic [3:0] vga_r, vga_g, vga_b 
    );
    
    // Display timings for 480p
    simple_480p display_inst (
        .clk_pix(clk_pix),
        .rst_pix(!rst_pix),  // wait for clock lock
        .sx(sx),
        .sy(sy),
        .hsync(hsync),
        .vsync(vsync),
        .de(de)
    );
    
    // Screen background
    logic [3:0] paint_r, paint_g, paint_b;
    
    home_screen display(
        .sx(sx), 
        .sy(sy),
        .mouse_btn(mouse_btn),
        .paint_r(paint_r),
        .paint_g(paint_g),
        .paint_b(paint_b) 

    );
    
    // VGA Pmod output
    always_ff @(posedge clk_pix) begin
        vga_hsync <= hsync;
        vga_vsync <= vsync;
        if (de) begin
			if(mouse_on) begin //mouse color
				vga_r <= 4'b0000;
				vga_g <= 4'b0000;
				vga_b <= 4'b0000;
			end
		    else begin	
                vga_r <= rgb[2]? 4'b0000:paint_r;
                vga_g <= rgb[1]? 4'b0000:paint_g;
                vga_b <= rgb[0]? 4'b0000:paint_b;
            end
        end else begin  // VGA colour should be black in blanking interval
            vga_r <= 4'h0;
            vga_g <= 4'h0;
            vga_b <= 4'h0;
        end
    end
endmodule
