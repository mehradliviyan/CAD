module MUX4x1 #(parameter SIZE = 8, parameter selectSIZE = 2) (input [SIZE-1:0] A, input [SIZE-1:0] B, input [SIZE-1:0] C, input [SIZE-1:0] D, input [selectSIZE-1:0] select , output reg [SIZE-1:0] Y);
    always @(*) begin
        case (select)
            0: Y = A;
            1: Y = B;
            2: Y = C;
            3: Y = D; 
            default: Y = A;
        endcase
    end
endmodule