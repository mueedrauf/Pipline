`timescale 1ns / 1ps

module InstructionMem (
input [31:0] address,
output [31:0] instruction
    );
reg [31:0]instruct;
reg [31:0] memory [100:0];

initial begin
	memory[0] = 32'b000010_00000_00001_00111_000000_00000;    // simple r type 1+2
	memory[1] = 32'b000010_00010_00111_00011_000000_00000;    // simple r type 3+3
	memory[2] = 32'b000010_00000_00011_00000_000000_00000;    // simple r type 6+2
	memory[3] = 32'b010110_00001_00011_0000000000000101;      //   brach to 5
	memory[4] = 32'b111010_00010_00000_0000000000000001;      // not executed
	memory[5] = 32'b101110_00101_00110_1111111111111111;    //simple r type
	memory[6] = 32'b011010_00010_00000_0000000000000001;      // lw from (rt=2 + 2= 4th of =0)to 0th address
	memory[7] = 32'b100000_00000_00000_00000_000000_01001;    // jump to ninth
	memory[8] = 32'b000010_00010_00000_00011_000000_00000;  
	memory[9] = 32'b111010_00010_00000_0000000000000001;     //sw  from (rt=2 + 2= 4th of =0)to 0th address
	memory[10] = 32'b010110_00001_00001_0000000000000101;       //branch to 5th
end

/*initial begin
$readmemb("Z:/Shared/SSprocessor/rom.txt", memory);
end*/

always @ (address)
begin
	 instruct <= memory[address];
end


assign instruction=instruct;

endmodule

