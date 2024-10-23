module all (input clk , rst , start , output done);
    wire enCntRam , enWriteInRam , enReadInRam , enWriteOutRam , enReadOutRam , loadA , loadB , enCntA , enCntB , loadOut , select , coCntRam , coA , coB , signA , signB , readFile , writeFile;
    DP dataPath(.clk(clk) , .rst(rst) , .enCntRam(enCntRam) , .enWriteInRam(enWriteInRam) , .enReadInRam(enReadInRam) , .enWriteOutRam(enWriteOutRam) , .enReadOutRam(enReadOutRam) , .loadA(loadA) , .loadB(loadB) , .enCntA(enCntA) , .enCntB(enCntB) , .loadOut(loadOut) , .select(select) , .coCntRam(coCntRam) , .coA(coA) , .coB(coB) , .signA(signA) , .signB(signB) , .readFile(readFile) , .writeFile(writeFile));
    controller controll(.clk(clk), .rst(rst), .start(start), .CoCounterRAM(coCntRam), .CoA(coA), .CoB(coB), .signA(signA), .signB(signB), .enWriteRAM_a(enWriteInRam), .enReadRam_a(enReadInRam), .enCounterRAM(enCntRam), .enCounterA(enCntA), .ldA(loadA), .ldB(loadB), .enCounterB(enCntB), .slcMUX(select), .ldout(loadOut), .enWriteRAM_b(enWriteOutRam), .enReadRam_b(enReadOutRam), .done(done) , .readFile(readFile) , .writeFile(writeFile));
endmodule