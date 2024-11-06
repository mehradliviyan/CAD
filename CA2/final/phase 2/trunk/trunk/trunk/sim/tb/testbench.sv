`timescale 1ns/1ns

`define HALF_CLK 5
`define CLK (2 * `HALF_CLK)
module testbench();
    parameter BUFFER_WIDTH = 16;
    parameter BUFFER_DEPTH = 8;
    parameter PAR_WRITE = 4;
    parameter PAR_READ = 1;

    reg clk;
    reg rstn;
    reg en, wen, ren, buffer_ready, ready_out, clear, full, empty;
    reg [PAR_WRITE * BUFFER_WIDTH - 1 : 0] din;
    wire [PAR_READ * BUFFER_WIDTH - 1 : 0] dout;
    FIFO
    #(
    .SIZE(BUFFER_WIDTH),
    .MEM_SIZE(BUFFER_DEPTH),
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
        .valid(ready_out),
        .ready(buffer_ready)
    );

    always @(clk)begin
        # `HALF_CLK
        clk <= ~clk;
    end
    
    //for writing
    initial begin
        clk = 0;
        rstn = 0;
        en = 0;
        wen = 0;
        clear = 0;

        #`CLK;
        rstn = 1;
        en = 1;

        #`CLK;
        #`CLK;

        while (!buffer_ready) begin
            #`CLK;
        end
        wen = 1;
        din = {16'd12, 16'd8, 16'd1, 16'd5};
        #`CLK;

        wen = 0;
        while (!buffer_ready) begin
            #`CLK;
        end
        wen = 1;
        din = {16'd120, 16'd130, 16'd150, 16'd170};
        #`CLK;

        wen = 0;
        #`CLK;
        #1000 $stop ;
    end
    
    
    
    //for reading
    initial begin
    ren = 0;
    #`CLK;
    #`CLK;
    #`CLK;
    #`CLK;
    
    ren = 1;
    #`CLK;
    #`CLK;
    ren = 0;
    end

endmodule
