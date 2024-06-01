`timescale 1ns / 1ps
module Reg(clk, RegDst, RegWrite, ReadReg1, ReadReg2, WriteReg, WriteData, ReadData1, ReadData2);

	input clk;
	input RegWrite;
	input RegDst;
	
	input [4:0] ReadReg1, ReadReg2, WriteReg;
	input [31:0] WriteData;
		
	output [31:0] ReadData1, ReadData2;
	
	
	//register memory
	
	reg [31:0] reg_mem [0:31];
	initial begin
		reg_mem[0] <= 1;
		reg_mem[1] <= 2;
		reg_mem[2] <= 3;
		reg_mem[3] <= 4;
		reg_mem[4] <= 5;
		reg_mem[5] <= 9;
		reg_mem[6] <= 9;
	end
	
	
	assign ReadData1 = reg_mem[ReadReg1];
	assign ReadData2 = reg_mem[ReadReg2];
	
always @(posedge clk) begin
  if (RegWrite) begin
    if (RegDst) begin
      reg_mem[WriteReg] <= WriteData;  
    end else begin
      reg_mem[ReadReg2] <= WriteData;  
    end
  end
end	
endmodule
