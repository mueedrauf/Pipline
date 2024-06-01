`timescale 1ns / 1ps

module SevSegDisplay(
output reg [6:0] seg,
output reg [3:0] an,
input [15:0] ALU_res,  
input clk_100MHz
    );

parameter ZERO = 7'b1000000;
parameter ONE = 7'b1001111;
parameter TWO = 7'b0100100;
parameter THREE = 7'b0110000;
parameter FOUR = 7'b0011001;
parameter FIVE = 7'b0010010;
parameter SIX = 7'b0000010;
parameter SEVEN = 7'b1111000;
parameter EIGHT = 7'b0000000;
parameter NINE = 7'b0010000;
parameter A = 7'b0001000;
parameter B = 7'b0000011;
parameter C = 7'b1000110;
parameter D = 7'b0100000;
parameter E = 7'b0000110;
parameter F = 7'b0001110;

wire[3:0] res_1, res_2, res_3, res_4;

assign res_1 = ALU_res[3:0];
assign res_2 = ALU_res[7:4];
assign res_3 = ALU_res[11:8];
assign res_4 = ALU_res[15:12];

reg [1:0] an_sel = 0;
reg [16:0] anode_timer = 0;

//Clock Divider
always @ (posedge clk_100MHz)
begin
	if(anode_timer == 99_999) //Clock of 100MHz has time period of 10ns. 10ns x 100_000 = 1ms
	begin
		anode_timer <= 0;
		an_sel <= an_sel + 1;
	end
	else
		anode_timer <= anode_timer+1;
end

always @(an_sel)
begin
	case(an_sel)
		2'b00: an = 4'b1110; //Turn on ones digit (rightmost)
		2'b01: an = 4'b1101; //Turn on tens digit
		2'b10: an = 4'b1011; //Turn on hundreds digit
		2'b11: an = 4'b0111; //Turn on thousands digit (leftmost)
	endcase
end

always @ (*)
begin
	case(an_sel)
		2'b00:
			begin
				case(res_1)
					4'd0: seg = ZERO;
					4'd1: seg = ONE;
					4'd2: seg = TWO;
					4'd3: seg = THREE;
					4'd4: seg = FOUR;
					4'd5: seg = FIVE;
					4'd6: seg = SIX;
					4'd7: seg = SEVEN;
					4'd8: seg = EIGHT;
					4'd9: seg = NINE;
					4'd10: seg = A;
					4'd11: seg = B;
					4'd12: seg = C;
					4'd13: seg = D;
					4'd14: seg = E;
					4'd15: seg = F;
				endcase
			end
		2'b01:
			begin
				case(res_2)
					4'd0: seg = ZERO;
					4'd1: seg = ONE;
					4'd2: seg = TWO;
					4'd3: seg = THREE;
					4'd4: seg = FOUR;
					4'd5: seg = FIVE;
					4'd6: seg = SIX;
					4'd7: seg = SEVEN;
					4'd8: seg = EIGHT;
					4'd9: seg = NINE;
					4'd10: seg = A;
					4'd11: seg = B;
					4'd12: seg = C;
					4'd13: seg = D;
					4'd14: seg = E;
					4'd15: seg = F;
				endcase
			end
		2'b10:
			begin
				case(res_3)
					4'd0: seg = ZERO;
					4'd1: seg = ONE;
					4'd2: seg = TWO;
					4'd3: seg = THREE;
					4'd4: seg = FOUR;
					4'd5: seg = FIVE;
					4'd6: seg = SIX;
					4'd7: seg = SEVEN;
					4'd8: seg = EIGHT;
					4'd9: seg = NINE;
					4'd10: seg = A;
					4'd11: seg = B;
					4'd12: seg = C;
					4'd13: seg = D;
					4'd14: seg = E;
					4'd15: seg = F;
				endcase
			end
		2'b11:
			begin
				case(res_4)
					4'd0: seg = ZERO;
					4'd1: seg = ONE;
					4'd2: seg = TWO;
					4'd3: seg = THREE;
					4'd4: seg = FOUR;
					4'd5: seg = FIVE;
					4'd6: seg = SIX;
					4'd7: seg = SEVEN;
					4'd8: seg = EIGHT;
					4'd9: seg = NINE;
					4'd10: seg = A;
					4'd11: seg = B;
					4'd12: seg = C;
					4'd13: seg = D;
					4'd14: seg = E;
					4'd15: seg = F;
				endcase
			end
	endcase
end

endmodule

