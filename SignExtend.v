`timescale 1ns / 1ps
module SignExtend(
    input [15:0] Instruction,
    output wire [31:0] SignExtendedInstruction
);

    reg [31:0] SignExtendedInstruction_reg;
    wire sign_bit;

    assign sign_bit = Instruction[15];
    
    always @* begin
        if (sign_bit == 1'b0) begin
            // Positive number, extend with zeros
            SignExtendedInstruction_reg = {16'b0, Instruction}; // Concatenate 16 zeros with the input instruction
        end else begin
            // Negative number, extend with ones
            SignExtendedInstruction_reg = {16'b1, Instruction}; // Concatenate 16 ones with the input instruction
        end
    end
    
    assign SignExtendedInstruction = SignExtendedInstruction_reg;

endmodule
