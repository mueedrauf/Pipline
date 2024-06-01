`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:41:26 03/13/2024 
// Design Name: 
// Module Name:    PC_InstMem 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PC_InstMem (
    input clk,
    input rst,
    input [31:0]PC_in,
	 output reg [31:0]PC_out
);


always @ (posedge clk or posedge rst) begin
    if (rst) begin
        PC_out <= 0;
		  end
    else begin
        PC_out <= PC_in + 1; 
    end
end



endmodule

