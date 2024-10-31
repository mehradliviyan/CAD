module MUX2x1 #(parameter SIZE = 32) (input [SIZE-1:0] A , input [SIZE-1:0] B , input select , output [SIZE-1:0] Y);
    assign Y = select ? B : A;
endmodule