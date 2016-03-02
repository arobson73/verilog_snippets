//test bench
`timescale 1 ns/ 10 ps

module adder_4bit_lut_test;

//signals
localparam T = 20;
reg clk, reset, start;
wire ready;
reg [3:0] a,b;
reg cin;
wire [3:0] s;
wire cout;
adder_4bit_lut add_unit
(.clk(clk), .reset(reset), .a(a), .b(b), .cin(cin), .start(start), .ready(ready), .s(s), .cout(cout));
//clock
//
always
begin
    clk = 1'b1;
    #(T/2);
    clk = 1'b0;
    #(T/2);
end

initial
begin
    reset = 1'b1;
    #(T/2);
    reset = 1'b0;
end

initial
begin
    /*data is as follows
    * a1 b1 a0 b0 c0 || c2 s1 s0 
    * 0  0  0  0  0  || 0  0  0
    * 0  0  0  0  1  || 0  0  1
    * 0  0  0  1  0  || 0  0  1
    * 0  0  0  1  1  || 0  1  0
    * 0  0  1  0  0  || 0  0  1
    * 0  0  1  0  1  || 0  1  0
    * 0  0  1  1  0  || 0  1  0
    * 0  0  1  1  1  || 0  1  1
    * 0  1  0  0  0  || 0  1  0
    * 0  1  0  0  1  || 0  1  1
    * 0  1  0  1  0  || 0  1  1
    * 0  1  0  1  1  || 1  0  0
    * 0  1  1  0  0  || 0  1  1
    * 0  1  1  0  1  || 1  0  0
    * 0  1  1  1  0  || 1  0  0
    * 0  1  1  1  1  || 1  0  1
    * 1  0  0  0  0  || 0  1  0
    * 1  0  0  0  1  || 0  1  1
    * 1  0  0  1  0  || 0  1  1
    * 1  0  0  1  1  || 1  0  0
    * 1  0  1  0  0  || 0  1  1
    * 1  0  1  0  1  || 1  0  0
    * 1  0  1  1  0  || 1  0  0
    * 1  0  1  1  1  || 1  0  1
    * 1  1  0  0  0  || 1  0  0
    * 1  1  0  0  1  || 1  0  1
    * 1  1  0  1  0  || 1  0  1
    * 1  1  0  1  1  || 1  1  0
    * 1  1  1  0  0  || 1  0  1
    * 1  1  1  0  1  || 1  1  0
    * 1  1  1  1  0  || 1  1  0
    * 1  1  1  1  1  || 1  1  1
    */
   a=0;b=0;cin=0;

   start=1 ;

   repeat (3) @(negedge clk);
   wait (ready == 1);
   @(posedge clk);
   a = 3;b=4;cin=0;
   @(posedge clk);
   a = 1;b=2;cin=0;
   @(posedge clk);
   a = 1;b=2;cin=1;

   @(posedge clk);
   a = 7;b=7;cin=1;

   @(posedge clk);

   a = 7;b=8;cin=1;

   @(posedge clk);
   a =0 ;b=0;cin=0;
   repeat (10) @(negedge clk);
   
   $stop; 

end
endmodule
