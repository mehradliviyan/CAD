module Adder #(parameter SIZE = 4) (input [SIZE-1:0] A , input [SIZE-1:0] B , output [SIZE-1:0] Y);
    assign Y = A+B;
endmodule