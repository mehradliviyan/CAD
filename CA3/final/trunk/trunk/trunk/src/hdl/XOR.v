module Xor
(
    input a, 
    input b, 
    output out
);
    c2 _XOR
    (
        .D00(1'b0), 
        .D01(1'b0), 
        .D10(1'b1), 
        .D11(1'b0), 
        .A1(a), 
        .B1(b), 
        .A0(a), 
        .B0(b), 
        .out(out)
    );
endmodule