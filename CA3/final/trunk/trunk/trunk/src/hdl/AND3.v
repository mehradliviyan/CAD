module AND3 
(
    input a,
    input b,
    input c,
    output out
);
    c2 and3_
    (
        .D00(1'b0),
        .D01(1'b0),
        .D10(1'b0),
        .D11(1'b1),
        .A1(1'b0),
        .B1(a),
        .A0(b),
        .B0(c),
        .out(out)
    );
    
endmodule