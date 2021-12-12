//Hex Values for the mnemonics of the instructions
localparam [5:0]
    //R type instructions
    _add    = 'h20,
    _addu   = 'h21,
    _and    = 'h24,
    _jr     = 'h8,
    _nor    = 'h27,
    _or     = 'h25,
    _slt    = 'h2a,
    _sltu   = 'h2b,
    _sll    = 'h0,
    _srl    = 'h2,
    _sub    = 'h23,
    _subu   = 'h23,

    //I type instructions
    _addi   = 'h8,
    _addiu  = 'h9,
    _andi   = 'hc,
    _beq    = 'h4,
    _bne    = 'h5,
    _lbu    = 'h24,
    _lhu    = 'h25,
    _ll     = 'h30,
    _lui    = 'hf,
    _lw     = 'h23,
    _ori    = 'hd,
    _slti   = 'ha,
    _sltiu  = 'hb,
    _sb     = 'h28,
    _sc     = 'h38,
    _sh     = 'h29,
    _sw     = 'h2b,

    //J type instructions
    _j      = 'h2,
    _jal    = 'h3;
    