//simple 1 bit carry save adder, this is not optimal!

module csa_1
(
    input a,b,cin,
    output s,cout
);

wire [1:0] res;
assign res = a + b + cin;
assign s = res[0];
assign cout = res[1];


endmodule
