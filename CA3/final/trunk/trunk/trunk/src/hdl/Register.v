module Register (
    input clk, 
    input rst, 
    input en, 
    input in, 
    output out
);
    s2 S2_REG
    (
        .D00(out), 
        .D01(in), 
        .D10(1'b0), 
        .D11(1'b0), 
        .A1(1'b0), 
        .B1(1'b0), 
        .A0(en), 
        .B0(1'b1), 
        .clr(rst), 
        .clk(clk), 
        .out(out)
    );
endmodule