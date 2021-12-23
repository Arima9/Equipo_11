`timescale 1ns/1ns
module MIPS_UC_tb();
logic CLK = 1'b0, RST = 1'b0;
logic [7:0] GPIO_o_tb, GPIO_i_tb;
enum logic [2:0] {IF = 0, ID = 1, EX = 2, MA = 3, WB = 4} UC_STATE;
`include "Instr_Enum_PKG.svh"

MIPS_Multi_Cycle DUT(
    .clk(CLK),
    .reset(RST),
    .GPIO_o(GPIO_o_tb),
    .GPIO_i(GPIO_i_tb)
);

//Clock signal generator
initial forever #5 CLK = ~CLK;



initial begin//TB initial
//Init sequence
    #2 RST = 1'b1;
    #2 RST = 1'b0;
    #2 RST = 1'b1;

fork
    GPIO_i_tb = 'hFF;
    #1500 GPIO_i_tb = 'h0; 

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
            //'h : INSTR = _;
            'h0:begin //R type instruction
                case (DUT.UC_U15.Funct)
                    'h20 : INSTR = _add;
                    'h8  : INSTR = _jr;
                    // _addu:
                    // _and :
                    // _nor :
                    // _or  :
                    // _slt :
                    // _sltu:
                    // _sll :
                    // _srl :
                    // _sub :
                    // _subu:
                    default: INSTR = _nop;
                endcase
            end
            'h8:    INSTR = _addi;
            'h9:    INSTR = _addiu;
            'hd:    INSTR = _ori;
            'ha:    INSTR = _slti;
            'h4:    INSTR = _beq;
            'h23:   INSTR = _lw;
            'h2b:   INSTR = _sw;
            'h2:    INSTR = _j;
            'h3:    INSTR = _jal;
            'h1C:   INSTR = _mul;
            'hf:    INSTR = _lui;
            // _andi:
            // _bne :
            // _ll  :

            // _lw  :
            // _slti:
            // _sw  :
            default:INSTR = _nop;
        endcase
    end

join
end

endmodule
