module seqStage
#(
    parameter RES_SIZE = 32,
    parameter ACC_SIZE = 3
)
(
    input clk,
    input rst,
    input [RES_SIZE-1:0] itemOld,
    input [RES_SIZE-1:0] currentX_i,
    input rollBack_i,
    input [RES_SIZE-1:0] resOld,
    input [ACC_SIZE-1:0] countOld,
    input overflowOld,
    input en_count,
    input [ACC_SIZE-1:0] selectStage,
    output reg [RES_SIZE-1:0] itemNew,
    output reg [RES_SIZE-1:0] currentX_o,
    output reg rollBack_o,
    output reg [RES_SIZE-1:0] resNew,
    output reg [ACC_SIZE-1:0] countNew,
    output reg overflowNew
);


reg [RES_SIZE-1:0] item;
reg [RES_SIZE-1:0] currentX;
reg rollBack;
reg [RES_SIZE-1:0] res;
reg [ACC_SIZE-1:0] count;
reg overflow;

always @(posedge clk , posedge rst) begin
    if (rst) begin
        item <= 0;
        count <= {(ACC_SIZE){1'b1}};
        rollBack <= 0;
        res <= 0;
        currentX <= 0;
        overflow <= 0;
    end
    else begin
        if (en_count && selectStage >= countOld) begin
            res <= resOld;
        end
        if (en_count) begin
            count <= countOld;
            currentX <= currentX_i;
            overflow <= overflowOld;
            item <= itemOld;
            rollBack <= rollBack_i;
        end
    end
end


always @(*) begin
    itemNew <= item;
    countNew <= count;
    rollBack_o <= rollBack;
    resNew <= res;
    currentX_o <= currentX;
    overflowNew <= overflow;
end

endmodule