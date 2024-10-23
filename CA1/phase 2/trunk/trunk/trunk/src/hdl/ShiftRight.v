module ShiftRight #(parameter SIZE = 32 , SHIFTSIZE = 4) ( input [SHIFTSIZE-1:0] offset , input [SIZE-1:0] InData , output [SIZE-1:0] OutData);
    assign OutData = InData >> offset; 
endmodule