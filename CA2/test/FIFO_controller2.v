module FIFO_CONTROLLER2
(
    input clk,
    input rstn,
    input wen,
    input empty,
    input full,
    output reg valid,
    output reg ready
);
    parameter NothingHappen = 0, Writeing = 1, CannotWrite =2;
    reg [1:0] NS,PS;
    always @(posedge clk) begin
        if (!rstn) begin
            PS <= NothingHappen;
        end
        else begin
            PS <= NS;
        end
    end

    always @(*) begin
        case (PS)
            NothingHappen: NS <= wen ? Writeing : NothingHappen;
            Writeing: NS <= full ? CannotWrite : wen ? Writeing : NothingHappen ;
            CannotWrite: NS <= !(!wen | full | empty) ? Writeing : empty ? NothingHappen : CannotWrite; 
            default: ;
        endcase
    end

    always @(*) begin
        case (PS)
            NothingHappen: {ready,valid} <= 2'b10;
            Writeing: {ready,valid} <= 2'b11; 
            CannotWrite: {ready,valid} <= 2'b01; 
            default: ;
        endcase
    end
endmodule