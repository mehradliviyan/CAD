module Not #(parameter SIZE = 4) (input [SIZE-1:0] A, output [SIZE-1:0] Y);
    assign Y = ~A;
endmodule