module datapath
#(
    parameter RES_SIZE = 32,
    parameter IN_SIZE = 8,
    parameter ACC_SIZE = 3
)
(
    input clk,
    input rst,
    input rollBack,
    input en_count,
    input [IN_SIZE-1:0] x_i,
    input [ACC_SIZE-1:0] selectStage,
    output checkRollBack,
    output [ACC_SIZE-1:0] checkCount,
    output [RES_SIZE-1:0] result,
    output [ACC_SIZE-1:0] lastCount,
    output overflow
);

// cfs
    // // cf stage 1
    // wire [RES_SIZE-1:0] cf1;
    // wire [RES_SIZE-1:0] cf5;
    // assign cf1 = {2'b01,{(RES_SIZE-2){1'b0}}};
    // assign cf5 = {32'b00011001100110011001100110011001,{(RES_SIZE-32){1'b0}}};


    // // cf stage 2
    // wire [RES_SIZE-1:0] cf2;
    // wire [RES_SIZE-1:0] cf6;
    // assign cf2 = {3'b001,{(RES_SIZE-3){1'b0}}};
    // assign cf6 = {32'b00010101010101010101010101010101,{(RES_SIZE-32){1'b0}}};

    // // cf stage 3
    // wire [RES_SIZE-1:0] cf3;
    // wire [RES_SIZE-1:0] cf7;
    // assign cf3 = {32'b00101010101010101010101010101010,{(RES_SIZE-32){1'b0}}};
    // assign cf7 = {32'b00010010010010010010010010010010,{(RES_SIZE-32){1'b0}}};



    // // cf stage 4
    // wire [RES_SIZE-1:0] cf4;
    // wire [RES_SIZE-1:0] cf8;
    // assign cf4 = {4'b0001,{(RES_SIZE-4){1'b0}}};
    // assign cf8 = {5'b00001,{(RES_SIZE-5){1'b0}}};

    // // cf stage 1
    // wire [RES_SIZE-1:0] cf1;
    // wire [RES_SIZE-1:0] cf5;
    // assign cf1 = {1'b1,{(RES_SIZE-1){1'b0}}};
    // assign cf5 = {32'b00110011001100110011001100110011,{(RES_SIZE-32){1'b0}}};


    // // cf stage 2
    // wire [RES_SIZE-1:0] cf2;
    // wire [RES_SIZE-1:0] cf6;
    // assign cf2 = {2'b01,{(RES_SIZE-2){1'b0}}};
    // assign cf6 = {32'b00101010101010101010101010101010,{(RES_SIZE-32){1'b0}}};

    // // cf stage 3
    // wire [RES_SIZE-1:0] cf3;
    // wire [RES_SIZE-1:0] cf7;
    // assign cf3 = {32'b01010101010101010101010101010101,{(RES_SIZE-32){1'b0}}};
    // assign cf7 = {32'b00100100100100100100100100100101,{(RES_SIZE-32){1'b0}}};



    // // cf stage 4
    // wire [RES_SIZE-1:0] cf4;
    // wire [RES_SIZE-1:0] cf8;
    // assign cf4 = {3'b001,{(RES_SIZE-3){1'b0}}};
    // assign cf8 = {4'b0001,{(RES_SIZE-4){1'b0}}};

    // cf stage 1
    wire [RES_SIZE-1:0] cf1;
    wire [RES_SIZE-1:0] cf5;
    assign cf1 = {1'b0,{(RES_SIZE-1){1'b1}}};
    assign cf5 = {32'b00110011001100110011001100110011,{(RES_SIZE-32){1'b0}}};


    // cf stage 2
    wire [RES_SIZE-1:0] cf2;
    wire [RES_SIZE-1:0] cf6;
    assign cf2 = {2'b01,{(RES_SIZE-2){1'b0}}};
    assign cf6 = {32'b00101010101010101010101010101010,{(RES_SIZE-32){1'b0}}};

    // cf stage 3
    wire [RES_SIZE-1:0] cf3;
    wire [RES_SIZE-1:0] cf7;
    assign cf3 = {32'b01010101010101010101010101010101,{(RES_SIZE-32){1'b0}}};
    assign cf7 = {32'b00100100100100100100100100100101,{(RES_SIZE-32){1'b0}}};



    // cf stage 4
    wire [RES_SIZE-1:0] cf4;
    wire [RES_SIZE-1:0] cf8;
    assign cf4 = {3'b001,{(RES_SIZE-3){1'b0}}};
    assign cf8 = {4'b0001,{(RES_SIZE-4){1'b0}}};


