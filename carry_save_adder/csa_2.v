//simple 2 bit carry save adder, this is not optimal!

module csa_2
(
    input wire [1:0] a,b,cin,
    output wire [1:0] s, cout
);

//instantiate 2 csa_1 bits
csa_1 csa_bit0_unit
(.a(a[0]), .b(b[0]), .cin(cin[0]), .s(s[0]), .cout(cout[0]));

csa_1 csa_bit1_unit
(.a(a[1]), .b(b[1]), .cin(cin[1]), .s(s[1]), .cout(cout[1]));

endmodule

