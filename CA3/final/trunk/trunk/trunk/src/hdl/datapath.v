module datapath #(parameter SIZE = 16)   
(
    input clk, 
    input rst, 
    input ldY,
    input ldA,
    input ldB, 
    input enShrA,
    input enShrB, 
    input cnt_en, 
    input countDown,  
    input [SIZE-1:0] A, 
    input [SIZE-1:0] B, 
    output [SIZE-1:0] out, 
    output CO_up, 
    output CO_down, 
    output signA, 
    output signB
);
    
    localparam COUNTER_SIZE = 5;
    wire [SIZE-1:0] A_shifted;
    wire [SIZE-1:0] B_shifted;
    wire [SIZE-1:0] Y_shifted;
    wire [SIZE-1:0] mult_out; 
    wire [SIZE-1:0] mux_out;
    wire parOutY;
    wire [COUNTER_SIZE-1:0] counterData; 

    genvar i;
    for (i = 0; i < SIZE; i = i + 1) begin
        c2 C2_MUX
        (
            .D00(A[i]), 
            .D01(mult_out[i]), 
            .D10(1'b0), 
            .D11(1'b0), 
            .A1(1'b0), 
            .B1(1'b0), 
            .A0(ldY), 
            .B0(1'b1), 
            .out(mux_out[i])
        );
    end
    

    up_downcnt 
    #(
        .SIZE(COUNTER_SIZE)
    )  
    counter
    (
        .clk(clk),               
        .rst(rst),             
        .en(cnt_en),                
        .dir(countDown),     
        .load(1'b0),    
        .parIn(1'b0),       
        .count(counterData),      
        .bout_down(CO_down),
        .bout_up(CO_up)
    );

    leftShiftReg 
    #(
        .SIZE(SIZE)
    )
    shrB 
    (
        .clk(clk), 
        .rst(rst), 
        .load(ldB), 
        .data_in(B), 
        .serial_in(1'b0), 
        .shift_en(enShrB),
        .data_out(B_shifted), 
        .carry_out(signB)
    );

    leftShiftReg 
    #(
        .SIZE(SIZE)
    )
    shrA 
    (
        .clk(clk), 
        .rst(rst), 
        .load(ldA), 
        .data_in(A), 
        .serial_in(1'b0), 
        .shift_en(enShrA),
        .data_out(A_shifted), 
        .carry_out(signA)
    );

    MUL 
    #(
        .SIZE(SIZE/2)
    )
    mulInst 
    (
        .A(A_shifted[SIZE-1:SIZE/2]),
        .B(B_shifted[SIZE-1:SIZE/2]),
        .Y(mult_out)
    );


    rightShiftReg 
    #(
        .SIZE(SIZE)
    ) 
    resReg
    (
        .clk(clk), 
        .rst(rst), 
        .load(ldY), 
        .data_in(mult_out), 
        .serial_in(1'b0),
        .shift_en(enShrA),
        .data_out(Y_shifted), 
        .carry_out(parOutY)
    );


    assign out = Y_shifted;
endmodule