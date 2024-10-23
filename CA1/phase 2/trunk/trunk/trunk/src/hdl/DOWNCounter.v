module DOWNCounter #(parameter SIZE = 4 ) (input clk , input rst ,  input enable , input [SIZE-1:0] offset , input [SIZE-1:0] initialValue , output co , output [SIZE-1:0] data);
    reg [SIZE-1:0] count;
    always @(posedge clk , posedge rst) begin
        if (rst) begin
            count <= initialValue;
        end
        else begin
            if (enable) begin
                if (count == offset) begin
                    count <= initialValue;
                end
                else begin
                    count <= count - 1;
                end
                
            end
        end
    end
    assign co = (count == offset) ? 1'b1 : 1'b0;
    assign data = count;
endmodule