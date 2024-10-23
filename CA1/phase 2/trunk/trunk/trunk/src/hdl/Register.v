module Register #(parameter SIZE = 16) (input clk, input rst , input [SIZE-1:0] inData , input load , output [SIZE-1:0] Y);
    reg [SIZE-1:0] data;
    always @(posedge clk ,posedge  rst) begin
        if (rst) begin
            data <= {SIZE{1'b0}};
        end
        else begin
            if (load) begin
                data <= inData;
            end
        end
    end
    assign Y = data;
endmodule