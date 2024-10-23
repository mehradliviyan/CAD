module ExtendRight #(parameter SIZE = 16 , OUTSIZE = 32) (input [SIZE-1:0] A, output [OUTSIZE-1:0] Y);
    assign Y = {A , {(OUTSIZE-SIZE){1'b0}}};
endmodule