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
    reg [ADDRES_SIZE-1:0] readIndex [0:PAR_READ-1];

    genvar i;
    generate
        for (i = 0; i < PAR_READ; i = i + 1) 
            assign dout[(i+1)*SIZE-1:i*SIZE] = mem[readIndex[i]];
    endgenerate

    genvar j;
    generate
        for (j = 0; j < PAR_READ; j = j + 1) 
            assign readIndex[j] = raddr + j >= MEM_SIZE ? raddr + j - MEM_SIZE : raddr + j;
    endgenerate
    // write data
    reg [ADDRES_SIZE-1:0] writeIndex [0:PAR_WRITE-1];
    genvar k;
    generate
        for (k = 0; k < PAR_WRITE; k = k + 1) begin
            always @(posedge clk) 
                if (wen) 
                    mem[writeIndex[k]] = din[(k+1)*SIZE-1 : k*SIZE];
        end
            
    endgenerate

    genvar t;
    generate
        for (t = 0; t < PAR_WRITE; t = t + 1) 
            assign writeIndex[t] = waddr + t >= MEM_SIZE ? waddr + t - MEM_SIZE : waddr + t;
    endgenerate
    
endmodule