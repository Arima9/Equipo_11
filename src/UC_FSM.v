module UC_FSM
(
    input CLK,
    input CLR,
    input [5:0] Op,
    input [5:0] Funct,
    output  PCWrite, BranchEq, BranchNeq, IorD, MemWrite, IRWrite,
    RegDst, MemtoReg, RegWrite, ALUSrcA, PCSrc, Jen, SignZero, IntorPeri,
    output [1:0] ALUSrcB,
    output [2:0] ALUControl
);
reg [18:0] Ctrl_signals;

//States for the Instruction Cycle
localparam [2:0] 
    IF = 3'b000,
    ID = 3'b001, 
    EX = 3'b010, 
    MA = 3'b011, 
    WB = 3'b100;

`include "opp_codes_pkg.vh"

//Control signals concatenated to make easier the signal assigns
assign {IntorPeri,SignZero, Jen,    //MS nibble
        PCWrite, BranchEq, BranchNeq, IorD, //Nibble3
        MemWrite, IRWrite, RegDst, MemtoReg,    //Nibble 2
        RegWrite, ALUSrcA, ALUSrcB, //Nible 1
        ALUControl, PCSrc   //lS nibble
        } = Ctrl_signals;

//Secuential block - FSM
reg [2:0] STATE, NEXT;
always @(posedge CLK or negedge CLR) begin
    if (!CLR) STATE <= IF;
    else STATE <= NEXT;
end

//Combinational block
always @(*) begin
    case (STATE)

        IF:begin    //State for Intruction Fetch
            NEXT = ID;
            Ctrl_signals = 'h0_84_10;
        end //End of Instruction fetch state
    
        ID:begin    //State for Instruction Decode
            case (Op)
                'h0:begin
                    NEXT = EX;
                    Ctrl_signals = 'h0;
                end 
                _ori:begin
                    NEXT = EX;
                    Ctrl_signals = 'h2_00_64;
                end
                _beq:begin
                    NEXT = EX;
                    Ctrl_signals = 'h0_00_30;
                end
                _j:begin
                    NEXT = IF;
                    Ctrl_signals = 'h1_80_00;
                end
                default:begin
                    NEXT = EX;
                    Ctrl_signals = 'h0;
                end  
            endcase
        end //End of Instruction Decode, Is it completely necessary?
    
        EX:begin    //State for Instruction Execute
            case (Op)
                'h0:begin //R type instruction
                    NEXT = WB;
                    case (Funct)
                        _add : Ctrl_signals = 'h0_02_40;
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
                        default: Ctrl_signals = 'h0;
                    endcase
                end
                _addi:begin
                    NEXT = WB;
                    Ctrl_signals = 'h0_00_60;
                end
                _ori:begin
                    NEXT = WB;
                    Ctrl_signals = 'h2_00_64;
                end
                _beq:begin
                    NEXT = IF;
                    Ctrl_signals = 'h0_40_4F;
                end
                // _andi:
                
                // _bne :
                // _ll  :
                // _lui :
                // _lw  :
                // _slti:
                // _sw  :
                default: begin
                    NEXT = IF;
                    Ctrl_signals = 'h0;
                end
                
            endcase

        end //End of Instruction Execute state

        // MA:      //State dedicated for Memory Access
    
        WB:begin    //State for Write Back information
            case (Op)
                'h0:begin //R type instruction
                    NEXT = IF;
                    case (Funct)
                        _add : Ctrl_signals = 'h0_02_80;
                        // _and :
                        // _jr  :
                        // _nor :
                        // _or  :
                        // _slt :
                        // _sll :
                        // _srl :
                        // _sub :
                        default: Ctrl_signals = 'h0;
                    endcase
                end
                _addi:begin
                    NEXT = IF;
                    Ctrl_signals = 'h0_00_80;
                end
                _ori :begin
                    NEXT = IF;
                    Ctrl_signals = 'h4_00_80;
                end
                // _andi:
                // _ll  :
                // _lui :
                // _lw  :
                
                // _slti:
                // _sw  :
                default: begin
                    NEXT = IF;
                    Ctrl_signals = 'h0;
                end
                
            endcase

        end //End for Write Back State

    endcase //Case to identify the current State of the UC

end //Always for Combinational Logic

endmodule
