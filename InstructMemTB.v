`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:52:27 03/24/2024
// Design Name:   InstructionMem
// Module Name:   Z:/Shared/SSprocessor/InstructMemTB.v
// Project Name:  SSprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstructionMem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module InstructMemTB;

	// Inputs
	reg [31:0] address;

	// Outputs
	wire [31:0] instruction;
	integer i;

	// Instantiate the Unit Under Test (UUT)
	InstructionMem uut (
		.address(address), 
		.instruction(instruction)
	);

	initial begin
		// Initialize Inputs
		address = 0;
		i=0;

		// Wait 100 ns for global reset to finish
		#100;
		for (i = 0; i < 11; i = i+1) begin
            address = i;
            #5;
		end
        
		// Add stimulus here

	end
      
endmodule

