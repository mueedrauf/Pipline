`timescale 1ns / 1ps
module decoder (
  input [31:0] inst,
  output [5:0] opcode,
  output [5:0] funct,
  output [4:0] rd, rs, rt, shamt,
  output [15:0] immediate,
  output [25:0] jump
);

  assign opcode = inst[31:26];

  reg [4:0] rd_reg, rs_reg, rt_reg, shamt_reg;
  reg [5:0] funct_reg;
  reg [15:0] imm;
  reg [25:0] j;

  always @(*) begin
    case (opcode[5:3])
      3'b000: begin // R-type instructions
        funct_reg = inst[5:0];
        shamt_reg = inst[10:6];
        rd_reg = inst[15:11];
        rt_reg = inst[20:16];
        rs_reg = inst[25:21];
      end
      3'b100: begin     //j type
        j = inst[25:0];
      end
      3'b010: begin      //i type
        rt_reg = inst[20:16];
        rs_reg = inst[25:21];
        imm = inst[15:0];
      end
		3'b011: begin       //i type
		  rt_reg = inst[20:16];
        rs_reg = inst[25:21];
        imm = inst[15:0];
		  end
		3'b111:begin         //i type
		  rt_reg = inst[20:16];
        rs_reg = inst[25:21];
        imm = inst[15:0];
		  end
		 3'b101:begin         //i type
		  rt_reg = inst[20:16];
        rs_reg = inst[25:21];
        imm = inst[15:0];
		  end
      default: begin // Non-R-type instructions
        funct_reg = 6'b0;
        shamt_reg = 5'b0;
        rd_reg = 5'b0;
        rt_reg = 5'b0;
        rs_reg = 5'b0;
      end
    endcase
  end

  assign funct = funct_reg;
  assign shamt = shamt_reg;
  assign rd = rd_reg;
  assign rt = rt_reg;
  assign rs = rs_reg;
  assign jump = j;
  assign immediate = imm;

endmodule
