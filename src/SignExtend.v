module SignExtend(
    input       [15:0]  Imm,
    input               SignZero,
    output      [31:0]  ExtImm
);

/***********        SignExtender description                          ***********/
assign ExtImm = SignZero? {16'b0,Imm} : {{16{Imm[15]}}, Imm};

endmodule