// wires


    // comb stage 1 to seq stage 1 
    wire [RES_SIZE-1:0] item1;
    wire [RES_SIZE-1:0] currentX1;
    wire rollBack1;
    wire [RES_SIZE-1:0] res1;
    wire [ACC_SIZE-1:0] count1;
    wire overflow1;

    // seq stage 1 to comb stage 2

    wire [RES_SIZE-1:0] item2;
    wire [RES_SIZE-1:0] currentX2;
    wire rollBack2;
    wire [RES_SIZE-1:0] res2;
    wire [ACC_SIZE-1:0] count2;
    wire overflow2;


    // comb stage 2 to seq stage 2
    wire [RES_SIZE-1:0] item3;
    wire [RES_SIZE-1:0] currentX3;
    wire rollBack3;
    wire [RES_SIZE-1:0] res3;
    wire [ACC_SIZE-1:0] count3;
    wire overflow3;


    // seq stage 2 to comb stage 3

    wire [RES_SIZE-1:0] item4;
    wire [RES_SIZE-1:0] currentX4;
    wire rollBack4;
    wire [RES_SIZE-1:0] res4;
    wire [ACC_SIZE-1:0] count4;
    wire overflow4;

    // comb stage 3 to seq stage 3
    wire [RES_SIZE-1:0] item5;
    wire [RES_SIZE-1:0] currentX5;
    wire rollBack5;
    wire [RES_SIZE-1:0] res5;
    wire [ACC_SIZE-1:0] count5;
    wire overflow5;

    // seq stage 3 to comb stage 4

    wire [RES_SIZE-1:0] item6;
    wire [RES_SIZE-1:0] currentX6;
    wire rollBack6;
    wire [RES_SIZE-1:0] res6;
    wire [ACC_SIZE-1:0] count6;
    wire overflow6;

    // comb stage 4 to seq stage 4
    wire [RES_SIZE-1:0] item7;
    wire [RES_SIZE-1:0] currentX7;
    wire rollBack7;
    wire [RES_SIZE-1:0] res7;
    wire [ACC_SIZE-1:0] count7;
    wire overflow7;

    // seq stage 4 to comb stage 1 (maybe)

    wire [RES_SIZE-1:0] item8;
    wire [RES_SIZE-1:0] currentX8;
    wire rollBack8;
    wire [RES_SIZE-1:0] res8;
    wire [ACC_SIZE-1:0] count8;
    wire overflow8;

    // chosen comb stage 1 wire
    wire [RES_SIZE-1:0] item9;
    wire [RES_SIZE-1:0] currentX9;
    wire rollBack9;
    wire [RES_SIZE-1:0] res9;
    wire [ACC_SIZE-1:0] count9;
    wire overflow9;

    // handle comb stage 1 wireing
    MUX2x1 #(.SIZE(RES_SIZE), .selectSIZE(1)) muxItem (.A({1'b0 , {(RES_SIZE-1){1'b1}}}), .B(item8), .select(rollBack), .Y(item9));
    MUX2x1 #(.SIZE(RES_SIZE), .selectSIZE(1)) muxCurrentX(.A({x_i , {RES_SIZE-IN_SIZE{1'b0}}}),.B(currentX8), .select(rollBack), .Y(currentX9));
    MUX2x1 #(.SIZE(RES_SIZE), .selectSIZE(1)) muxRes(.A(0), .B(res8), .select(rollBack), .Y(res9));
    MUX2x1 #(.SIZE(ACC_SIZE), .selectSIZE(1)) muxCount(.A({(ACC_SIZE){1'b1}}), .B(count8), .select(rollBack), .Y(count9));
    MUX2x1 #(.SIZE(1), .selectSIZE(1)) muxOvf(.A(0), .B(overflow8), .select(rollBack), .Y(overflow9));


// stage 1 parts

    combStage
    #(
        .RES_SIZE(RES_SIZE),
        .ACC_SIZE(ACC_SIZE)
    )
    comb1
    (
        .itemOld(item9),
        .currentX_i(currentX9),
        .rollBack_i(rollBack),
        .resOld(res9),
        .countOld(count9),
        .cf1(cf1),
        .cf2(cf5),
        .isEven(0),
        .overflowOld(overflow9),
        .initialSelect(rollBack),
        .itemNew(item1),
        .currentX_o(currentX1),
        .rollBack_o(rollBack1),
        .resNew(res1),
        .countNew(count1),
        .overflowNew(overflow1)
    );



    seqStage
    #(
        .RES_SIZE(RES_SIZE),
        .ACC_SIZE(ACC_SIZE)
    )
    regs1
    (
        .clk(clk),
        .rst(rst),
        .itemOld(item1),
        .currentX_i(currentX1),
        .rollBack_i(rollBack1),
        .resOld(res1),
        .countOld(count1),
        .overflowOld(overflow1),
        .en_count(en_count),
        .selectStage(selectStage),
        .itemNew(item2),
        .currentX_o(currentX2),
        .rollBack_o(rollBack2),
        .resNew(res2),
        .countNew(count2),
        .overflowNew(overflow2)
    );



