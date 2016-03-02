module adder_4bit_lut
(
    input clk,reset,
    input wire [3:0] a,b,
    input wire cin,
    input wire start,
    output reg ready,
    output wire [3:0] s,
    output wire cout
        
);
//state
localparam [1:0]
        idle = 2'b00,
        op = 2'b01;

//signals
reg [1:0] state;
reg [4:0] addr_lsb1,addr_msb2;
reg [3:0] msb1_in;
wire [2:0] dout_lsb1,dout_msb2;
reg [2:0] dout_lsb2;

//instantiate luts
table_lut lsb_unit
(.table_in(addr_lsb1), .table_out(dout_lsb1));

table_lut msb_unit
(.table_in(addr_msb2), .table_out(dout_msb2));

assign s = {dout_msb2[1], dout_msb2[0],dout_lsb2[1],dout_lsb2[0]};
assign cout = dout_msb2[2];

always @(posedge clk or posedge reset)
    if (reset)
    begin
        state <= idle;
    end
    else
    case (state)
        idle:
        begin
            if(start)
                state <= op;
            ready <= 1'b1;
        end
        op:
        begin
            addr_lsb1 <= {a[1],b[1],a[0],b[0],cin};
            msb1_in   <= {a[3],b[3],a[2],b[2]};
            addr_msb2 <= {msb1_in,dout_lsb1[2]};
            dout_lsb2 <= dout_lsb1;
        end
        default: state <= idle;
    endcase

endmodule

