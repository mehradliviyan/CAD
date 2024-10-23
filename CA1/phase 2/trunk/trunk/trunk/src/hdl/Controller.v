module controller(input clk, rst, start, CoCounterRAM, CoA, CoB, signA, signB, output reg  enWriteRAM_a, enReadRam_a, enCounterRAM, enCounterA, ldA, ldB, enCounterB, slcMUX, ldout, enWriteRAM_b, enReadRam_b, done , readFile , writeFile);
    parameter [3:0] Idle = 0 , Initial = 1, LoadDataA = 2 , LoadDataB = 3,  NotReady = 4 , ReadyA = 5 , ReadyB = 6 , BothReady = 7 , Shifting = 8 , RAMwrite = 9 , Writing = 10;
    reg [3:0] ns,ps ;
   
    always@(posedge clk , posedge rst) begin
        if (rst) begin
            ps <= Idle;
        end
        else begin
            ps <= ns;
        end
    end
    always@(ps,start , signA , CoA , signB , CoB , CoCounterRAM) begin
        case (ps)
            Idle : ns = start ? Initial :  Idle;
            Initial : ns = start ? Initial : LoadDataA; 
            LoadDataA : ns = LoadDataB;
            LoadDataB : ns = NotReady;
            NotReady : ns = ((CoA || signA)&&(CoB || signB)) ? BothReady :(signA || CoA) ? ReadyA : (signB || CoB) ? ReadyB : NotReady  ;
            ReadyA : ns = (CoB || signB) ? BothReady : ReadyA;
            ReadyB : ns = (CoA || signA) ? BothReady : ReadyB;
            BothReady : ns = Shifting;
            Shifting : ns = RAMwrite;
            RAMwrite : ns = (CoCounterRAM) ? Writing : LoadDataA;
            Writing : ns = Idle;
            default: ns = Idle;
        endcase
    end
    always@(ps,start , signA , CoA , signB , CoB , CoCounterRAM)  begin
        {enWriteRAM_a, enReadRam_a, enCounterRAM, enCounterA, ldA, ldB, enCounterB, slcMUX, ldout, enWriteRAM_b, enReadRam_b, done , readFile , writeFile} = 14'b0;
        case (ps)
            Idle : begin
               done = 1'b1; 
            end  
            Initial : begin
                readFile = 1'b1; 
            end
            LoadDataA : begin
                ldA = 1'b1;
                enReadRam_a = 1'b1;
                enCounterRAM = 1'b1;
            end
            LoadDataB : begin
                ldB = 1'b1;
                enReadRam_a = 1'b1;
                enCounterRAM = 1'b1;
            end
            NotReady : begin
                enCounterA =~ (signA||CoA);
                enCounterB =~ (signB||CoB);
            end
            ReadyA : begin
                enCounterB =~ (signB||CoB);
            end
            ReadyB : begin
                enCounterA =~(signA||CoA);
            end
            BothReady : begin
                ldout = 1'b1;
                slcMUX = 1'b1;
            end
            Shifting : begin
                ldout = 1'b1;
                slcMUX = 1'b0;
            end
            RAMwrite : begin
                enWriteRAM_b = 1'b1;
            end
            Writing : begin
              writeFile = 1'b1;
            end
            default:;
        endcase    
    end
endmodule
