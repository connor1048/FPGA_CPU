`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/01/2023 08:50:50 PM
// Design Name: 
// Module Name: binary_to_seven_seg
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
module binary_to_seven_seg(
   input [3:0]  hex,
   input        dp,
   output [7:0] sseg
   
   );
 
  reg [7:0]    r_Hex_Encoding;

  always @*
    begin
      case (hex)
        4'b0000 : r_Hex_Encoding <= 8'b01000000; // 0
        4'b0001 : r_Hex_Encoding <= 8'b01111001; // 1
        4'b0010 : r_Hex_Encoding <= 8'b00100100; // 2
        4'b0011 : r_Hex_Encoding <= 8'b00110000; // 3
        4'b0100 : r_Hex_Encoding <= 8'b00011001; // 4       
        4'b0101 : r_Hex_Encoding <= 8'b00010010; // 5
        4'b0110 : r_Hex_Encoding <= 8'b00000010; // 6
        4'b0111 : r_Hex_Encoding <= 8'b01111000; // 7
        4'b1000 : r_Hex_Encoding <= 8'b00000000; // 8
        4'b1001 : r_Hex_Encoding <= 8'b00011000; // 9
        4'b1010 : r_Hex_Encoding <= 8'b00001000; // A
        4'b1011 : r_Hex_Encoding <= 8'b00000011; // B
        4'b1100 : r_Hex_Encoding <= 8'b01000110; // C
        4'b1101 : r_Hex_Encoding <= 8'b00100001; // D
        4'b1110 : r_Hex_Encoding <= 8'b00000110; // E
        4'b1111 : r_Hex_Encoding <= 8'b00001110; // F
      endcase
      r_Hex_Encoding[7] <= dp;
    end 
    
  assign sseg = r_Hex_Encoding;
 
endmodule 