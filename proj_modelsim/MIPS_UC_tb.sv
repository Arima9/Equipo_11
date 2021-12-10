`timescale 1ns/1ns
module MIPS_UC_tb();
logic CLK = 1'b0, RST = 1'b0;
logic [7:0] GPIO_o_tb;
enum {UK,IF,ID,EX,MA,WB} UC_STATE;
// enum logic {addi, add} INST;
// enum logic [2:0] {UNKNOWN, IF, ID, EX, ME, WB} STATE;

MIPS_Multi_Cycle DUT(
    .clk(CLK),
    .reset(RST),
    .GPIO_o(GPIO_o_tb)
    );

//Clock signal generator
initial forever #5 CLK = ~CLK;



initial begin
    forever @(DUT.UC_U15.STATE)begin
        #0.2;
        if(DUT.UC_U15.STATE == 0)   UC_STATE = IF;
        else if(DUT.UC_U15.STATE == 1)   UC_STATE = ID;
        else if(DUT.UC_U15.STATE == 2)   UC_STATE = EX;
        else if(DUT.UC_U15.STATE == 3)   UC_STATE = MA;
        else if(DUT.UC_U15.STATE == 4)   UC_STATE = WB;
    end
end


initial
fork
    UC_STATE = UK;
   #6 RST = 1'b1;
    begin
        #244;
        $display("La simulacion ha terminado...");
        $display("Numero de ciclos de reloj utilizados %d", $time/5);
        $stop(2);
    end
join



endmodule
