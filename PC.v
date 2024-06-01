`timescale 1ns / 1ps

module PC (
    input clk,
    input rst,
	 input j_label,
	 input b_label,
	 input zero,
	 input [15:0] b_address,
	 input [25:0]j_address,
	 output [31:0]PC_out
);

reg [31:0]PC;
initial begin 
PC=-1;
end

wire [31:0] jumpaddress={6'b000000, j_address[25:0]};
wire [31:0] branchaddress={6'b000000, b_address[15:0]};


always @ (posedge clk or posedge rst) begin
    if (rst) begin
        PC <= 0;
		  end
	 else if (j_label) begin
			PC<= jumpaddress;
	 end
	 else if(b_label && zero) begin
			PC<=branchaddress;
	 end
    else begin
        PC <= PC+ 1; 
    end
	 
	 
end

assign PC_out = PC;



endmodule

