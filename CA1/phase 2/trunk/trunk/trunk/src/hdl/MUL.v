module MUL #(parameter SIZE = 8) (input [SIZE-1:0] A , input [SIZE-1:0] B , output [2*SIZE-1:0] Y);
    assign Y = A*B;
endmodule