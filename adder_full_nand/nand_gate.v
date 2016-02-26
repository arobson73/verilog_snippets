//simple nand gate
module nand_gate
(
    input wire a,b,
    output wire c
);
assign c = ~(a & b);
endmodule
