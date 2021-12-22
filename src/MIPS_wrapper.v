module MIPS_wrapper(
	//////////// CLOCK //////////
	input 		          		MAX10_CLK1_50,
	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);
//Internal Signals declaration
wire CLK1s, MCLK, RST, CE;

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
    .GPIO_o(LEDR[7:0])
);


endmodule
