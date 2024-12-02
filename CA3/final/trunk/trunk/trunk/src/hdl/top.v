module top
#(parameter SIZE = 16)   
(
    input clk, 
    input rst, 
    input start, 
    input rst_begin, 
    input [SIZE-1:0] A, 
    input [SIZE-1:0] B,
    output done, 
    output [SIZE-1:0] out
);

    wire CO_up;
    wire CO_down;
    wire signA;
    wire signB;
    wire ldY;
    wire ldA;
    wire ldB;
    wire enShrA;
    wire enShrB;
    wire cnt_en;
    wire countDown;

    controller 
    cont
    (
        .clk(clk), 
        .rst(rst), 
        .start(start), 
        .CO_up(CO_up), 
        .CO_down(CO_down), 
        .signA(signA), 
        .signB(signB), 
        .rst_begin(rst_begin),                
        .ldY(ldY), 
        .ldA(ldA), 
        .ldB(ldB), 
        .enShrA(enShrA), 
        .enShrB(enShrB), 
        .cnt_en(cnt_en), 
        .countDown(countDown), 
        .done(done)
    );

    datapath dp 
    (
        .clk(clk), 
        .rst(rst), 
        .ldY(ldY), 
        .ldA(ldA), 
        .ldB(ldB),
        .enShrA(enShrA),
        .enShrB(enShrB),
        .cnt_en(cnt_en),
        .countDown(countDown),  
        .A(A), 
        .B(B), 
        .out(out), 
        .CO_up(CO_up), 
        .CO_down(CO_down), 
        .signA(signA), 
        .signB(signB)
    );

endmodule