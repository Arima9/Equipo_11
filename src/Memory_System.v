module Memory_System
#(
    parameter MEMORY_DEPTH = 64,
    DATA_WIDTH = 32
)(
    input Write_Enable_i, CLK, RST,
    input [DATA_WIDTH-1:0] Write_Data,
    input [31:0] Address_i,

    output [DATA_WIDTH-1:0] Read_Data,
    //I/O ports signals
    output [DATA_WIDTH-1:0] OutPort1,
    input [DATA_WIDTH-1:0] InPort1
);

//Wires declarations for data
wire [DATA_WIDTH-1:0] ram_out, rom_out;
//Mux select for the data
reg [1:0] MUXsel;
wire Outen;
//Adress for the memories
wire [$clog2(MEMORY_DEPTH)-1:0] Addr_mems;

//Modules instanciation
ROM_mem
#(
    .WORD(DATA_WIDTH), .DEPTH(MEMORY_DEPTH)
) ROM_U0(
    .ADDR(Addr_mems),
    .DATA_out(rom_out)
);

RAM_mem
#(
    .WORD(DATA_WIDTH), .DEPTH(MEMORY_DEPTH)
) RAM_U0(
    .ADDR(Addr_mems),
    .DATA_in(Write_Data),
    .clk(CLK),
    .we(Write_Enable_i & (MUXsel == 2'b01)),
    .DATA_out(ram_out)
);

MultiplexerUnit
#(    
    .SEL(2), .WORD(DATA_WIDTH)
) MUX_U0(
    .DATAin({OutPort1, InPort1, ram_out, rom_out}),
    .Select(MUXsel),
    .DATAout(Read_Data)
);

RegisterUnit 
#(
    .W(DATA_WIDTH)
)   OutPort(
    .clk(CLK),
    .rst(RST),
    .en(Outen),
    .D(Write_Data),
    .Q(OutPort1)
);

//Selector for the mux of the memories
//If Address_i is higher than or equal to h1001 0000 is pointing to the RAM
//assign MUXsel = (Address_i >= 32'h1001_0000) ? 1'b1 : 1'b0;
//Glue logic of directions decoders
assign Addr_mems = Address_i[$clog2(MEMORY_DEPTH)+1:2];
assign Outen = (MUXsel == 2'b11)? 1'b1: 1'b0;

always @(*)begin
    if (Address_i == 32'h3F_FFC0) MUXsel <= 2'b11;
    else if (Address_i == 32'h3F_FFBC) MUXsel <= 2'b10;
    else if (Address_i >= 32'h1001_0000) MUXsel <= 2'b01;
    else  MUXsel <= 2'b00;
end

endmodule


//Puerto de Salida en la direccion      0x003F_FFC0
//Puerto de Entrada en la direccion     0x003F_FFBC