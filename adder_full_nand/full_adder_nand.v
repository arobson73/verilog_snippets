//this is the top level module for the nand full adder

module full_adder_nand
(
    input wire a,b,cin,
    output wire s, cout
);

//output wire for left group of nands
wire l_o;
//wires for cout nand input
wire c1,c2;


//instantiate a nand gate for cout
nand_gate nand_unit
(.a(c1), .b(c2), .c(cout));

//instantiate first group of 4 nands
nand_4_group left_group
(.a(a), .b(b), .o_l(c2), .o_r(l_o));

//instantitate second group of 4 nands
nand_4_group right_group
(.a(l_o), .b(cin), .o_l(c1), .o_r(s));

endmodule
