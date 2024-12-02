
module FA 
(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);
    wire AxorB;
    wire AandB;
    wire cinAndAxorB;
    Xor x1
    (
        .a(A), 
        .b(B),
        .out(AxorB)
    );

    
    And
    AxorB_And_CIN
    (
        .a(AxorB), 
        .b(Cin),
        .out(cinAndAxorB)
    );

    And 
    AandB_gate
    (
        .a(A), 
        .b(B),
        .out(AandB)
    );


    Or 
    or_Cout
    (
	    .a(cinAndAxorB),
	    .b(AandB),
	    .out(Cout)
    );

    Xor x2
    (
        .a(AxorB), 
        .b(Cin),
        .out(Sum)
    );
    
endmodule