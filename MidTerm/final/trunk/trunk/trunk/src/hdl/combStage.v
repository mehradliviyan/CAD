module combStage
#(
    parameter RES_SIZE = 32,
    parameter ACC_SIZE = 3
)
(
    input [RES_SIZE-1:0] itemOld,
    input [RES_SIZE-1:0] currentX_i,
    input rollBack_i,
    input [RES_SIZE-1:0] resOld,
    input [ACC_SIZE-1:0] countOld,
    input [RES_SIZE-1:0] cf1,
    input [RES_SIZE-1:0] cf2,
    input isEven,
    input overflowOld,
    input initialSelect,
    output [RES_SIZE-1:0] itemNew,
    output [RES_SIZE-1:0] currentX_o,
    output rollBack_o,
    output [RES_SIZE-1:0] resNew,
    output [ACC_SIZE-1:0] countNew,
    output overflowNew
);


// wires
    wire [2*RES_SIZE-1: 0] mul1Res;
    wire [2*RES_SIZE-1: 0] mul2Res;
    wire [RES_SIZE-1: 0] muxRes;
    wire [RES_SIZE-1: 0] addOrSubVal;


MUX2x1 #(.SIZE(RES_SIZE), .selectSIZE(1)) muxCf (.A(cf1), .B(cf2), .select(rollBack_i), .Y(muxRes));


assign addOrSubVal = mul2Res[(2*RES_SIZE)-2: RES_SIZE-1];
MUL #(.SIZE(RES_SIZE))  mul1 (.A(itemOld), .B(currentX_i), .Y(mul1Res));
MUL #(.SIZE(RES_SIZE))  mul2 (.A(itemNew),  .B(muxRes), .Y(mul2Res));


// output
    addSub #(.SIZE(RES_SIZE)) addOrSub(.A(addOrSubVal), .B(resOld), .select(isEven),  .Y(resNew));
    assign countNew = countOld + 1;
    assign rollBack_o = rollBack_i;
    assign currentX_o = currentX_i;
    MUX2x1 #(.SIZE(RES_SIZE), .selectSIZE(1)) muxInitial (.A(currentX_i), .B(mul1Res[(2*RES_SIZE)-2:RES_SIZE-1]), .select(initialSelect), .Y(itemNew));
    assign overflowNew = overflowOld || ((resOld[RES_SIZE-1] == addOrSubVal[RES_SIZE-1]) && (resOld[RES_SIZE-1] != resNew[RES_SIZE-1]));

endmodule