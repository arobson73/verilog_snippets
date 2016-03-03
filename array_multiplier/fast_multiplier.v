//this is a pipelined 8 bit array multiplier
//note i do not know if this is best way to implement it using mux to check
//if the a regster is set
module fast_multiplier
(
    input clk,reset,
    input wire [7:0] a , b,
    output wire [15:0] res
);
//signals
//stage 1
reg [7:0] b1,a1;
reg [7:0] b1_next,a1_next;
//stage 2
reg [7:0] b2_0_next;
reg [8:0] b2_1_next;//max bits log2(128*2)+1 = 9
reg [9:0] b2_2_next;
reg [10:0] b2_3_next;//max bits log2(128*8) +1 = 11
reg [11:0] b2_4_next;
reg [12:0] b2_5_next;//max bits log2(128*32) +1 = 13
reg [13:0] b2_6_next;
reg [14:0] b2_7_next;//max bit log2(128*128) + 1 = 15
reg [9:0] b2_1_0_sum_next,b2_1_0_sum, b3_1_0_sum;
reg [11:0] b2_3_2_sum_next,b2_3_2_sum;
reg [13:0] b2_5_4_sum_next,b2_5_4_sum;
reg [15:0] b2_7_6_sum_next,b2_7_6_sum;
//stage 3
reg [12:0] b3_1_sum_next, b3_1_sum;
reg [15:0] b3_2_sum_next, b3_2_sum;
//stage 4
reg [15:0] b4_1_sum_next;

assign res = {b4_1_sum_next[15:4], b3_1_sum[3:2],b3_1_0_sum[1:0]};

always @(posedge clk or posedge reset)
    if (reset)
    begin
        b1 <= 0; a1 <= 0; b2_1_0_sum <= 0;
        b2_3_2_sum <= 0; b2_5_4_sum <= 0; b2_7_6_sum <= 0;
        b3_1_sum <= 0; b3_2_sum <= 0;
    end
    else
    begin
    //stage 1 store the input into registers
    b1 <= b1_next;
    a1 <= a1_next;
    //store 2nd stage calcs
    b2_1_0_sum <= b2_1_0_sum_next;
    b3_1_0_sum <= b2_1_0_sum;//store
    b2_3_2_sum <= b2_3_2_sum_next;
    b2_5_4_sum <= b2_5_4_sum_next;
    b2_7_6_sum <= b2_7_6_sum_next;
    //store stage 3 calcs
    b3_1_sum   <= b3_1_sum_next;
    b3_2_sum   <= b3_2_sum_next;

    end
always @*
begin
    //stage 1
    a1_next = a;
    b1_next = b;
    //stage 2
    b2_0_next = (a1[0])  ?  b1  : 8'b0;//8bits
    b2_1_next = (a1[1])  ? ({1'b0, b1} << 1)  : 9'b0;//9bits
    b2_1_0_sum_next = {2'b0,b2_0_next} + {1'b0, b2_1_next};//10bits
    b2_2_next = (a1[2])  ? ({2'b0, b1} << 2)  : 10'b0;//10 bits
    b2_3_next = (a1[3])  ? ({3'b0, b1} << 3)  : 11'b0;//11 bits
    b2_3_2_sum_next = {2'b0,b2_2_next} + {1'b0,b2_3_next};//12 bits
    b2_4_next = (a1[4])  ? ({4'b0, b1} << 4)  : 12'b0;//12bits
    b2_5_next = (a1[5])  ? ({5'b0, b1} << 5)  : 13'b0;//13 bits
    b2_5_4_sum_next = {2'b0,b2_4_next} + {1'b0,b2_5_next};//14 bits
    b2_6_next = (a1[6])  ? ({6'b0, b1} << 6)  : 14'b0; // 14 bits
    b2_7_next = (a1[7])  ? ({7'b0, b1} << 7)  : 15'b0;// 15 bits
    b2_7_6_sum_next = {2'b0,b2_6_next} + {1'b0,b2_7_next};//16 bits
    //stage 3
    b3_1_sum_next = {3'b0,b2_1_0_sum} + {1'b0,b2_3_2_sum};//12+1 =13 bits
    b3_2_sum_next = {2'b0,b2_5_4_sum} + b2_7_6_sum;//16 
    //stage 4
    b4_1_sum_next = {3'b0,b3_1_sum} + b3_2_sum;//16


end
endmodule


