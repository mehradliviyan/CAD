module Adder 
#(parameter SIZE = 8) 
(
    input [SIZE-1:0] A, 
    input[SIZE-1:0] B,
    input cin,
    output [SIZE-1:0] Y,
    output cout
);
    wire [SIZE:0] carry;
    assign carry[0] = cin;
    genvar i;
    generate
    for (i = 0; i < SIZE; i = i + 1) begin
        FA f
        (
            .A(A[i]),
            .B(B[i]),
            .Cin(carry[i]),
            .Sum(Y[i]), 
            .Cout(carry[i+1])
        );
    end
    assign cout = carry[SIZE];
    endgenerate
endmodule