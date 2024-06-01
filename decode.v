`timescale 1ns / 1ps

module decode(  input clk,
  input [31:0] inst,
  input [31:0] ALUOut,
  output [15:0] immediate,
  output [25:0] jumpf, 
  
  output RegDst, RegWrite, ALUSrc,
  output MemtoReg, MemRead, MemWrite,
  output Branch, jump, lui,
  output [2:0] ALUControl,
  output [31:0] SignExtendedInstruction, 
  output [31:0] ReadData1,ReadData2
    );
	 
	 wire[5:0] operationcode;
	 wire [5:0]functionn;
	 wire[4:0] rd, rs, rt, shamt;
	 wire [15:0] immed;
	 wire [31:0]SignExtInst,RS,RT;
	 
	 wire RegDstW, RegWriteW, ALUSrcW;
    wire MemtoRegW, MemReadW, MemWriteW;
    wire BranchW, jumpW, luiW;
    wire [2:0] ALUControlW;
	 wire [25:0] jumpfW;
	 
	 
	 reg [31:0]SignExtInstR;
	 
    reg RegDstR, RegWriteR, ALUSrcR;
    reg MemtoRegR, MemReadR, MemWriteR;
    reg BranchR, jumpR, luiR;
    reg [2:0] ALUControlR;
	 reg [31:0] A,B;
	 reg [25:0] jumpfR;
	 

	 
	 
decoder decoding (
    .inst(inst),
    .opcode(operationcode),
    .funct(functionn),
    .rd(rd),
    .rs(rs),
    .rt(rt),
    .shamt(shamt),
    .immediate(immed),
    .jump(jumpfW)
);


SignExtend SignExtend_inst (
   .Instruction(immed),
   .SignExtendedInstruction(SignExtInst)
);


Control CU (
    .Opcode(operationcode),
    .RegDst(RegDstW),
    .RegWrite(RegWriteW),
    .ALUSrc(ALUSrcW),
    .MemtoReg(MemtoRegW),
    .MemRead(MemReadW),
    .MemWrite(MemWriteW),
    .Branch(BranchW),
	 .jump(j_labelW),
	 .lui(luiW),
    .ALUControl(ALUControlW)
);


Reg regfile (
    .clk(clk),
    .RegWrite(RegWriteW),
	 .RegDst(RegDstW),
    .ReadReg1(rs),
    .ReadReg2(rt),
    .WriteReg(rd),
    .WriteData(ALUOut),
    .ReadData1(RS),
    .ReadData2(RT)
);



always @(posedge clk)begin
    SignExtInstR<=SignExtInst;
	 RegDstR<=RegDstW;
	 RegWriteR<=RegWriteW;
	 ALUSrcR<=ALUSrcW;
	 MemtoRegR<=MemtoRegW;
	 MemReadR<=MemReadW;
	 MemWriteR<=MemWriteW;
	 BranchR<=BranchW;
	 jumpR<=jumpW;
	 luiR<=luiW;
	 ALUControlR<=ALUControlW;
	 A<=RS;
	 B<=RT;
	 jumpfR<=jumpfW;
	 
end

assign SignExtInst=SignExtInstR;
assign RegDst=RegDstR;
assign RegWrite=RegWriteR;
assign ALUSrc=ALUSrcR;
assign MemtoReg=MemtoRegR;
assign MemRead=MemReadR;
assign MemWrite=MemWriteR;
assign Branch=BranchR;
assign jump=jumpR;
assign lui=luiR;
assign ALUControl=ALUControlR;
assign ReadData1=A;
assign ReadData2=B;
assign jumpf=jumpW;

endmodule	
