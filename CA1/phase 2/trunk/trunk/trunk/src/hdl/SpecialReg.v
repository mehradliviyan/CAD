module SpecialReg #(parameter SIZE = 16 , ADDRESSSIZE = 4) (input clk, input rst , input [SIZE-1:0] inData , input load , input [ADDRESSSIZE-1:0] address  , output sign , output [(SIZE/2)-1:0] Y);
    reg [SIZE-1:0] data;
    always @(posedge clk , posedge rst) begin
        if (rst) begin
            data <= {SIZE{1'b0}};
        end
        else begin
            if (load) begin
                data <= inData;
            end
        end
    end
    assign sign = data[address];
    assign Y = {data[address], data[address-1], data[address-2], data[address-3], data[address-4], data[address-5], data[address-6], data[address-7]};
endmodule