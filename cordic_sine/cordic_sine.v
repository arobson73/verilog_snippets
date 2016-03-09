/*note this is not optimized, and also its not a pipelined version*/

module cordic_sine
(
    input wire clk,
    input wire reset,
    input wire load,
    input signed [15:0] angle,
    output reg done,
    output signed [15:0] co,
    output signed [15:0] so,
    //debug
    output enablew,
    output [3:0] index0w,index1w,countw,
    output signed [15:0] y0w,x0w,z0w,t1w,y1snw,x1snw,x1w,y1w,z1w,
    output [2:0] statew

);

//signals 
//
//state
localparam [2:0]
            idle = 3'd0,
            ld = 3'd1,
            wait_lut = 3'd2,
            op = 3'd3,
            fin = 3'd4;
reg [2:0] state_reg, state_next;
reg signed [15:0] x0,x0_n,x1,x1_n,y0,y0_n,y1,y1_n,z0,z0_n,z1,z1_n, x1s,y1s, t1;
reg [3:0] count,count_n;
reg [3:0] index0,index0_n,index1,index1_n;
reg enable;
reg signed [15:0] cor,sor;
wire signed [15:0] t1n,y1sn,x1sn;
reg [1:0] wait_count, wait_count_n;

//debug
assign enablew = enable;
assign index0w = index0;
assign index1w = index1;
assign countw = count;
assign y0w=y0;
assign x0w = x0;
assign z0w = z0;
assign t1w = t1;
assign y1snw = y1s;
assign x1snw = x1s;
assign x1w = x1;
assign y1w = y1;
assign z1w = z1;
assign statew = state_reg;


//instantiate lut
atan_lut atan_lut_unit
(.clk(clk), .enable(enable), .index(index0), .doutw(t1n));

shifter shifter_unit_y
(.clk(clk), .enable(enable), .index(index0), .in(y0), .doutw(y1sn));

shifter shifter_unit_x
(.clk(clk), .enable(enable), .index(index0), .in(x0), .doutw(x1sn));

assign co = cor;
assign so = sor;

always @(posedge clk or posedge reset)
    if (reset)
    begin
        state_reg <= idle;
        x0 <= 0;
        y0 <= 0;
        z0 <=0;
        x1 <= 0;
        y1 <= 0;
        z1 <= 0;
        t1 <= 0;
        y1s <= 0;
        x1s <=0;
        index0 <=0;
        count <= 0;
        enable <=1;
        wait_count <= 0;
    end
    else
    begin
        x0 <= x0_n;
        y0 <= y0_n;
        z0 <= z0_n;
        index0 <= index0_n;
        index1 <= index1_n;
        state_reg <= state_next;
        x1 <= x1_n;
        y1 <= y1_n;
        z1 <= z1_n;
        y1s <= y1sn;
        x1s <= x1sn;
        t1 <= t1n;
        count <= count_n;
        wait_count <= wait_count_n;
    end



always @*
begin
    z0_n = z0;
    x0_n = x0;
    y0_n = y0;
    count_n = count;
    index0_n = index0;
    index1_n = index1;
    state_next = state_reg;
    wait_count_n = wait_count;
    case (state_reg)
        idle:
        begin
            if (load)
                state_next = ld;
            done=0;
        end
        ld:
        begin
            x0_n = 9949;
            y0_n = 0;
            z0_n = angle;
            state_next = wait_lut;
            index0_n = 0;
            count_n = 12;
            wait_count_n =0;
        end
        wait_lut:
        begin
            x1_n = x0;
            y1_n = y0;
            z1_n = z0;
            index1_n = index0;
            if (wait_count > 0)
                state_next = op;
            wait_count_n = wait_count + 1;
        end
        op:
        begin
            if (z1 < 0)
            begin
                x0_n = x1 + y1s;
                y0_n = y1 - x1s;
                z0_n = z1 + t1;   
            end
            else
            begin
                x0_n = x1 - y1s;
                y0_n = y1 + x1s;
                z0_n = z1 - t1;
            end
            index0_n = index1 + 1;
            if (!count)
            begin
               state_next = fin;
            end
            else
            begin
               count_n = count -1;
               state_next =wait_lut; 
               wait_count_n = 0;
            end
        end
        fin:
        begin
            state_next = idle;
            cor = x0;
            sor = y0;
            done = 1;
        end
    endcase

end



   


endmodule
