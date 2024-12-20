module  Buffer
#(
    parameter SIZE = 16,
    parameter MEM_SIZE = 8,
    parameter PAR_WRITE = 4,
    parameter PAR_READ = 2,
    parameter ADDRES_SIZE = $clog2(MEM_SIZE)
) 
(
    input clk,
    input wen,
    input [ADDRES_SIZE-1:0] waddr,
    input [ADDRES_SIZE-1:0] raddr,
    input [SIZE*PAR_WRITE-1:0] din,
    output [SIZE*PAR_READ-1:0] dout
);
    // declear the memory
    reg [SIZE-1:0] mem [0:MEM_SIZE-1];
    // read data
    genvar i;
    generate
        for (i = 0; i < PAR_READ; i = i + 1) 
            assign dout[(i+1)*SIZE-1:i*SIZE] = mem[raddr + i];
    endgenerate
    // write data
    genvar k;
    generate
        for (k = 0; k < PAR_WRITE; k = k + 1) begin
            always @(posedge clk) 
                if (wen) 
                    mem[waddr + k] <= din[(k+1)*SIZE-1 : k*SIZE];
        end
            
    endgenerate
    
    
endmodule