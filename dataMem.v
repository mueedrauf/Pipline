`timescale 1ns / 1ps

module dataMem (
  input [31:0] Address,
  input [31:0] WriteData,
  input [31:0] luifield,
  input MemWrite,
  input MemRead,
  input MemToReg,
  input lui,
  output reg [31:0] DataOut
);

  // Internal memory declaration
  reg [31:0] data [31:0];
  integer i;
  
  reg [31:0] readfield;


  // Initialize all memory locations to 0 during module instantiation
  initial begin
      data[0] <= 32'b00000000000000000000000000000000;
		data[1] <= 32'b00000000000000000000000000000000;
		data[2] <= 32'b00000000000000000000000000000000;
		data[3] <= 32'b00000000000000000000000000000000;
		data[4] <= 32'b00000000000000000000000000000000;
		data[5] <= 32'b00000000000000000000000000000000;
		data[6] <= 32'b00000000000000000000000000000000;
		data[10] <= 32'b00000000000000000000000000000000;
		data[11] <= 32'b00000000000000000000000000000000;
		data[12] <= 32'b00000000000000000000000000000000;
		data[13] <= 32'b00000000000000000000000000000000;
		data[14] <= 32'b00000000000000000000000000000000;
		data[15] <= 32'b00000000000000000000000000000000;
		data[16] <= 32'b00000000000000000000000000000000;
		data[17] <= 32'b00000000000000000000000000000000;
		data[18] <= 32'b00000000000000000000000000000000;
  end

  // Combinational logic for read, write, and output selection
  always @* begin
  
  	 if (MemRead) begin
      readfield <= data[Address];
    end 
	 
    if (MemWrite) begin
      data[Address] <= WriteData;
    end 
	 
	 
	 
	 if(MemToReg)begin
	   DataOut <= readfield;
	 end
	 
	 else if (lui) begin
	   DataOut<=luifield;
	 end

	 else begin  // Handle read operation
      DataOut <= Address;
    end
	 
  end

endmodule