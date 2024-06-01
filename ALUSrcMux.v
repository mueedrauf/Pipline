`timescale 1ns / 1ps
module ALUSrcMux(
    input [31:0] regt,     
    input [31:0] regi,     
    input ALUSrc,       
    output wire [31:0] mux_out 
);
reg [31:0] mux_out_reg;
always @* begin
    if (ALUSrc == 0) begin
        mux_out_reg = regt;  
    end else begin
        mux_out_reg = regi;  
    end
end
assign mux_out = mux_out_reg;

endmodule
