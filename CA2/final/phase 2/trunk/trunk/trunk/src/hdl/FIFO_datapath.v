module FIFO_DP
#(
    parameter SIZE = 16,
    parameter MEM_SIZE = 8,
    parameter PAR_WRITE = 2,
    parameter PAR_READ = 4,
    parameter ADDRESS_SIZE = $clog2(MEM_SIZE)
)
(
    input clk,
    input rstn,
    input clear,
    input wen,
    input ren,
    input [SIZE*PAR_WRITE-1:0] din,
    output reg full,
    output reg empty,
    output [SIZE*PAR_READ-1:0] dout
);

localparam BUFFER_SIZE = SIZE;
localparam BUFFER_MEM_SIZE = MEM_SIZE + 1;
localparam BUFFER_PAR_WRITE = PAR_WRITE == 1 ? PAR_WRITE : PAR_WRITE-1;
localparam BUFFER_PAR_READ = PAR_READ;
localparam BUFFER_ADDRESS_SIZE = $clog2(MEM_SIZE)+1;

reg [ADDRESS_SIZE-1:0] write_addr;
reg [ADDRESS_SIZE-1:0] read_addr;
reg [BUFFER_ADDRESS_SIZE-1:0] numberOfElements;

// check full
always @(*) begin
  full = numberOfElements  > MEM_SIZE - PAR_WRITE;
end

// check empty
always @(*) begin
  empty = numberOfElements < PAR_READ;
end

// write enable check
wire write_en;
assign write_en = !full & wen;

// read enable check
wire read_en;
assign read_en = !empty & ren;

// update write addr
always @(posedge clk) begin
    if (!rstn) begin
        write_addr <=0;
    end
    else if (clear) begin
        write_addr <= 0;
    end
    else begin
       if (write_en) begin
        if (write_addr + PAR_WRITE > MEM_SIZE) begin
          write_addr <= PAR_WRITE + write_addr - MEM_SIZE ;
        end
        else begin
          write_addr <= write_addr + PAR_WRITE;
        end
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
        if (read_addr + PAR_READ > MEM_SIZE) begin
          read_addr <= PAR_READ - MEM_SIZE + read_addr;
        end
        else begin
          read_addr <= read_addr + PAR_READ;
        end
      end
    end
end

// update number of elements in fifo
always @(posedge clk) begin
    if (!rstn) begin
        numberOfElements <= 0;
    end
    else if (clear) begin
        numberOfElements <= 0;
    end
    else begin
      if (read_en && write_en) begin
        numberOfElements <= numberOfElements + PAR_WRITE - PAR_READ;
      end
      else if (read_en) begin
        numberOfElements <= numberOfElements - PAR_READ;
      end
      else if (write_en) begin
        numberOfElements <= numberOfElements + PAR_WRITE;
      end
    end
end


// Instance buffer
Buffer #(.SIZE(SIZE) , .MEM_SIZE(MEM_SIZE) , .PAR_WRITE(PAR_WRITE) , .PAR_READ(PAR_READ)) bf( .clk(clk), .wen(write_en), .waddr(write_addr), .raddr(read_addr), .din(din), .dout(dout));


endmodule