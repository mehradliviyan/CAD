module MUX2x1 #(parameter SIZE = 8, parameter selectSIZE = 1) (input [SIZE-1:0] A, input [SIZE-1:0] B, input [selectSIZE-1:0] select, output reg [SIZE-1:0] Y);
    always @(*) begin
        case (select)
            0: Y = A;
            1: Y = B;
            default: Y = A;
        endcase
    end
endmodule