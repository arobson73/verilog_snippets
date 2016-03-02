//table lut
module table_lut
(
    input wire [4:0] table_in,
    output reg [2:0] table_out

);

always @(table_in)
begin
    case (table_in)
        5'b00000 : table_out = 3'b000;
        5'b00001,5'b00100,5'b00010 : table_out = 3'b001;
        5'b00011,5'b00101,5'b10000,5'b00110,5'b01000 : table_out = 3'b010;
        5'b00111,5'b01001,5'b01010,5'b01100,5'b10001,5'b10010,5'b10100 : table_out = 3'b011;
        5'b01011,5'b01101,5'b01110,5'b10011,5'b10101,5'b10110,5'b11000 : table_out = 3'b100;
        5'b01111,5'b10111,5'b11001,5'b11010,5'b11100 : table_out = 3'b101;
        5'b11011,5'b11101,5'b11110 : table_out = 3'b110;
        default : table_out = 3'b111;
    endcase
end
endmodule
