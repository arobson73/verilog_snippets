//test bench
`timescale 1 ns/ 10 ps

module carry_save_adder_test;

//signals
reg clk,reset;
reg [3:0] a,b,c,d,e,f;
wire [6:0] result;
localparam T= 20;
//debug
realtime capture=0.0;
//instantiate
//debug
/*
wire [3:0] g_reg,h_reg,i_reg,j_reg1;
wire [4:0] k_reg;
wire [3:0] l_reg,j_reg2;
wire [5:0] m_reg,n_reg;
wire [6:0] x_reg;
carry_save_adder csa_unit
(.clk(clk), .reset(reset), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .result(result), .g_reg(g_reg), .h_reg(h_reg), .i_reg(i_reg), .j_reg1(j_reg1), .k_reg(k_reg), .l_reg(l_reg), .j_reg2(j_reg2), .m_reg(m_reg), .n_reg(n_reg), .x_reg(x_reg));


*/
//instantiate
carry_save_adder csa_unit
(.clk(clk), .reset(reset), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .result(result));

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

    $display("testing CSA by summing 6 numbers");
    $timeformat(-6,6, " us",10);
    capture = $realtime;
    /*debug
    $monitor("a = %d, b = %d, c = %d, d= %d, e = %d, f = %d, result = %d, g_reg = %b, h_reg =%b, i_reg = %b, j_reg1 = %b, k_reg = %b, l_reg = %b, j_reg2 = %b, m_reg=%b, n_reg = %b, x_reg = %b",a, b, c,d,e,f,result,g_reg,h_reg,i_reg,j_reg1,k_reg,l_reg,j_reg2,m_reg,n_reg,x_reg );
    */
  $monitor("a = %d, b = %d, c = %d, d= %d, e = %d, f = %d, result = %d",a, b, c,d,e,f,result);
 
    $display("13 + 10 + 5 + 11 + 12 + 1 = %d",13+10+5+11+12+1);  
    a=13;b=10;c=5;d=11;e=12;f=1;
    repeat(50) @(negedge clk);

    $display("13 + 15 + 15 + 15 + 15 + 15 = %d",13+15+15+15+15+15);  
    a=13;b=15;c=15;d=15;e=15;f=15;

    repeat(50) @(negedge clk);

    $stop;
end
endmodule
