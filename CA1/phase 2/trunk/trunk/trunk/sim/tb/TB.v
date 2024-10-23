module TB ();
    reg clk , rst , start;
    wire done;
    all UUT(.clk(clk) , .rst(rst) , .start(start) , .done(done));
    always  begin
        #5 clk = ~clk;
    end
    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        #100 rst = 0;
        #100 start = 1;
        #100 start = 0;
        #10000 $stop;
    end
    
endmodule