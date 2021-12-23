module one_sec_clk
(
	input mclk, 
	input reset,
	input Enable,
	output CLKout
);
					
localparam CUENTA= 	50_000_000;	// Valor para implementar en tarjeta
//localparam CUENTA= 	50;

integer conteo;
reg w1 = 1'b0; 

always@ (negedge reset, posedge mclk)begin 
	if (!reset) conteo <= 0;

	else if (Enable)begin
		if (conteo == CUENTA/2)begin
			conteo <= 0;
			w1 <= ~w1;		
		end
		else conteo <= conteo + 1;
	end
	else conteo <= conteo;
end

assign CLKout = w1;

endmodule
