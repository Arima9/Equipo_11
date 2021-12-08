module SignExtend(
    input       [15:0]  Imm,
    output      [31:0]  ExtImm
);

/***********        SignExtender description                          ***********/
assign ExtImm = {{16{Imm[15]}}, Imm};

endmodule
