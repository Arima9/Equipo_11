`timescale 1ns/1ns
module MIPS_UC_tb();
logic CLK = 1'b0, RST = 1'b0;
logic [7:0] GPIO_o_tb, GPIO_i_tb;
enum {UK,IF,ID,EX,MA,WB} UC_STATE;
`include "Instr_Enum_PKG.svh"
// enum logic {addi, add} INST;
// enum logic [2:0] {UNKNOWN, IF, ID, EX, ME, WB} STATE;

MIPS_Multi_Cycle DUT(
    .clk(CLK),
    .reset(RST),
    .GPIO_o(GPIO_o_tb),
    .GPIO_i(GPIO_i_tb)
    );

//Clock signal generator
initial forever #5 CLK = ~CLK;



initial //TB initial
fork
    UC_STATE = UK;
    GPIO_i_tb = 'hFF;
    #1500 GPIO_i_tb = 'h0; 

   #6 RST = 1'b1;
    begin
        #3000;
        $display("La simulacion ha terminado...");
        $display("Numero de ciclos de reloj utilizados %d", $time/10);
        $stop(2);
    end

    //UC state checker
    forever @(DUT.UC_U15.STATE)begin
        if(DUT.UC_U15.STATE == 0)   UC_STATE = IF;
        else if(DUT.UC_U15.STATE == 1)   UC_STATE = ID;
        else if(DUT.UC_U15.STATE == 2)   UC_STATE = EX;
        else if(DUT.UC_U15.STATE == 3)   UC_STATE = MA;
        else if(DUT.UC_U15.STATE == 4)   UC_STATE = WB;
    end

    forever @(DUT.Instr_reg)begin
        case (DUT.UC_U15.Op)
            'h0:begin //R type instruction
                case (DUT.UC_U15.Funct)
                    'h20 : INSTR = _add;
                    // _addu:
                    // _and :
                    // _jr  :
                    // _nor :
                    // _or  :
                    // _slt :
                    // _sltu:
                    // _sll :
                    // _srl :
                    // _sub :
                    // _subu:
                    default: INSTR = _add;
                endcase
            end
            'h8:    INSTR = _addi;
            'hd:    INSTR = _ori;
            'h4:    INSTR = _beq;
            'h2:    INSTR = _j;
            // _andi:
            // _bne :
            // _ll  :
            // _lui :
            // _lw  :
            // _slti:
            // _sw  :
            default:INSTR = _beq;
        endcase
    end

join

endmodule
