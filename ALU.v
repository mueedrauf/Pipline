`timescale 1ns / 1ps

module ALU (ALUCt, A, B, ALUOut, Zero);

	input [2:0] ALUCt;
	input [31:0] A,B;
	
	output reg [31:0] ALUOut;
	output Zero;
	assign Zero = (ALUOut == 0);
	
	always @(ALUCt, A, B) begin
		case (ALUCt)
			3'b000: ALUOut <= A & B;             //000 and
			3'b001: ALUOut <= A | B;            //001 or
			3'b010: ALUOut <= A + B;          // 101 add
			3'b110: ALUOut <= A - B;          //110 subtract
			3'b111: ALUOut <= A < B ? 1:0;   //111 set if less that
			default: ALUOut <= 0;
		endcase
	end
endmodule
