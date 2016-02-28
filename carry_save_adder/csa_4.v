//simple 4 bit carry save adder, this is not optimal!

module csa_4
(
    input wire [3:0] a,b,cin,
    output wire [3:0] s, cout
);

//instantiate 2 csa_2 modules (2 2 bit csa's)

csa_2 csa_bit_1_to_0_unit
(.a(a[1:0]), .b(b[1:0]), .cin(cin[1:0]), .s(s[1:0]), .cout(cout[1:0]));

csa_2 csa_bit_3_to_2_unit
(.a(a[3:2]), .b(b[3:2]), .cin(cin[3:2]), .s(s[3:2]), .cout(cout[3:2]));

endmodule

