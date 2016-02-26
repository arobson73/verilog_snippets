//this is a group of 4 nand gates connected as required for addition

module nand_4_group
(
    input wire a,b,
    output wire o_l, //this is the output left most nand of the 4 nands
    output wire o_r //this is the output of the right most nand of the 4 nands
);
//output wire for top
wire l_t;
//output wire for  bottom
wire l_b;


//instantiate 4 nand gates

//this is the left nand
nand_gate nand_left
(.a(a), .b(b), .c(o_l));

//this is the  top nand
nand_gate nand_top
(.a(a), .b(o_l), .c(l_t));


//this is the  bottom nand
nand_gate nand_bot 
(.a(o_l), .b(b), .c(l_b));


//this is the  right  nand
nand_gate nand_right
(.a(l_t), .b(l_b), .c(o_r));

endmodule



