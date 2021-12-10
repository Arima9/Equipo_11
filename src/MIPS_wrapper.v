module MIPS_wrapper(
    //Inputs
    input MCLK,
    input RST,
    input CE,
    //Outputs
    output outCLK,
    output [7:0] LEDR
);

wire CLK1s;
assign outCLK = CLK1s;

one_sec_clk CLK_U0(
	.mclk(MCLK), 
	.reset(RST),
	.Enable(CE),
	.CLKout(CLK1s)
);

MIPS_Multi_Cycle MIPS_U1(
    .clk(CLK1s),
    .reset(RST),
    .GPIO_o(LEDR)
);


endmodule
