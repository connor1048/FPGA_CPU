`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2022 02:43:39 PM
// Design Name: 
// Module Name: seven_seg_mux
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


module seven_seg_mux(
    input clk, rst,
    input [7:0] seg0, seg1, seg2, seg3,seg4, seg5, seg6, seg7,
    output reg [7:0] an,
    output reg [7:0] sseg
    );
     
    // refresh rate of ~1526Hz (100 MHz / 2^16)
    localparam BITS = 18;
 
    counter_n #(.BITS(BITS)) counter(.clk(clk), .rst(rst), .q(q));
     
    wire [BITS - 1 : 0] q;
     
    always @*
        case (q[BITS - 1 : BITS - 3])
            3'b000:
                begin
                    an = 8'b11111110;
                    sseg = seg0;
                end
            3'b001:
                begin
                    an = 8'b11111101;
                    sseg = seg1;
                end
            3'b010:
                begin
                    an = 8'b11111011;
                    sseg = seg2;
                end
            3'b011:
                begin
                    an = 8'b11110111;
                    sseg = seg3;
                end
            3'b100:
                begin
                    an = 8'b11101111;
                    sseg = seg4;
                end
            3'b101:
                begin
                    an = 8'b11011111;
                    sseg = seg5;
                end
            3'b110:
                begin
                    an = 8'b10111111;
                    sseg = seg6;
                end
            default:
                begin
                    an = 8'b01111111;
                    sseg = seg7;
                end
        endcase                         
endmodule

