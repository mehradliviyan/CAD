module MUL #(parameter SIZE = 8) (
    input [SIZE-1:0] A,
    input [SIZE-1:0] B,
    output [2*SIZE-1:0] Y
);
    wire X_o [SIZE:0][SIZE:0];
    wire Y_o [SIZE:0][SIZE:0];
    wire C_o [SIZE:0][SIZE:0];
    wire P_o [SIZE:0][SIZE:0];

    genvar i,j;
    generate
        for (i = 0; i < SIZE; i = i + 1) begin : rows
            for (j = 0; j < SIZE; j = j + 1) begin : cols
                bitMul instOneBitMul 
                (
                    .xi(X_o[i][j]),
                    .yi(Y_o[i][j]),
                    .pi(P_o[i][j + 1]), 
                    .ci(C_o[i][j]),                    
                    .xo(X_o[i][j + 1]), 
                    .yo(Y_o[i + 1][j]), 
                    .po(P_o[i + 1][j]), 
                    .co(C_o[i][j + 1])
                );
            end
        end
    endgenerate

    generate
        for (i = 0; i < SIZE; i = i + 1) begin : outs
            assign X_o[i][0] = A[i]; 
            assign C_o[i][0] = 1'b0; 
            assign P_o[0][i + 1] = 1'b0; 
            assign P_o[i + 1][SIZE] = C_o[i][SIZE];
            assign Y_o[0][i] = B[i]; 
            assign Y[i] = P_o[i + 1][0]; 
            assign Y[i + SIZE] = P_o[SIZE][i + 1];
        end
    endgenerate
endmodule


