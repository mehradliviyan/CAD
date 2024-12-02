module up_downcnt #(parameter SIZE = 5) 
(
    input clk,               
    input rst,             
    input en,                
    input dir,            
    input load,    
    input [SIZE-1:0] parIn,       
    output [SIZE-1:0] count,      
    output bout_down,
    output bout_up
);

    wire [SIZE-1:0] q;            
    wire [SIZE-1:0] next_count;   
    wire [SIZE-1:0] dec_input;
    wire temp;
    wire [SIZE-1:0] muxInps1;
    wire [SIZE-1:0] muxInps2;
    wire tempUseless;
    wire [SIZE-1:0] orValues;
    wire [SIZE-1:0] andValues;
    genvar j;
    for (j = 0; j < SIZE; j = j + 1) begin
        if (j == 0) 
            assign muxInps1[j] = 1'b1;
        else 
            assign muxInps1[j] = 1'b0;
    end

    genvar h;
    for (h = 0; h < SIZE; h = h + 1) begin
        assign muxInps2[h] = 1'b1;
    end

    genvar t;
    for (t = 0; t < SIZE; t = t + 1) begin
        c2 C2_MUX
        (
            .D00(muxInps1[t]), 
            .D01(muxInps2[t]), 
            .D10(1'b0), 
            .D11(1'b0), 
            .A1(1'b0), 
            .B1(1'b0), 
            .A0(dir), 
            .B0(1'b1), 
            .out(dec_input[t])
        );
    end


    Adder 
    #(
        .SIZE(SIZE)
    ) 
    dec_inst
    (
        .A(q), 
        .B(dec_input),
        .cin(1'b0),
        .Y(next_count),
        .cout(tempUseless)
    );
    
    genvar i;
    generate
        for (i = 0; i < SIZE; i = i + 1) begin : gen_register
            Register reg_inst (
                .clk(clk),
                .rst(rst),
                .en(en),
                .in(next_count[i]),
                .out(q[i])
            );
        end
    endgenerate
    

    wire out3;

    


    genvar or_i;
    generate
        for (or_i = 0; or_i < SIZE; or_i = or_i + 1) begin : gen_ors
            if (or_i == 0) begin
                Or 
                or_temp
                (
	                .a(1'b0),
	                .b(q[or_i]),
	                .out(orValues[or_i])
                );
            end
            else begin
                Or 
                or_temp
                (
                    .a(q[or_i]),
                    .b(orValues[or_i-1]),
                    .out(orValues[or_i])
                ); 
            end
        end
    endgenerate
    assign temp = orValues[SIZE-1];


    genvar and_i;
    generate
        for (and_i = 0; and_i < SIZE; and_i = and_i + 1) begin : gen_ands
            if (and_i == 0) begin
                Or 
                or_temp
                (
	                .a(1'b0),
	                .b(q[and_i]),
	                .out(andValues[and_i])
                );
            end
            else begin
                Or 
                or_temp
                (
                    .a(q[and_i]),
                    .b(andValues[and_i-1]),
                    .out(andValues[and_i])
                ); 
            end
        end
    endgenerate
    assign bout_up = andValues[SIZE-1];
    assign count = q;
	c1 C1_NOT
    (
        .A0(1'b1),
        .A1(1'b0),
        .SA(temp),
        .B0(1'b0),
        .B1(1'b0),
        .SB(1'b0),
        .S0(1'b0),
        .S1(1'b0),
        .f(bout_down)
    );

endmodule