`timescale 1ns / 1ps

module Fetch(    input clk,
    input rst,
	 input j_label,
	 input b_label,
	 input zero,
	 input [15:0] b_address,
	 input [25:0]j_address,
	 input [31:0] address,
	 output [31:0] instruction,
	 output [31:0]PC_out
    );
	 
	 reg [31:0] instructionR;
	 reg [31:0] PC_outR;
	 
	 wire [31:0] pcout;
	 wire [31:0] inst;
	 
	 
	 PC pc (
    .clk(clk),
    .rst(rst),
	 .j_label(j_label),
	 .b_label(Branch),
	 .b_address(immed),
	 .zero(Zero),
	 .j_address(j_field),
    .PC_out(pcout)
);


InstructionMem Instruct_mem (
    .address(pcout),
    .instruction(inst)
);


always @(posedge clk, rst) begin

	if (rst==1)begin
	PC_outR<=32'b0;
	instructionR<=32'b0;
	end
	
	else begin
	instructionR<=inst;
	PC_outR<=pcout;
	end
	
end	


assign instruction=instructionR;
assign PC_out=PC_outR;


endmodule
