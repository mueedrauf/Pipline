`timescale 1ns / 1ps
module jump (  
input j_label,
input [25:0] j_field,    
output reg [31:0] j_address
    );
	 
	always @* begin
	if (j_label)
	  j_address<={6'b000000, j_field};
	end
	 


endmodule

