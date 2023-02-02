`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/01/2023 02:03:59 PM
// Design Name: 
// Module Name: keyboard_mouse
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


module keyboard_mouse(
input wire logic clk,
input wire logic rst,
input wire       de,
input wire   [9:0]    sx, sy,
inout wire       ps2dA, ps2cA,
input wire       ps2dB, ps2cB,
output logic [2:0]     keyboard_rgb,
output logic      mouse_on,
output logic [2:0]     btn,
output logic [8:0] wr_data

    );
    
    localparam SIZE=16; //mouse pointer width and height
	 
	logic[8:0]  x,y;
	logic       m_done_tick;
	logic       video_on;
	logic[11:0] pixel_x,pixel_y;
	logic[14:0]  mouse_x_q=0,mouse_x_d; //stores x-value(left part) of mouse, 
	logic[14:0]  mouse_y_q=0,mouse_y_d; //stores y-value(upper part) of mouse, 
	logic[2:0]  mouse_color_q=0,mouse_color_d; //stores current mouse color and can be changed by right/left click 
    logic DIP = 8;

     mouse ms(
		.clk(clk),
		.rst_n(rst),
		.ps2c(ps2cA),
		.ps2d(ps2dA),
		.x(x),
		.y(y),
		.btn(btn),
		.m_done_tick(m_done_tick)
    );
    
    //register operation
	 always_ff @(posedge clk,negedge rst) begin
		if(!rst) begin
			mouse_x_q<=0;
			mouse_y_q<=0;
			mouse_color_q<=0;
		end
		else begin
			mouse_x_q<=mouse_x_d;
			mouse_y_q<=mouse_y_d;
			mouse_color_q<=mouse_color_d;
		end
	 end
    
    //logic for updating mouse location(by dragging the mouse) and mouse pointer color(by left/right click)
	 always @* begin
		mouse_x_d=mouse_x_q;
		mouse_y_d=mouse_y_q;
		mouse_color_d=mouse_color_q;
		if(m_done_tick) begin
			mouse_x_d=x[8]? mouse_x_q - 1 -{~{x[7:0]}} : mouse_x_q+x[7:0] ; //new x value of pointer
			mouse_y_d=y[8]? mouse_y_q + 1 +{~{y[7:0]}} : mouse_y_q-y[7:0] ; //new y value of pointer
			
			mouse_x_d=(mouse_x_d>640 * 8)? 640 * 8: mouse_x_d; //wraps around when reaches border
			mouse_y_d=(mouse_y_d>480 * 8)? 480 * 8: mouse_y_d; //wraps around when reaches border
			
			
			//if(btn[0]) red = 4'hF;//right click to change color(increment)
//			else if(btn[0]) mouse_color_d=mouse_color_q-1;//left click to change color(decrement)
		end                  
	 end
	 
	 assign mouse_on = (mouse_x_q/8 <= sx) && ( sx <= (mouse_x_q / 8)+SIZE) && (mouse_y_q / 8 <= sy) && (sy <= (mouse_y_q / 8) +SIZE);
	 
	 	
//	 logic btn;
//	 always@(posedge clk_100m)begin
//	    if(btn[1]) begin
//	        if(mouse_x_q >= 220*8 && mouse_x_q < 420*8)begin
//	            red <= 0;
//	            end
//	    end
//	  if(btn[0]) begin
//	    if(mouse_x_q >= 220*8 && mouse_x_q < 420*8)begin
//	            red <= 4'hF;
//	    end
//	 end
//	 end
    
    keyboard keybdd(
        .clk(clk),
        .rst_n(rst),
        .ps2c(ps2cB),
        .ps2d(ps2dB),
        .pixel_x(sx),
        .pixel_y(sy),
        .video_on(de),
        .rgb(keyboard_rgb),
        .wr_data(wr_data)
    );



endmodule