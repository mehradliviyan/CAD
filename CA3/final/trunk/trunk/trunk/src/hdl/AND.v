module And 
(
    input a, 
    input b,
    output out
);
    c1 AND_
    (
        .A0(1'b0),
        .A1(a),
        .SA(b),
        .B0(1'b0),
        .B1(1'b0),
        .SB(1'b0),
        .S0(1'b0),
        .S1(1'b0),
        .f(out)
    );
    
endmodule