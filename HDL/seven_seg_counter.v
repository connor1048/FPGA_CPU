`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2022 03:06:42 PM
// Design Name: 
// Module Name: count
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


module counter_n
    #(BITS = 8)
    (
    input clk,
    input rst,
    output tick,
    output [BITS - 1 : 0] q
    );
    
    reg [BITS - 1 : 0] rCounter;
     
    always @(posedge clk, posedge rst)
        if (rst)
            rCounter <= 0;
        else
            rCounter <= rCounter + 1;
            
    assign q = rCounter;
    assign tick = (rCounter == 2 ** BITS - 1) ? 1'b1 : 1'b0;
         
endmodule
