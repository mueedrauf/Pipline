`timescale 1ns / 1ps

module display(
 output reg [6:0] seg,
 output reg [3:0] anode,
 input clk,
 input [15:0] binary_data
);
reg [3:0] hex[3:0]; // array to store each 4-bit segment for hexadecimal display
reg [1:0] an_sel = 0; //selection of anode of out of the four displays
reg [16:0] anode_timer = 0;
// convert binary data to individual hexadecimal digits
always @* begin
 hex[3] <= binary_data[15:12];
 hex[2] <= binary_data[11:8];
 hex[1] <= binary_data[7:4];
 hex[0] <= binary_data[3:0];
end
// clock Divider
always @(posedge clk) begin
 if (anode_timer == 99_999) begin
 anode_timer <= 0;
 an_sel <= an_sel + 1;
 end else begin
 anode_timer <= anode_timer + 1;
 end

 case (an_sel)
 2'b00: anode <= 4'b1110; // Turn on ones digit
 2'b01: anode <= 4'b1101; // Turn on tens digit
 2'b10: anode <= 4'b1011; // Turn on hundreds digit
 2'b11: anode <= 4'b0111; // Turn on thousands digit
 endcase
end
// segment Display Logic
always @* begin
 case (an_sel)
 2'b00: seg = get_segment(hex[0]);
 2'b01: seg = get_segment(hex[1]);
 2'b10: seg = get_segment(hex[2]);
 2'b11: seg = get_segment(hex[3]);
 endcase
end
// function to get segment values for each hexadecimal digit
function [6:0] get_segment;
 input [3:0] digit;
 case (digit)
 4'b0000: get_segment = 7'b1000000; // Digit 0
 4'b0001: get_segment = 7'b1111001; // Digit 1
 4'b0010: get_segment = 7'b0100100; // Digit 2
 4'b0011: get_segment = 7'b0110000; // Digit 3
 4'b0100: get_segment = 7'b0011001; // Digit 4
 4'b0101: get_segment = 7'b0010010; // Digit 5
 4'b0110: get_segment = 7'b0000010; // Digit 6
 4'b0111: get_segment = 7'b1111000; // Digit 7
 4'b1000: get_segment = 7'b0000000; // Digit 8
 4'b1001: get_segment = 7'b0010000; // Digit 9
 4'b1010: get_segment = 7'b0001000; // Digit A
 4'b1011: get_segment = 7'b0000011; // Digit B
 4'b1100: get_segment = 7'b1000110; // Digit C
 4'b1101: get_segment = 7'b0100001; // Digit D
 4'b1110: get_segment = 7'b0000110; // Digit E
 4'b1111: get_segment = 7'b0001110; // Digit F
 endcase
endfunction
endmodule
