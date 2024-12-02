module controller 
(
        input clk, 
        input rst, 
        input start, 
        input CO_up, 
        input CO_down, 
        input signA, 
        input signB, 
        input rst_begin,                
        output ldY, 
        output ldA, 
        output ldB, 
        output enShrA, 
        output enShrB, 
        output cnt_en, 
        output countDown, 
        output done
);
        wire o1;
        wire o2;
        wire o3; 
        wire o4; 
        wire o5; 
        wire o6;
        wire o7; 
        wire o8;
        wire o9;
        wire o10;
        wire result1;
        wire result2; 
        wire result3; 
        wire result4;
        wire result5;
        wire result6;
        wire result7;
        wire result8;
        wire result9;
        wire result10;
        wire idle1;
        wire start1;
        wire start2;
        wire num11;
        wire num21;
        wire num22;
        wire mult1;
        wire not_start;
        wire not_signA;
        wire not_signB;
        wire not_CO_up;
        wire not_CO_down;
        And and_idle(not_start, o1, idle1);
        OR3 or_idle(o10, rst, idle1, result1);
        Register 
        idle
        (
                .clk(clk), 
                .rst(rst_begin), 
                .en(1'b1), 
                .in(result1), 
                .out(o1)
        );
        And and_start1(o1, start, start1);
        And and_start2(o2, start, start2);
        Or or_start(start1, start2, result2);
        Register 
        start_state
        (
                .clk(clk), 
                .rst(rst), 
                .en(1'b1), 
                .in(result2), 
                .out(o2)
        );
        And and_num1(o2, not_start, num11);
        Or or_num1(num11, o4, result3);
        Register 
        num1
        (
                .clk(clk), 
                .rst(rst), 
                .en(1'b1), 
                .in(result3), 
                .out(o3)
        );
        AND3 and_wait1(o3, not_signA, not_CO_up, result4);
        Register 
        wait1
        (
                .clk(clk), 
                .rst(rst), 
                .en(1'b1), 
                .in(result4), 
                .out(o4)
        );
        Or or_num2(signA, CO_up, num21);
        And and_num2(o3, num21, num22);
        Or or_num2_result(num22, o6, result5);
        Register 
        num2
        (
                .clk(clk), 
                .rst(rst), 
                .en(1'b1), 
                .in(result5), 
                .out(o5)
        );
        AND3 and_wait2(o5, not_signB, not_CO_up, result6);
        Register 
        wait2
        (
                .clk(clk), 
                .rst(rst), 
                .en(1'b1), 
                .in(result6), 
                .out(o6)
        );
        Or or_mult(signB, CO_up, mult1);
        And and_mult(o5, mult1, result7);
        Register 
        mult
        (
                .clk(clk), 
                .rst(rst), 
                .en(1'b1), 
                .in(result7), 
                .out(o7)
        );
        Or or_down(o7, o9, result8);
        Register 
        down
        (
                .clk(clk), 
                .rst(rst), 
                .en(1'b1), 
                .in(result8), 
                .out(o8)
        );
        And and_wait3(o8, not_CO_down, result9);
        Register 
        wait3
        (
                .clk(clk), 
                .rst(rst), 
                .en(1'b1), 
                .in(result9), 
                .out(o9)
        );
        And and_done(o8, CO_down, result10);
        Register 
        done_state
        (
                .clk(clk), 
                .rst(rst), 
                .en(1'b1), 
                .in(result10), 
                .out(o10)
        );
        c1 C1_NOT_1(.A0(1'b1),.A1(1'b0),.SA(start),.B0(1'b0),.B1(1'b0),.SB(1'b0),.S0(1'b0),.S1(1'b0),.f(not_start));
	c1 C1_NOT_2(.A0(1'b1),.A1(1'b0),.SA(signA),.B0(1'b0),.B1(1'b0),.SB(1'b0),.S0(1'b0),.S1(1'b0),.f(not_signA));
	c1 C1_NOT_5(.A0(1'b1),.A1(1'b0),.SA(signB),.B0(1'b0),.B1(1'b0),.SB(1'b0),.S0(1'b0),.S1(1'b0),.f(not_signB));
	c1 C1_NOT_3(.A0(1'b1),.A1(1'b0),.SA(CO_up),.B0(1'b0),.B1(1'b0),.SB(1'b0),.S0(1'b0),.S1(1'b0),.f(not_CO_up));
	c1 C1_NOT_4(.A0(1'b1),.A1(1'b0),.SA(CO_down),.B0(1'b0),.B1(1'b0),.SB(1'b0),.S0(1'b0),.S1(1'b0),.f(not_CO_down));
        assign ldY = o7;
        Or ldA_or(o7, o2, ldA);
        assign ldB = o2;
        Or enShrA_or(o4, o9, enShrA);
        assign enShrB = o6;
        OR3 cnt_en_or(o4, o6, o9, cnt_en);
        assign countDown = o9;
        assign done = o10;
endmodule