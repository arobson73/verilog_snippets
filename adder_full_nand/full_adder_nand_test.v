//test bench
`timescale 1 ns/ 10 ps

module full_adder_nand_test;

//signals
reg a,b,cin;
wire s, cout;
localparam T= 20;
//debug
realtime capture=0.0;
//instantiate

full_adder_nand full_adder_nand_unit
(.a(a), .b(b), .cin(cin), .s(s), .cout(cout));

initial
begin
    a=0;
    b=0;
    cin=0;
end

initial
begin

    $display("testing nand full adder");
    $timeformat(-6,6, " us",10);
    capture = $realtime;
    $monitor("a = %b, b = %b, cin = %b, s = %b, cout = %b",a, b, cin, s, cout);
    a=0;b=0;cin=0;
    #(T/2);
    a=1;b=0;cin=0;
    #(T/2);
    a=0;b=1;cin=0;
    #(T/2);
    a=1;b=1;cin=0;
    #(T/2);
    a=0;b=0;cin=1;
    #(T/2);
    a=1;b=0;cin=1;
    #(T/2);
    a=0;b=1;cin=1;
    #(T/2);
    a=1;b=1;cin=1;
    #(T/2);
    $stop;
end
endmodule
