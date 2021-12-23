module MIPS_wrapper(
	//////////// CLOCK //////////
	input 		          		MAX10_CLK1_50,
	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// HEX //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// SW //////////
	input 		     [9:0]		SW
);
//Internal Signals declaration
wire CLK1s, MCLK, RST, CE;
wire [23:0] Port;

//Assigns for the internal signals
assign MCLK = MAX10_CLK1_50;
assign LEDR[9] = CLK1s;
assign RST = SW[9];
assign CE = SW[8];

//Module instantiation
one_sec_clk CLK_U0(
	.mclk(MCLK), 
	.reset(RST),
	.Enable(CE),
	.CLKout(CLK1s)
);

MIPS_Multi_Cycle MIPS_U1(
    .clk(CLK1s),
    .reset(RST),
    .GPIO_i(SW[7:0]),
    .GPIO_o(LEDR[7:0]),
	.GPIO_o_hex(Port)
);

//Displays for Output port
hex_7seg Hex_0(.IN(Port[3:0]), .OUT(HEX0));
hex_7seg Hex_1(.IN(Port[7:4]), .OUT(HEX1));

hex_7seg Hex_2(.IN(Port[11:8]), .OUT(HEX2));
hex_7seg Hex_3(.IN(Port[15:12]), .OUT(HEX3));

hex_7seg Hex_4(.IN(Port[19:16]), .OUT(HEX4));
hex_7seg Hex_5(.IN(Port[23:20]), .OUT(HEX5));

endmodule
