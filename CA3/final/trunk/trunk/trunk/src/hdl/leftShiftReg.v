module leftShiftReg #(parameter SIZE = 8) 
(
    input clk, 
    input rst, 
    input load, 
    input [SIZE-1:0] data_in, 
    input serial_in, 
    input shift_en,
    output [SIZE-1:0] data_out, 
    output carry_out
);
    wire [SIZE-1:0] data_select;
    wire [SIZE+1:0] shift_chain;
    assign shift_chain[SIZE+1] = serial_in;
    assign shift_chain[0] = serial_in;
    wire en_or_out;
    assign data_out = shift_chain[SIZE:1]; 
    assign carry_out = shift_chain[SIZE]; 
    Or en_or
    (
	    .a(shift_en),
	    .b(load),
	    .out(en_or_out)
    );
    genvar i;
    generate
            for (i = 1; i < SIZE+1; i = i + 1) begin : gen_shift_reg
                c2 C2_MUX
                (
                    .D00(shift_chain[i-1]), 
                    .D01(data_in[i-1]), 
                    .D10(1'b0), 
                    .D11(1'b0), 
                    .A1(1'b0), 
                    .B1(1'b0), 
                    .A0(load), 
                    .B0(1'b1), 
                    .out(data_select[i-1])
                );
                Register reg_inst (
                    .clk(clk),
                    .rst(rst),
                    .en(en_or_out), 
                    .in(data_select[i-1]),
                    .out(shift_chain[i])
                );
            end
    endgenerate

    
endmodule
