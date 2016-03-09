module shifter
(
    input wire clk,
    input wire enable,
    input wire [3:0] index,
    input signed [15:0] in,
    output signed [15:0] doutw
);

reg signed [15:0] dout;

assign doutw=dout;
always @(posedge clk)
    if (enable)
        case (index)
            4'd0 : dout <= in;
            4'd1 : dout <= (in >> 1);
            4'd2 : dout <= (in >> 2);
            4'd3 : dout <= (in >> 3);
            4'd4 : dout <= (in >> 4);
            4'd5 : dout <= (in >> 5);
            4'd6 : dout <= (in >> 6);
            4'd7 : dout <= (in >> 7);
            4'd8 : dout <= (in >> 8);
            4'd9 : dout <= (in >> 9);
            4'd10 : dout <= (in >> 10);
            4'd11 : dout <= (in >> 11);
            4'd12 : dout <= (in >> 12);
            default : dout <= in;
        endcase
          
endmodule

