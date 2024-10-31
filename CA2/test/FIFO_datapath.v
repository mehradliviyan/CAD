module FIFO_DP
#(
    parameter SIZE = 16,
    parameter MEM_SIZE = 8,
    parameter PAR_WRITE = 2,
    parameter PAR_READ = 4,
    parameter ADDRES_SIZE = $clog2(MEM_SIZE)
)
(
    input clk,
    input rstn,
    input clear,
    input wen,
    input ren,
    input [SIZE*PAR_WRITE-1:0] din,
    output full,
    output empty,
    output [SIZE*PAR_READ-1:0] dout
);

localparam BUFFER_SIZE = SIZE;
localparam BUFFER_MEM_SIZE = MEM_SIZE + 1;
localparam BUFFER_PAR_WRITE = PAR_WRITE == 1 ? PAR_WRITE : PAR_WRITE-1;
localparam BUFFER_PAR_READ = PAR_READ;
localparam BUFFER_ADDRESS_SIZE = $clog2(MEM_SIZE)+1;

reg [BUFFER_ADDRESS_SIZE-1:0] write_addr;
reg [BUFFER_ADDRESS_SIZE-1:0] read_addr;
wire outOfBoundWriteFlag;
wire outOfBoundReadFlag;
assign outOfBoundWriteFlag = write_addr >= MEM_SIZE;
assign outOfBoundReadFlag = read_addr >= MEM_SIZE;
// check full
wire [PAR_WRITE-1:0] checkFull;
genvar i;
generate
    for (i = 0; i < BUFFER_PAR_WRITE ; i = i+1) begin
        assign checkFull[i] = outOfBoundWriteFlag ? i+1 == read_addr : (write_addr + i + 1) == read_addr; 
    end
endgenerate

assign full = |checkFull;

// check empty
reg [PAR_READ-1:0] checkEmpty;
genvar j;
generate
    for (j = 0; j < PAR_WRITE ; j = j+1) begin
        assign checkEmpty[j] = outOfBoundReadFlag ? j+1 == write_addr : (read_addr + j + 1) == write_addr; 
    end
endgenerate

assign empty = |checkEmpty;

// write enable check
wire write_en;
assign write_en = !full & wen;

// read enable check
wire read_en;
assign read_en = !empty & ren;

// update write addr
always @(posedge clk) begin
    if (!rstn) begin
        write_addr <= 0;
    end
    else if (clear) begin
        write_addr <= 0;
    end
    else begin
      if (outOfBoundWriteFlag) begin
        write_addr <= 0;
      end
      else if (write_en) begin
        write_addr <= write_addr + PAR_WRITE;
      end
    end
end

// update read addr
always @(posedge clk) begin
    if (!rstn) begin
        read_addr <= 0;
    end
    else if (clear) begin
        read_addr <= 0;
    end
    else begin
      if (outOfBoundReadFlag) begin
        read_addr <= 0;
      end
      else if (read_en) begin
        read_addr <= read_en + PAR_READ;
      end
    end
end

// Instance buffer
Buffer #(.SIZE(SIZE) , .MEM_SIZE(MEM_SIZE) , .PAR_WRITE(PAR_WRITE) , .PAR_READ(PAR_READ)) bf( .clk(clk), .wen(write_en), .waddr(write_addr), .raddr(read_addr), .din(din), .dout(dout));


endmodule