`timescale 1ns/1ns
module TB ();
    localparam ACC_SIZE = 3;
    localparam RES_SIZE = 32;
    localparam IN_SIZE = 8;
    reg clk , rst , start;
    reg [ACC_SIZE-1:0] N;
    reg [IN_SIZE-1:0] x_i;
    wire [RES_SIZE-1:0] result;
    wire ready;
    wire valid;
    wire error;
    wire overflow;
    top
    #(
        .RES_SIZE(RES_SIZE),
        .IN_SIZE(IN_SIZE),
        .ACC_SIZE(ACC_SIZE)
    )
    UUT
    (
        .clk(clk),
        .rst(rst),
        .start(start),
        .N(N),
        .x_i(x_i),
        .result(result),
        .ready(ready),
        .valid(valid),
        .error(error),
        .overflow(overflow)
    );
    always  begin
        #5 clk = ~clk;
    end
    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        N = 7;
        x_i = 8'b00100000;
        #100 rst = 0;
        #100 start = 1;
        #100 start = 0;
        #6 x_i = 8'b01000000;
        #6 x_i = 8'b00010000;
        #6 x_i = 8'b00100000;
        #10 x_i = 8'b00110000;
        #10000 $stop;
    end
    
endmodule