module bitMul (input xi, yi, pi, ci, output xo, yo, po, co);
    wire xy;
    wire and2_out;
    wire and3_out;
    wire and4_out;
    wire xor1_out;

    And and1
    (
        .a(xi),
        .b(yi),
        .out(xy)
    );

    And and2
    (
        .a(pi), 
        .b(xy), 
        .out(and2_out)
    );

    And and3
    (
        .a(pi), 
        .b(ci), 
        .out(and3_out)
    );

    And and4
    (
        .a(xy), 
        .b(ci), 
        .out(and4_out)
    );

    OR3 or1 
    (
        .a(and2_out), 
        .b(and3_out), 
        .c(and4_out), 
        .out(co)
    );

    Xor xor1
    (
        .a(pi), 
        .b(xy), 
        .out(xor1_out)
    );

    Xor xor2
    (
        .a(xor1_out), 
        .b(ci), 
        .out(po)
    );

    assign xo = xi;
    assign yo = yi;

endmodule