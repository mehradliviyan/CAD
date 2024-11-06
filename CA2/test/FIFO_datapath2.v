module FIFO_DP2
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

wire outOfBoundWriteFlag;
wire outOfBoundReadFlag;

reg [BUFFER_ADDRESS_SIZE-1:0] write_addr;
reg [BUFFER_ADDRESS_SIZE-1:0] read_addr;
wire full2,empty2;
// check full
wire [PAR_WRITE-1:0] checkFull;
genvar i;
generate
    for (i = 0; i < BUFFER_PAR_WRITE ; i = i+1) begin
        assign checkFull[i] = (write_addr + i + 1) == read_addr; 
    end
endgenerate

assign full2 = |checkFull;
assign full = full2 || write_addr[BUFFER_ADDRESS_SIZE-1] != read_addr[BUFFER_ADDRESS_SIZE-1];
// check empty
reg [PAR_READ-1:0] checkEmpty;
genvar j;
generate
    for (j = 0; j < PAR_WRITE ; j = j+1) begin
        assign checkEmpty[j] = (read_addr + j + 1) == write_addr; 
    end
endgenerate

assign empty2 = |checkEmpty;
assign empty = empty2 || write_addr[BUFFER_ADDRESS_SIZE-1] == read_addr[BUFFER_ADDRESS_SIZE-1];
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
      if (write_en) begin
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
      if (read_en) begin
        read_addr <= read_en + PAR_READ;
      end
    end
end

// Instance buffer
wire waddr, raddr;
assign waddr = outOfBoundWriteFlag ? 0 : write_addr;
Buffer #(.SIZE(SIZE) , .MEM_SIZE(MEM_SIZE) , .PAR_WRITE(PAR_WRITE) , .PAR_READ(PAR_READ)) bf( .clk(clk), .wen(write_en), .waddr(waddr), .raddr(read_addr), .din(din), .dout(dout));


endmodule