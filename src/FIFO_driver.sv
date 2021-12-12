interface FIFO_signals #(parameter WIDTH = 8)(input clk_wr, clk_rd);
    logic   push, wrclk, wr_rst, full,
    logic   pop, rdclk, rd_rst, empty;
    logic   [WIDTH-1:0] data_in, data_out;
endinterface //FIFO_signals

class FIFO_driver;
    virtual FIFO_signals Inter_FIFO;
    int data_width, FIFO_depth;

    function new(virtual FIFO_signals A, int width, int depth);
        Inter_FIFO = A;
        data_width = width;
        FIFO_depth = depth;
    endfunction //new()

    



endclass //FIFO_driver
