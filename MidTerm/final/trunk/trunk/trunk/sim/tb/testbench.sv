`timescale 1ns/1ns
`default_nettype none

`define HALF_CLK 5
`define CLK (2 * `HALF_CLK)

module testbench ();
    reg clk, rst, start;

    parameter OUTPUT_WIDTH = 32;

    reg signed [7 : 0] X;
    reg [2 : 0] N;

    integer valid_cnt = 0;

    wire signed [OUTPUT_WIDTH - 1 : 0] Y;
    wire valid, ready, overflow, error;
    reg [OUTPUT_WIDTH : 0] outputs [0 : 5 * 20 - 1];
    always @(clk)begin
        # `HALF_CLK
        clk <= ~clk;
    end

    integer j;
    integer t;
    integer true_;
    // always @(posedge clk) begin
    //     if (valid) begin
    //         //remove this if not necessary
    //         valid_cnt = valid_cnt + 1;
    //         if (valid_cnt >= 1 ? ready : 1) begin
    //             if ((overflow == outputs[j][OUTPUT_WIDTH]) && (Y[OUTPUT_WIDTH-1:OUTPUT_WIDTH-8] == outputs[j][OUTPUT_WIDTH-1:OUTPUT_WIDTH-8]))
    //                 true_ = true_ + 1;
    //             j++;
    //         end
    //     end
    // end

   
    integer ov = 0;
    always @(posedge clk) begin
        if (overflow)
            ov++;
    end

    top
    #(
    .RES_SIZE(OUTPUT_WIDTH),
    .IN_SIZE(8),
    .ACC_SIZE(3)
    )
    dut
    (
    .clk(clk),
    .rst(rst),
    .start(start),
    .N(N),
    .x_i(X),
    .result(Y),
    .valid(valid),
    .ready(ready),
    .overflow(overflow),
    .error(error)
    );

    reg [7 : 0] inputs [0 : 19];
    reg [2 : 0] N_in [0 : 4];
    integer i, n;
    initial begin
        $readmemh("inputs.txt", inputs);
        $readmemh("outputs.mem", outputs);
        N_in = {3'd1, 3'd2, 3'd3, 3'd4, 3'd6};
        n = 0;
        true_ = 0;
        j = 0;
        t = 0;
        ///////////////////////
        clk = 0;
        start = 0;
        rst = 0;
        #`CLK;
        rst = 1;
        #`CLK;
        rst = 0;
        #`CLK;

        while (n < 5) begin
            i = 0;
            start = 1;
            #`CLK;
            start = 0;
            N = N_in[n];
            while (i < 20) begin
                while (!ready) #`CLK;

                X = inputs[i];
                i++;
                #`CLK;
            end
            repeat (N <= 3 ? 3 : 7) #`CLK;
            t = (n+1)*20;
            rst = 1;
            #`CLK;
            rst = 0;
            #`CLK;
            n++;
        end
        #`CLK;
        #`CLK;

    end
     always @(posedge clk) begin
        if (valid) begin
            valid_cnt = valid_cnt + 1;
            if ((overflow == outputs[t][OUTPUT_WIDTH]) && (Y[OUTPUT_WIDTH-1:OUTPUT_WIDTH-8] == outputs[t][OUTPUT_WIDTH-1:OUTPUT_WIDTH-8]))
                true_ = true_ + 1;
            t++;
        end
    end

    always @(posedge clk) begin
        if (j < 20*(n+1)) begin
           if (valid_cnt >= 1 ? ready : 1) begin
            j++;
            end 
        end
    end

endmodule