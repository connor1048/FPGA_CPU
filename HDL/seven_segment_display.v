`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2022 01:12:16 PM
// Design Name: 
// Module Name: twelve_bit_incramentor
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


module seven_seg_top(
    input         clk,
    input  [8:0]  x,
    input  [9:0]  y,
    output [7:0]  D0_AN,
    output [7:0]  D0_SEG
    );
 
    wire [7:0] led0, led1, led2, led3, led4, led5, led6, led7;
    
    binary_to_seven_seg seg0
    (.hex(x[3:0]), 
    .dp(1'b1), 
    .sseg(led0)
    );

    binary_to_seven_seg seg1
    (.hex(x[7:4]),
     .dp(1'b1), 
     .sseg(led1)
    );
    
    binary_to_seven_seg seg2
    (.hex(x[8]),
     .dp(1'b1), 
     .sseg(led2)
    );
    
    binary_to_seven_seg seg3
    (.hex(),
     .dp(1'b1), 
     .sseg(led3)
    );
    
    binary_to_seven_seg seg4
    (.hex(), 
    .dp(1'b1), 
    .sseg(led4)
    );

    binary_to_seven_seg seg5
    (.hex(),
     .dp(1'b1), 
     .sseg(led5)
    );
    
    binary_to_seven_seg seg6
    (.hex(),
     .dp(1'b1), 
     .sseg(led6)
    );
    
    binary_to_seven_seg seg7
    (.hex(),
     .dp(1'b1), 
     .sseg(led7)
    );
    


    seven_seg_mux dispunit(
    .clk(clk),
    .rst(1'b0),
    .seg0(led0),
    .seg1(led1),
    .seg2(led2),
    .seg3(led3),
    .seg4(led4),
    .seg5(led5),
    .seg6(led6),
    .seg7(led7),
    .an(D0_AN),
    .sseg(D0_SEG)
    );
    
    
    
endmodule

