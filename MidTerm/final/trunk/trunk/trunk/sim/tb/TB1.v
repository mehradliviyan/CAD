`timescale 1ns/1ns
module	TB1();
	reg clk=1'b0, rst = 1'b0, start = 1'b0;
    wire ready, valid, overflow, error;
    wire [31:0] Y;
    reg [7:0] X;
    reg [2:0] N;
    top
    #(
        .RES_SIZE(32),
        .IN_SIZE(8),
        .ACC_SIZE(3)
    )
    UUT
    (
        .clk(clk),
        .rst(rst),
        .start(start),
        .N(N),
        .x_i(X),
        .result(Y),
        .ready(ready),
        .valid(valid),
        .error(error),
        .overflow(overflow)
    );
	initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

	initial begin
        #10 rst = 1;
        #10 rst = 0;
        #10 start = 0;
        #10 start = 1;
        N = 3'd7;
        #10 X = 8'h06;
        #10 X = 8'b11000000;
        #10 X = 8'b00100000;
        #10 X = 8'b00010000;
        #10
        #10
        #10
        #10
        #10 X = 8'b01111111;
        #10 X = 8'b11000000;
        #10 X = 8'b00100000;
        #10 X = 8'b00010000;
        #10
        #10
        #10
        #10
        #10 X = 8'b01111111;
        #10 X = 8'b11000000;
        #10 X = 8'b00100000;
        #10 X = 8'b10011001;
        #10
        #10
        #10
        #10
        #80;
	$stop;
	
	end
endmodule

