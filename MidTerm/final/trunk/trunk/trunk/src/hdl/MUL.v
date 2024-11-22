module MUL #(parameter SIZE = 8) (input signed [SIZE-1:0] A , input signed [SIZE-1:0] B , output signed [2*SIZE-1:0] Y);
    assign Y = A*B;
endmodule