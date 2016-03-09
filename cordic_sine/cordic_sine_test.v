`timescale 1 ns/ 10 ps

module cordic_sine_test;

localparam T= 20;

//signals
reg clk;
reg reset;
reg load;
wire done;
reg signed [15:0] angle;
wire signed [15:0] co,so;

//debug
wire  enablew ;
wire [3:0]  index0w ;
wire [3:0] index1w;
wire [3:0] countw ;
wire signed [15:0] y0w,x0w,z0w,t1w,y1snw,x1snw,x1w,y1w,z1w;
wire [2:0] statew;


//instantiate
cordic_sine cordic_sine_unit
(.clk(clk), .reset(reset), .load(load), .angle(angle), .done(done), .co(co), .so(so),
.enablew(enablew), .index0w(index0w), .index1w(index1w), .countw(countw), .y0w(y0w), .x0w(x0w), .z0w(z0w), .t1w(t1w), .y1snw(y1snw), .x1snw(x1snw), .x1w(x1w), .y1w(y1w), .z1w(z1w), .statew(statew));


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
    load =0;
end


initial
begin
    repeat(5) @(posedge clk);
    load=1;
    angle=9186; //0.5607 in q14
    @(posedge clk);
    load = 0;
    wait (done == 1);
    @(posedge clk);
    load=1;
    angle = 17157; //pi/3 in q14

    @(posedge clk);
    load = 0;
    wait (done == 1);
    repeat (50) @(posedge clk);
    $stop;

end
endmodule
