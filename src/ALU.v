module ALU 
#(
	parameter WIDTH = 8
)(
	//Inputs
	input			[WIDTH-1:0]		A_in, B_in,
	input			[2:0]			select,
	//Outputs
	output							Z,
	output reg		[WIDTH-1:0]		ALUres	
);		 // ARITHMETIC UNIT
wire [4:0] shampt;

assign Z = (ALUres == 'h0)? 1'b1: 1'b0;
assign shampt = B_in[10:6];

always @(*) begin
	case (select)
		4'b000:	ALUres = A_in + B_in;
		4'b001:	ALUres = A_in & B_in;
		4'b010:	ALUres = A_in | B_in;
		4'b011:	ALUres = ~(A_in | B_in);
		4'b100:	ALUres = (A_in < B_in) ? 'b1: 'b0; 
		4'b101:	ALUres = A_in << shampt;
		4'b110:	ALUres = A_in >> shampt;
		4'b111:	ALUres = A_in - B_in;
	endcase
end

endmodule
