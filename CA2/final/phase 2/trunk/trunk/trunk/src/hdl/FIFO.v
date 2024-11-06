module FIFO
#(
    parameter SIZE = 16,
    parameter MEM_SIZE = 8,
    parameter PAR_WRITE = 2,
    parameter PAR_READ = 4,
    parameter ADDRES_SIZE = $clog2(MEM_SIZE)
)
(
    input clk,
    input rstn,
    input clear,
    input wen,
    input ren,
    input [SIZE*PAR_WRITE-1:0] din,
    output full,
    output empty,
    output [SIZE*PAR_READ-1:0] dout,
    output valid,
    output ready
);

FIFO_DP #(.SIZE(SIZE), .MEM_SIZE(MEM_SIZE), .PAR_WRITE(PAR_WRITE), .PAR_READ(PAR_READ)) data_path (.clk(clk), .rstn(rstn), .clear(clear), .wen(wen), .ren(ren), .din(din), .full(full), .empty(empty), .dout(dout));
FIFO_CONTROLLER controller(.clk(clk), .rstn(rstn), .wen(wen), .empty(empty), .full(full), .valid(valid), .ready(ready));
endmodule