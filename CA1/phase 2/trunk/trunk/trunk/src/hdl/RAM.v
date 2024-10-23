module  RAM #(parameter SIZE = 16 , MEMSIZE = 16  , ADDRESSSIZE = 4)( input  clk , input rst , input  [ADDRESSSIZE-1:0] address , input  [MEMSIZE-1:0] writeData , input  enWrite , input enRead , input readFile , input writeFile , output  [SIZE-1:0] readData );
    reg [MEMSIZE-1:0] memory [0:SIZE-1];
    always @(posedge clk , posedge rst , readFile , writeFile) begin
        if (rst) begin
        end
        else begin
            if (readFile) begin
                $readmemb("data_input.txt" , memory);
            end
            if (writeFile) begin
                $writememh("out.txt" , memory);
            end
            if (enWrite) begin
              memory[address] <= writeData;
            end
        
        end
    end
    assign readData=(enRead)?memory[address]:0;
endmodule
