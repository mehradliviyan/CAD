module DP (input clk , rst , enCntRam , enWriteInRam , enReadInRam , enWriteOutRam , enReadOutRam , loadA , loadB , enCntA , enCntB , loadOut , select , output coCntRam , coA , coB , signA , signB , readFile , writeFile);
    parameter RAMCOUNTERSIZE = 4;
    wire [RAMCOUNTERSIZE-1:0] ramCounterData;

    parameter INPUTRAMSIZE = 16 , INPUTRAMMEMSIZE = 16 , INPUTRAMADDRESSSIZE = RAMCOUNTERSIZE;
    wire [INPUTRAMSIZE-1:0] inputRamData;

    parameter REGAADDRESSSIZE = 4;
    wire [REGAADDRESSSIZE-1:0] counterAdata;

    parameter REGASIZE = 16;
    wire [(REGASIZE/2)-1:0] Adata;


    parameter REGBADDRESSSIZE = 4;
    wire [REGBADDRESSSIZE-1:0] counterBdata;

    parameter REGBSIZE = 16;
    wire [(REGBSIZE/2)-1:0] Bdata;

    parameter NotASIZE = REGAADDRESSSIZE;
    wire [NotASIZE-1:0] notAdata;

    parameter NotBSIZE = REGBADDRESSSIZE;
    wire [NotBSIZE-1:0] notBdata;

    wire [NotASIZE-1:0] numberOfShift;



    parameter RESULTSIZE = 32;
    wire [RESULTSIZE-1:0] mainShiftResult;

    wire [RESULTSIZE-1:0] muxData;


    wire [RESULTSIZE-1:0] result;

    parameter MULSIZE = 8;
    wire [2*MULSIZE-1:0] mulData;

    wire [4*MULSIZE-1:0] extendData;

    wire [RAMCOUNTERSIZE-1:0] outputShiftcounter;
    wire [RAMCOUNTERSIZE-1:0] addressofoutRam;



    parameter OUTPUTRAMSIZE = 8 , OUTPUTRAMMEMSIZE = 32 , OUTPUTRAMADDRESSSIZE = 3;
    wire [OUTPUTRAMSIZE-1:0] outputRamData;

    wire rst_counter_registers;
    assign rst_counter_registers=rst || enWriteOutRam;
    UPCounter #(.SIZE(RAMCOUNTERSIZE)) ramCounter (.clk(clk) , .rst(rst) ,  .enable(enCntRam) , .offset({RAMCOUNTERSIZE{1'b0}}), .initialValue({RAMCOUNTERSIZE{1'b0}}) , .co(coCntRam) , .data(ramCounterData));
    RAM #( .SIZE(INPUTRAMSIZE)  , .MEMSIZE(INPUTRAMMEMSIZE)   , .ADDRESSSIZE(INPUTRAMADDRESSSIZE)) inputRam ( .clk(clk) , .rst(rst) , .address(ramCounterData) , .writeData({INPUTRAMSIZE{1'b0}}) , .enWrite(enWriteInRam) , .enRead(enReadInRam) , .readFile(readFile) , .writeFile(1'b0) , .readData(inputRamData) );
    DOWNCounter #(.SIZE(REGAADDRESSSIZE) ) counterA(.clk(clk) , .rst(rst_counter_registers) , .enable(enCntA) , .offset({4'b0111}) , .initialValue({REGAADDRESSSIZE{1'b1}}) , .co(coA) ,  .data(counterAdata));
    SpecialReg #( .SIZE(REGASIZE) , .ADDRESSSIZE(REGAADDRESSSIZE)) regA (.clk(clk), .rst(rst) , .inData(inputRamData) , .load(loadA) , .address(counterAdata)  , .sign(signA) , .Y(Adata));
    DOWNCounter #(.SIZE(REGBADDRESSSIZE) ) counterB(.clk(clk) , .rst(rst_counter_registers) , .enable(enCntB) , .offset({4'b0111}) , .initialValue({REGBADDRESSSIZE{1'b1}}) , .co(coB) ,  .data(counterBdata));
    SpecialReg #( .SIZE(REGBSIZE) , .ADDRESSSIZE(REGBADDRESSSIZE)) regB (.clk(clk), .rst(rst) , .inData(inputRamData) , .load(loadB) , .address(counterBdata)  , .sign(signB) , .Y(Bdata));
    Not #( .SIZE(NotASIZE)) notA (.A(counterAdata), .Y(notAdata));
    Not #( .SIZE(NotBSIZE)) notB (.A(counterBdata), .Y(notBdata));
    Adder #( .SIZE(NotASIZE)) addAB (.A(notAdata) , .B(notBdata) , .Y(numberOfShift));
    ShiftRight #(.SIZE(RESULTSIZE) , .SHIFTSIZE(NotASIZE)) mainShifter ( .offset(numberOfShift) , .InData(result) , .OutData(mainShiftResult));
    MUX2x1 #( .SIZE(RESULTSIZE)) muxResult (.A(mainShiftResult) , .B(extendData) , .select(select) , .Y(muxData));
    Register #( .SIZE (RESULTSIZE)) resultReg (.clk(clk), .rst(rst) , .inData(muxData) , .load(loadOut) , .Y(result));
    MUL #(.SIZE (MULSIZE)) mul (.A(Adata) , .B(Bdata) , .Y(mulData));
    ExtendRight #(.SIZE (2*MULSIZE) , .OUTSIZE (4*MULSIZE))  ext (.A(mulData), .Y(extendData));
    assign addressofoutRam = ramCounterData -1;
    RAM #( .SIZE(OUTPUTRAMSIZE)  , .MEMSIZE(OUTPUTRAMMEMSIZE)  , .ADDRESSSIZE( OUTPUTRAMADDRESSSIZE)) outputRam ( .clk(clk) , .rst(rst) , .address(addressofoutRam[OUTPUTRAMADDRESSSIZE:1]) , .writeData(result) , .enWrite(enWriteOutRam) , .enRead(enReadOutRam) , .readFile(1'b0) , .writeFile(writeFile) ,  .readData(outputRamData) );

endmodule