// stage 2 parts

    combStage
    #(
        .RES_SIZE(RES_SIZE),
        .ACC_SIZE(ACC_SIZE)
    )
    comb2
    (
        .itemOld(item2),
        .currentX_i(currentX2),
        .rollBack_i(rollBack2),
        .resOld(res2),
        .countOld(count2),
        .cf1(cf2),
        .cf2(cf6),
        .isEven(1),
        .overflowOld(overflow2),
        .initialSelect(1),
        .itemNew(item3),
        .currentX_o(currentX3),
        .rollBack_o(rollBack3),
        .resNew(res3),
        .countNew(count3),
        .overflowNew(overflow3)
    );



    seqStage
    #(
        .RES_SIZE(RES_SIZE),
        .ACC_SIZE(ACC_SIZE)
    )
    regs2
    (
        .clk(clk),
        .rst(rst),
        .itemOld(item3),
        .currentX_i(currentX3),
        .rollBack_i(rollBack3),
        .resOld(res3),
        .countOld(count3),
        .overflowOld(overflow3),
        .en_count(en_count),
        .selectStage(selectStage),
        .itemNew(item4),
        .currentX_o(currentX4),
        .rollBack_o(rollBack4),
        .resNew(res4),
        .countNew(count4),
        .overflowNew(overflow4)
    );


// stage 3 parts


    combStage
    #(
        .RES_SIZE(RES_SIZE),
        .ACC_SIZE(ACC_SIZE)
    )
    comb3
    (
        .itemOld(item4),
        .currentX_i(currentX4),
        .rollBack_i(rollBack4),
        .resOld(res4),
        .countOld(count4),
        .cf1(cf3),
        .cf2(cf4),
        .isEven(0),
        .overflowOld(overflow4),
        .initialSelect(1),
        .itemNew(item5),
        .currentX_o(currentX5),
        .rollBack_o(rollBack5),
        .resNew(res5),
        .countNew(count5),
        .overflowNew(overflow5)
    );



    seqStage
    #(
        .RES_SIZE(RES_SIZE),
        .ACC_SIZE(ACC_SIZE)
    )
    regs3
    (
        .clk(clk),
        .rst(rst),
        .itemOld(item5),
        .currentX_i(currentX5),
        .rollBack_i(rollBack5),
        .resOld(res5),
        .countOld(count5),
        .overflowOld(overflow5),
        .en_count(en_count),
        .selectStage(selectStage),
        .itemNew(item6),
        .currentX_o(currentX6),
        .rollBack_o(rollBack6),
        .resNew(res6),
        .countNew(count6),
        .overflowNew(overflow6)
    );



// stage 4 parts

    combStage
    #(
        .RES_SIZE(RES_SIZE),
        .ACC_SIZE(ACC_SIZE)
    )
    comb4
    (
        .itemOld(item6),
        .currentX_i(currentX6),
        .rollBack_i(rollBack6),
        .resOld(res6),
        .countOld(count6),
        .cf1(cf4),
        .cf2(cf8),
        .isEven(1),
        .overflowOld(overflow6),
        .initialSelect(1),
        .itemNew(item7),
        .currentX_o(currentX7),
        .rollBack_o(rollBack7),
        .resNew(res7),
        .countNew(count7),
        .overflowNew(overflow7)
    );



    seqStage
    #(
        .RES_SIZE(RES_SIZE),
        .ACC_SIZE(ACC_SIZE)
    )
    regs4
    (
        .clk(clk),
        .rst(rst),
        .itemOld(item7),
        .currentX_i(currentX7),
        .rollBack_i(rollBack7),
        .resOld(res7),
        .countOld(count7),
        .overflowOld(overflow7),
        .en_count(en_count),
        .selectStage(selectStage),
        .itemNew(item8),
        .currentX_o(currentX8),
        .rollBack_o(rollBack8),
        .resNew(res8),
        .countNew(count8),
        .overflowNew(overflow8)
    );



// output part

    MUX4x1 #(.SIZE(ACC_SIZE), .selectSIZE(2)) countMux (.A(count2), .B(count4), .C(count6), .D(count8), .select(selectStage[ACC_SIZE-2:0]) , .Y(checkCount));
    MUX4x1 #(.SIZE(RES_SIZE), .selectSIZE(2)) resMux (.A(res2), .B(res4), .C(res6), .D(res8), .select(selectStage[ACC_SIZE-2:0]) , .Y(result));
    // assign result = res8;
    MUX4x1 #(.SIZE(1), .selectSIZE(2)) ovfMux (.A(overflow2), .B(overflow4), .C(overflow6), .D(overflow8), .select(selectStage[ACC_SIZE-2:0]) , .Y(overflow));
    // assign overflow = overflow8;
    assign checkRollBack = rollBack8;
    assign lastCount = count8;



endmodule