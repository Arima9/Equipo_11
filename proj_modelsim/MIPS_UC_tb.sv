`timescale 1ns/1ns
module MIPS_UC_tb();
logic CLK = 1'b0, RST = 1'b0;
logic [7:0] GPIO_o_tb;
// enum logic {addi, add} INST;
// enum logic [2:0] {UNKNOWN, IF, ID, EX, ME, WB} STATE;

MIPS_Multi_Cycle DUT(
    .clk(CLK),
    .reset(RST),
    .GPIO_o(GPIO_o_tb)
    );

//Clock signal generator
initial forever #5 CLK = ~CLK;

initial
fork
    #6 RST = 1'b1;
    begin
        #165;
        $display("La simulacion ha terminado...");
        $display("Numero de ciclos de reloj utilizados %d", $time/5);
        $stop(2);
    end
join



endmodule