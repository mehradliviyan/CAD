module controller
#(
    parameter RES_SIZE = 32,
    parameter IN_SIZE = 8,
    parameter ACC_SIZE = 3
)
(
    input clk,
    input rst,
    input checkRollBack,
    input overflow,
    input start,
    input [ACC_SIZE-1:0] N,
    input [ACC_SIZE-1:0] checkCount,
    input [ACC_SIZE-1:0] lastCount,
    input [IN_SIZE-1:0] x_i,
    output reg rollBack,
    output reg ready,
    output reg valid,
    output reg en_count,
    output reg error
);



parameter Idle = 0, ReadN = 1, ReadX = 2;
reg[2:0] NS, PS;
reg fristTime;
always@(posedge clk, posedge rst) begin
    if(rst) begin
        PS <= Idle;
        fristTime <= 0 ;
    end
    else begin
        PS <= NS;
        if (PS == ReadX) begin
            fristTime <= 1;
        end
    end
end

always @(*) begin
    case (PS)
        Idle : NS = start ? ReadN : Idle;
        ReadN : NS = ReadX; 
        ReadX : NS = ReadX;
        default: NS = Idle;
    endcase
end


reg flag;
always @(*) begin
    case (PS)
        Idle : begin
            ready = 1'b0;
            valid = 1'b0;
            rollBack = 1'b0;
            en_count = 1'b0;     
        end 
        ReadN : begin
            ready = 1'b0;
            valid = 1'b0;
            flag = N > 3;
            rollBack = 1'b0;
            en_count = 1'b0;
        end
        ReadX : begin
            flag = N > 3;
            ready = flag ? ((lastCount != 3'b011)) : 1;
            valid = (N == 7) ? ((checkCount == N) && fristTime) :(checkCount == N);
            // valid = flag ? (lastCount == 3'b111): (lastCount == 3'b011);
            rollBack = flag ? ((lastCount == 3'b011)): 0;
            error = overflow || (x_i == {IN_SIZE{1'b1}});
            en_count = 1'b1;
        end
        default:;
        endcase
    end  

endmodule