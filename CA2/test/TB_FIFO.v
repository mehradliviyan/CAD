`timescale 1ns/1ns
module TB_FIFO ();
    reg clk, rstn, wen, clear;
    parameter SIZE = 2;
    parameter MEM_SIZE = 4;
    parameter PAR_WRITE = 2;
    parameter PAR_READ = 3;
    parameter ADDRES_SIZE = $clog2(MEM_SIZE);
    reg [ADDRES_SIZE-1:0] waddr;
    reg [ADDRES_SIZE-1:0] raddr;
    reg [PAR_WRITE*SIZE-1:0] din;
    wire [PAR_READ*SIZE-1:0] dout;
    wire empty, full, valid, ready;
    FIFO #(.SIZE(SIZE), .MEM_SIZE(MEM_SIZE), .PAR_WRITE(PAR_WRITE), .PAR_READ(PAR_READ)) circleBuffer (.clk(clk), .rstn(rstn), .clear(clear), .wen(wen), .ren(ren), .din(din), .full(full), .empty(empty), .dout(dout), .valid(valid), .ready(ready));
    always  begin
        #5 clk = ~clk;
    end
    initial begin
        clk = 0;
        rstn = 1;
        waddr = 0;
        wen = 0;
        raddr = 1;
        din = 5;
        #10 rstn = 0;
        #10 rstn = 1;
        #100 wen = 1;
        #100 waddr = 2;
        #110 raddr = 0;
        #1 din = 7;
        #50 waddr = 3;
        #10000 $stop;
    end
    
endmodule