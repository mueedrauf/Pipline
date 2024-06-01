`timescale 1ns / 1ps
module Top(    //input clk_V10,
	 input clk,
    input rst
	 //output [6:0] seg,
	 //output [3:0] an
    ); 

wire [31:0] pcout;
wire [5:0] operationcode;
wire[5:0] functionn;
wire [4:0] rd, rs, rt, shamt;
wire [15:0] immed;
wire [25:0] j_field;
wire [31:0] inst;
wire [31:0] SignExtInstruction;
wire RegDst, RegWrite, ALUSrc, MemtoReg, MemRead, MemWrite, Branch,lui;
wire[2:0] ALUControl;
wire [31:0] RT, RS, mux_out, DataOut, SignExtInst;
wire Zero;
wire [31:0] res;
wire [15:0] SevSegArray;

wire [31:0] luifield;

	 
PC uut1 (
    .clk(clk),
    .rst(rst),
	 .j_label(j_label),
	 .b_label(Branch),
	 .b_address(immed),
	 .zero(Zero),
	 .j_address(j_field),
    .PC_out(pcout)
);

InstructionMem uut2 (
    .address(pcout),
    .instruction(inst)
);	

decoder uut3 (
    .inst(inst),
    .opcode(operationcode),
    .funct(functionn),
    .rd(rd),
    .rs(rs),
    .rt(rt),
    .shamt(shamt),
    .immediate(immed),
    .jump(j_field)
);

SignExtend SignExtend_inst (
   .Instruction(immed),
   .SignExtendedInstruction(SignExtInst)
);


Control uut4 (
    .Opcode(operationcode),
    .RegDst(RegDst),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
	 .jump(j_label),
	 .lui(lui),
    .ALUControl(ALUControl)
);



Reg uut5 (
    .clk(clk),
    .RegWrite(RegWrite),
	 .RegDst(RegDst),
    .ReadReg1(rs),
    .ReadReg2(rt),
    .WriteReg(rd),
    .WriteData(DataOut),
    .ReadData1(RS),
    .ReadData2(RT)
);

ALUSrcMux ALUSrcMux_inst (
    .regt(RT),
    .regi(SignExtInst),
    .ALUSrc(ALUSrc),
    .mux_out(mux_out)
);


ALU uut6 (
    .ALUCt(ALUControl),
    .A(RS),
    .B(mux_out),
    .ALUOut(res)
);

assign Zero = (res == 0);

dataMem uut7 (
    .Address(res),
    .WriteData(RT),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .MemToReg(MemToReg),
	 .lui(lui),
	 .luifield(luifield),
    .DataOut(DataOut)
);

assign SevSegArray = {pcout[3:0], RS[3:0], mux_out[3:0], res[3:0]};

uppershift uut9(
.lui(lui),
.zero(Zero),
.RT(RT),
.immed(immed),
.out(luifield)
);

/*SevSegDisplay uut8 (
	.seg(seg),
	.an(an),
	.ALU_res(SevSegArray),
	.clk_100MHz(clk_V10)
);*/

endmodule
