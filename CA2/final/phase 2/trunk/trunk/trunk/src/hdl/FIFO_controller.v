module FIFO_CONTROLLER
(
    input clk,
    input rstn,
    input wen,
    input empty,
    input full,
    output reg valid,
    output reg ready
);

// make valid signal
always @(*) begin
    if (!rstn) begin
        valid <= 0;
    end
    else begin
        valid <= !empty;
    end
end


// make ready signal
always @(*) begin
    if (!rstn) begin
        ready <= 0;
    end
    else begin
        ready <= !full;
    end
end


endmodule