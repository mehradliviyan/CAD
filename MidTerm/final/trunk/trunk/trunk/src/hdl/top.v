module top
#(
    parameter RES_SIZE = 32,
    parameter IN_SIZE = 8,
    parameter ACC_SIZE = 3
)
(
    input clk,
    input rst,
    input start,
    input [ACC_SIZE-1:0] N,
    input [IN_SIZE-1:0] x_i,
    output [RES_SIZE-1:0] result,
    output ready,
    output valid,
    output error,
    output overflow
);

wire checkRollBack;
wire rollBack;
wire en_count;
wire [ACC_SIZE-1:0] checkCount;
wire [ACC_SIZE-1:0] lastCount;

datapath
#(
    .RES_SIZE(RES_SIZE),
    .IN_SIZE(IN_SIZE),
    .ACC_SIZE(ACC_SIZE)
)
DP
(
    .clk(clk),
    .rst(rst),
    .rollBack(rollBack),
    .en_count(en_count),
    .x_i(x_i),
    .selectStage(N),
    .checkRollBack(checkRollBack),
    .checkCount(checkCount),
    .result(result),
    .lastCount(lastCount),
    .overflow(overflow)
);


controller
#(
    .RES_SIZE(RES_SIZE),
    .IN_SIZE(IN_SIZE),
    .ACC_SIZE(ACC_SIZE)
)
cont
(
    .clk(clk),
    .rst(rst),
    .checkRollBack(checkRollBack),
    .overflow(overflow),
    .N(N),
    .start(start),
    .checkCount(checkCount),
    .lastCount(lastCount),
    .x_i(x_i),
    .rollBack(rollBack),
    .ready(ready),
    .valid(valid),
    .en_count(en_count),
    .error(error)
);



endmodule