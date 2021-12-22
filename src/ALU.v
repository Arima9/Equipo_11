module ALU 
#(
	parameter WIDTH = 8
)(
	//Inputs
	input	[WIDTH-1:0]		A_in, B_in,
	input	[3:0]			select,
	//Outputs
	output					Z,
	output reg [WIDTH-1:0]		ALUres	
);		 // ARITHMETIC UNIT
wire [4:0] shampt;

assign Z = (ALUres == 'h0)? 1'b1: 1'b0;
assign shampt = B_in[10:6];

always @(*) begin
	case (select)
		4'b0000:	ALUres = A_in + B_in;
		4'b0001:	ALUres = A_in & B_in;
		4'b0010:	ALUres = A_in | B_in;
		4'b0011:	ALUres = ~(A_in | B_in);
		4'b0100:	ALUres = (A_in < B_in) ? 'b1: 'b0; 
		4'b0101:	ALUres = A_in << shampt;
		4'b0110:	ALUres = A_in >> shampt;
		4'b0111:	ALUres = A_in - B_in;
		4'b1000:	ALUres = A_in * B_in;
		default: 	ALUres = A_in + B_in;
	endcase
end

endmodule
