`timescale 1ns / 1ns

module tb_MUL;

    // Parameter
    parameter SIZE = 8;

    // Inputs
    reg [SIZE-1:0] A;
    reg [SIZE-1:0] B;

    // Output
    wire [2*SIZE-1:0] Y;

    // Instantiate the MUL module
    MUL #(SIZE) uut (
        .A(A),
        .B(B),
        .Y(Y)
    );

    // Testbench logic
    initial begin
        // Display header
        $display("Time\tA\t\tB\t\tY");

        // Test case 1: Multiply two small numbers
        A = 8'b00000011; // 3
        B = 8'b00000010; // 2
        #10;
        $display("%0dns\t%b\t%b\t%b", $time, A, B, Y);

        // Test case 2: Multiply a number by zero
        A = 8'b00001111; // 15
        B = 8'b00000000; // 0
        #10;
        $display("%0dns\t%b\t%b\t%b", $time, A, B, Y);

        // Test case 3: Multiply two larger numbers
        A = 8'b00010110; // 22
        B = 8'b00000101; // 5
        #10;
        $display("%0dns\t%b\t%b\t%b", $time, A, B, Y);

        // Test case 4: Multiply maximum values
        A = 8'b11111111; // 255
        B = 8'b11111111; // 255
        #10;
        $display("%0dns\t%b\t%b\t%b", $time, A, B, Y);

        // Test case 5: Multiply by one
        A = 8'b00000001; // 1
        B = 8'b10101010; // 170
        #10;
        $display("%0dns\t%b\t%b\t%b", $time, A, B, Y);

        // End simulation
        $finish;
    end

endmodule
