`timescale 1ns/1ns
module TB_FIFO ();
    reg clk, rstn, wen, clear, ren;
    parameter SIZE = 4;
    parameter MEM_SIZE = 5;
    parameter PAR_WRITE = 2;
    parameter PAR_READ = 4;
    reg [PAR_WRITE*SIZE-1:0] din;
    wire [PAR_READ*SIZE-1:0] dout;
    wire empty, full, valid, ready;
    FIFO
    #(
    .SIZE(SIZE),
    .MEM_SIZE(MEM_SIZE),
    .PAR_WRITE(PAR_WRITE),
    .PAR_READ(PAR_READ)
    )
    circleBuffer
    (
        .clk(clk),
        .rstn(rstn),
        .clear(clear),
        .wen(wen),
        .ren(ren),
        .din(din),
        .full(full),
        .empty(empty),
        .dout(dout),
        .valid(valid),
        .ready(ready)
    );
    always  begin
        #5 clk = ~clk;
    end
    initial begin
        clk = 0;
        rstn = 1;
        wen = 0;
        din = 5;
        ren = 0;
        clear = 0;
        #10 rstn = 0;
        #10 rstn = 1;
        #100 wen = 1;
        #10 din = 7;
        #100 ren = 1;
        #100 wen = 0;
        #10000 $stop;
    end
    
endmodule