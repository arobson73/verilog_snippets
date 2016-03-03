//test bench
`timescale 1 ns/ 10 ps

module fast_multiplier_test;

//signals
localparam T = 20;
reg clk, reset;
reg [7:0] a, b;
wire [15:0] res;

//instantiate
fast_multiplier fast_multiplier_unit
(.clk(clk), .reset(reset), .a(a), .b(b), .res(res));

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
    $display("110 * 73 = %d", 73 * 110);
    a=110; b= 73;
    repeat (10) @(negedge clk);
    $stop;
end

endmodule
