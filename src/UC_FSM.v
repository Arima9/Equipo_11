module UC_FSM
(
    input CLK,
    input CLR,
    input [5:0] Op,
    input [5:0] Funct,
    output  PCWrite, BranchEq, BranchNeq, IorD, MemWrite, IRWrite,
    output  RegDst, MemtoReg, RegWrite, ALUSrcA, PCSrc, Jen, Jal,
    output  SignZero, IntorPeri,
    output [1:0] ALUSrcB,
    output [3:0] ALUControl
);
reg [20:0] Ctrl_signals;

//States for the Instruction Cycle
localparam [2:0] 
    IF = 3'b000,
    ID = 3'b001, 
    EX = 3'b010, 
    MA = 3'b011, 
    WB = 3'b100;
`include "opp_codes_pkg.vh"

//Control signals concatenated to make easier the signal assigns
assign {Jal,
        IntorPeri, SignZero, Jen, PCWrite,          //MS nibble
        BranchEq, BranchNeq, IorD, MemWrite,    //Nibble3
        IRWrite, RegDst, MemtoReg, RegWrite,    //Nibble 2
        ALUSrcA, ALUSrcB, PCSrc,             //Nible 1
        ALUControl                       //lS nibble
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
            Ctrl_signals = 'h01_08_20;
        end //End of Instruction fetch state
    
        ID:begin    //State for Instruction Decode
            case (Op)
                'h0:begin
                    NEXT = EX;
                    case (Funct)
                        _jr:Ctrl_signals = 'h00_00_80;
                        default: Ctrl_signals = 'h0;
                    endcase
                end
                _addi:begin
                    NEXT = EX;
                    Ctrl_signals = 'h00_00_C0;
                end
                _addiu:begin
                    NEXT = EX;
                    Ctrl_signals = 'h00_00_C0;
                end
                _ori:begin
                    NEXT = EX;
                    Ctrl_signals = 'h04_00_C2;
                end
                _slti:begin
                    NEXT = EX;
                    Ctrl_signals = 'h00_00_C4;
                end
                _beq:begin
                    NEXT = EX;
                    Ctrl_signals = 'h00_00_60;
                end
                _j:begin
                    NEXT = IF;
                    Ctrl_signals = 'h03_00_00;
                end
                _jal:begin
                    NEXT = IF;
                    Ctrl_signals = 'h13_01_00;
                end
                _lui:begin
                    NEXT = EX;
                    Ctrl_signals = 'h00_00_C9;
                end
                _lw:begin
                    NEXT = EX;
                    Ctrl_signals = 'h00_22_C0;
                end
                _sw:begin
                    NEXT = EX;
                    Ctrl_signals = 'h00_20_C0;
                end
                _mul:begin
                    NEXT = EX;
                    Ctrl_signals = 'h0;
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
                    case (Funct)
                        _add :begin
                            NEXT = WB;
                            Ctrl_signals = 'h00_04_80;
                        end
                        // _addu:
                        // _and :
                        _jr:begin
                            NEXT = IF;
                            Ctrl_signals = 'h01_00_80;
                        end
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
                    Ctrl_signals = 'h00_00_C0;
                end
                _addiu:begin
                    NEXT = WB;
                    Ctrl_signals = 'h00_00_C0;
                end
                _ori:begin
                    NEXT = WB;
                    Ctrl_signals = 'h04_00_C2;
                end
                _slti:begin
                    NEXT = WB;
                    Ctrl_signals = 'h00_00_C4;
                end
                _beq:begin
                    NEXT = IF;
                    Ctrl_signals = 'h00_80_97;
                end
                _lui:begin
                    NEXT = WB;
                    Ctrl_signals = 'h00_00_C9;
                end
                _lw:begin
                    NEXT = MA;
                    Ctrl_signals = 'h00_22_C0;
                end
                _sw:begin
                    NEXT = WB;
                    Ctrl_signals = 'h00_20_C0;
                end
                _mul:begin
                    NEXT = WB;
                    Ctrl_signals = 'h00_04_88;
                end
                // _andi:
                // _bne :
                // _ll  :
                // _lui :
                default: begin
                    NEXT = WB;
                    Ctrl_signals = 'h0;
                end
            endcase
        end //End of Instruction Execute state

        MA:begin //Memory Access state
            case (Op)
                _lw:begin
                    NEXT = WB;
                    Ctrl_signals = 'h00_22_00;
                end
                default:begin
                    NEXT = IF;
                    Ctrl_signals = 'h0;
                end
            endcase
        end      //State dedicated for Memory Access
    
        WB:begin    //State for Write Back information
            case (Op)
                'h0:begin //R type instruction
                    NEXT = IF;
                    case (Funct)
                        _add : Ctrl_signals = 'h00_05_00;
                        // _and :
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
                    Ctrl_signals = 'h0_01_00;
                end
                _addiu:begin
                    NEXT = IF;
                    Ctrl_signals = 'h0_01_00;
                end
                _ori :begin
                    NEXT = IF;
                    Ctrl_signals = 'h08_01_00;
                end
                _slti:begin
                    NEXT = IF;
                    Ctrl_signals = 'h00_01_00;
                end
                _lui:begin
                    NEXT = IF;
                    Ctrl_signals = 'h00_01_00;
                end
                _lw:begin
                    NEXT = IF;
                    Ctrl_signals = 'h00_03_00;
                end
                _sw:begin
                    NEXT = IF;
                    Ctrl_signals = 'h00_30_00;
                end
                _mul:begin
                    NEXT = IF;
                    Ctrl_signals = 'h00_05_00;
                end
                // _andi:
                // _ll  :
                // _lui :
                default: begin
                    NEXT = IF;
                    Ctrl_signals = 'h0;
                end
            endcase
        end //End of Write Back State
    endcase //Case to identify the current State of the UC
end //Always for Combinational Logic

endmodule
