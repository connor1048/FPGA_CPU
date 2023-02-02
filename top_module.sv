// Project F: FPGA Graphics - Square (Arty Pmod VGA)
// (C)2022 Will Green, open source hardware released under the MIT License
// Learn more at https://projectf.io/posts/fpga-graphics/

`default_nettype none
`timescale 1ns / 1ps

module top_module (
    input  wire logic clk_100m,      // 100 MHz clock
    input  wire logic rst,           // reset button
    inout  wire       ps2cA,
    inout  wire       ps2dA,
    inout  wire       ps2cB,
    inout  wire       ps2dB,
    output      logic vga_hsync,     // VGA horizontal sync
    output      logic vga_vsync,     // VGA vertical sync
    output      logic [3:0] vga_r,   // 4-bit VGA red
    output      logic [3:0] vga_g,   // 4-bit VGA green
    output      logic [3:0] vga_b,   // 4-bit VGA blue
    output      logic [7:0] seg_out,
	output      logic [7:0] sel_out
    );

    // generate pixel clock
    logic clk_25m;
    logic clk_25m_locked;
    clock_generator clock(
       .clk_100m(clk_100m),
       .rst(!rst),  // reset button is active low
       .clk_25m(clk_25m),
       .clk_25m_5x(),
       .clk_25m_locked(clk_25m_locked)
    );

    logic [2:0] rgb; // keyboard
	logic [2:0] btn; // mouse click
	logic mouse_on;  // mouse screen position
    
    keyboard_mouse ps2(
        .clk(clk_25m),
        .rst(rst),
        .de(de),
        .sx(sx), 
        .sy(sy),
        .ps2dA(ps2dA), 
        .ps2cA(ps2cA),
        .ps2dB(ps2dB), 
        .ps2cB(ps2cB),
        .keyboard_rgb(rgb),
        .mouse_on(mouse_on),
        .btn(btn),
        .wr_data(wr_data)
    );
    
    wire [8:0] wr_data;
    // display sync signals and coordinates
    logic [9:0] sx, sy;
    logic hsync, vsync, de;
    
    VGA_output vga(
        .clk_pix(clk_25m),
        .rst_pix(clk_25m_locked),
        .hsync(hsync), 
        .vsync(vsync),
        .de(de),
        .sx(sx), 
        .sy(sy),
        .mouse_on(mouse_on),
        .mouse_btn(btn),
        .rgb(rgb),
        .vga_hsync(vga_hsync), 
        .vga_vsync(vga_vsync),
        .vga_r(vga_r), 
        .vga_g(vga_g), 
        .vga_b(vga_b) 
     );
     
    seven_seg_top display(
    .clk(clk_100m),
    .x(wr_data),
    .y(),
    .D0_SEG(seg_out),
    .D0_AN(sel_out));
     
endmodule
