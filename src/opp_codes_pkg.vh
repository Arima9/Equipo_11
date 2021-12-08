//Hex Values for the mnemonics of the instructions
localparam [5:0]
    //R type instructions
    _add    = 'h20,
    _and    = 'h24,
    _jr     = 'h8,
    _nor    = 'h27,
    _or     = 'h25,
    _slt    = 'h2a,
    _sll    = 'h0,
    _srl    = 'h2,
    _sub    = 'h23,

    //I type instructions
    _addi   = 'h8,
    _andi   = 'hc,
    _beq    = 'h4,
    _bne    = 'h5,
    _ll     = 'h30,
    _lui    = 'hf,
    _lw     = 'h23,
    _ori    = 'hd,
    _slti   = 'ha,
    _sw     = 'h2b;
    
