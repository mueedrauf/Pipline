`timescale 1ns / 1ps

module Control (
  input [5:0] Opcode,
  
  output RegDst, RegWrite, ALUSrc,
  output MemtoReg, MemRead, MemWrite,
  output Branch, jump, lui,
  output [2:0] ALUControl
);

  reg RegDstR, RegWriteR, ALUSrcR;
  reg MemtoRegR, MemReadR, MemWriteR;
  reg BranchR, jumpR, luiR;
  reg [2:0] ALUControlR;


  function [2:0] fetchALUControl;
    input [2:0] Opcode;
    begin
      case(Opcode)
        3'b000: fetchALUControl = 3'b000; // Example mapping for opcode 000
        3'b001: fetchALUControl = 3'b001; // Example mapping for opcode 001
        3'b010: fetchALUControl = 3'b010; // Example mapping for opcode 010
        3'b110: fetchALUControl = 3'b110; // Example mapping for opcode 110
        3'b111: fetchALUControl = 3'b111; // Example mapping for opcode 111
        default: fetchALUControl = 3'b000; // Default value
      endcase
    end
  endfunction

  // Assign outputs based on Opcode
always @(*) begin
    case(Opcode[5:3])
        3'b010: begin //i type //beq //2
            RegDstR     <= 0;
            ALUSrcR     <= 0;
            MemtoRegR   <= 1;
            RegWriteR   <= 1;
            MemReadR    <= 1;
            MemWriteR   <= 0;
            BranchR     <= 1;
            jumpR       <= 0;
            ALUControlR <= fetchALUControl(Opcode[2:0]);
				luiR        <= 0;
        end
        3'b100: begin //jump //4
            RegDstR     <= 1'bx;
            ALUSrcR     <= 0;
            MemtoRegR   <= 1'bx;
            RegWriteR   <= 0;
            MemReadR    <= 0;
            MemWriteR   <= 0;
            BranchR     <= 1'bx;
            jumpR       <= 1;
            ALUControlR <= fetchALUControl(Opcode[2:0]);
				luiR        <= 0;
        end
        3'b000: begin //R type //0
            RegDstR     <= 1;
            ALUSrcR     <= 0;
            MemtoRegR   <= 0;
            RegWriteR   <= 1;
            MemReadR    <= 0;
            MemWriteR   <= 0;
            BranchR     <= 0;
            jumpR       <= 0;
            ALUControlR <= fetchALUControl(Opcode[2:0]);
				luiR        <= 0;
        end
        3'b011: begin //i type load word //3
            RegDstR     <= 0;
            ALUSrcR     <= 1;
            MemtoRegR   <= 1;
            RegWriteR   <= 1;
            MemReadR    <= 1;
            MemWriteR   <= 0;
            BranchR     <= 0;
            jumpR       <= 0;
            ALUControlR <= fetchALUControl(Opcode[2:0]);
				luiR        <= 0;
        end
        3'b111: begin //i type store word //7
            RegDstR     <= 0;
            ALUSrcR     <= 1;
            MemtoRegR   <= 0;
            RegWriteR   <= 1;
            MemReadR    <= 0;
            MemWriteR   <= 1;
            BranchR     <= 0;
            jumpR       <= 0;
            ALUControlR <= fetchALUControl(Opcode[2:0]);
				luiR        <= 0;
        end
        3'b101: begin //i type inst //5
            RegDstR     <= 0;
            ALUSrcR     <= 1'b0;
            MemtoRegR   <= 0;
            RegWriteR   <= 1;
            MemReadR    <= 0;
            MemWriteR   <= 0;
            BranchR     <= 0;
            jumpR       <= 0;
            ALUControlR <= fetchALUControl(Opcode[2:0]);
				luiR        <= 1;
        end
        default: begin // Default case for unknown Opcodes
            RegDstR     <= 1'bx;
            ALUSrcR     <= 1'bx;
            MemtoRegR   <= 1'bx;
            RegWriteR   <= 1'bx;
            MemReadR    <= 1'bx;
            MemWriteR   <= 1'bx;
            BranchR     <= 1'bx;
            ALUControlR <= 3'bxxx;
				luiR        <= 1'bx;
        end
    endcase
end

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

endmodule