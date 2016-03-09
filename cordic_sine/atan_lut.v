module atan_lut
(
    input wire clk,
    input wire enable,
    input [3:0] index,
    output signed [15:0] doutw
);

reg signed [15:0] dout;

assign doutw = dout;

always @(posedge clk)
    if (enable)
        case (index)
            4'd0 : dout <= 16'd12867;
            4'd1 : dout <= 16'd7596;
            4'd2 : dout <= 16'd4013;
            4'd3 : dout <= 16'd2037;
            4'd4 : dout <= 16'd1022;
            4'd5 : dout <= 16'd511;
            4'd6 : dout <= 16'd255;
            4'd7 : dout <= 16'd127;
            4'd8 : dout <= 16'd63;
            4'd9 : dout <= 16'd31;
            4'd10 : dout <= 16'd15;
            4'd11 : dout <= 16'd7;
            4'd12 : dout <= 16'd3;
            4'd13 : dout <= 16'd1;
            default : dout <= 0;
        endcase
          
endmodule


