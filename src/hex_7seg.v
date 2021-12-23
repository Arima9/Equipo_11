module hex_7seg(IN, OUT);
input [3:0] IN;
output reg[7:0] OUT;

always @(IN) begin
	case (IN)
		4'd0:  OUT = 8'b11000000;
		4'd1:  OUT = 8'b11111001;
		4'd2:  OUT = 8'b10100100;
		4'd3:  OUT = 8'b10110000;
		4'd4:  OUT = 8'b10011001;
		4'd5:  OUT = 8'b10010010;
		4'd6:  OUT = 8'b10000010;
		4'd7:  OUT = 8'b11111000;
		4'd8:  OUT = 8'b10000000;
		4'd9:  OUT = 8'b10010000;
		4'd10: OUT = 8'b10001000;
		4'd11: OUT = 8'b10000011;
		4'd12: OUT = 8'b11000110;
		4'd13: OUT = 8'b10100001;
		4'd14: OUT = 8'b10000110;
		4'd15: OUT = 8'b10001110;
		default OUT = 8'b11111111;	
	endcase
end
endmodule
