//this example will add 6 numbers each of 4 bit width
//here we will use registers to store the intermediate values, this is 
//just to minimize fan-out.  
//
//google - "Carry Save Adder" and refer to the course notes from Imperial college. 
//Since this code is based on the picture of the CSA in those notes.


module carry_save_adder
(
    input wire clk,reset,
    input wire [3:0] a,b,c,d,e,f,
    output wire [6:0] result // max number is 90 so, 7 bits for result
    //debug
    /*
    output reg [3:0] g_reg, h_reg,i_reg, j_reg1,
    output reg [4:0] k_reg,
    output reg [3:0] l_reg,j_reg2,    
    output reg [5:0] m_reg,n_reg,
    output reg [6:0] x_reg
*/
);

//signals
reg [3:0]  g_reg;
reg [3:0]  h_reg;
reg [3:0] i_reg;
reg [3:0] j_reg1, j_reg2;
reg [4:0]  k_reg;
reg [3:0]  l_reg;
reg [5:0]  m_reg;
reg [5:0]  n_reg;
reg [6:0]  x_reg;

wire [5:0] n_next;
wire [3:0] l_next;
wire [3:0] j_next1;
wire [3:0] i_next;
wire [3:0] g_next;
wire [4:0] k_next;
wire [5:0] m_next;
wire [6:0] x_next;
wire [3:0] k_part;
wire [3:0] h_part;
wire [3:0] m_part;
wire [3:0] n_part;
wire [3:0] h_next;


//compute a,b,c sum
csa_4 csa_abc_unit
(.a(a), .b(b), .cin(c), .s(g_next), .cout(h_next));

//compute d, e, f sum
csa_4 csa_def_unit
(.a(d), .b(e), .cin(f), .s(i_next), .cout(j_next1));

//compute g, h, i sum
csa_4 csa_ghi_unit
(.a(g_reg), .b(h_part), .cin(i_reg), .s(k_part), .cout(l_next));

//compute k, l, j sum
csa_4 csa_klj_unit
(.a(k_reg[4:1]), .b(l_reg), .cin(j_reg2), .s(m_part), .cout(n_part));


assign h_part ={h_reg[2:0],1'b0};
assign k_next = {h_reg[3],k_part};
assign m_next = {1'b0,m_part,k_reg[0]};
assign n_next = {n_part,2'b0};

//now final adder - cheat and just just use + 
//we should use a library call for an full adder here
//and likewise for the calls to carry save adder's  
//assuming they are in the library
assign x_next = {1'b0,m_next} + {1'b0,n_next};
assign result = x_reg; 

   always @(posedge clk, posedge reset)
     if (reset)
     begin
         g_reg <= 4'd0;
         h_reg <= 4'd0;
         i_reg <= 4'd0;
         j_reg1 <= 4'd0;
         j_reg2 <= 4'd0;
         k_reg <= 5'd0;
         l_reg <= 4'd0;
         m_reg <= 5'd0;
         n_reg <= 4'd0;
         x_reg <= 6'd0;
     end
     else
     begin
         g_reg <= g_next;
         h_reg <= h_next;
         i_reg <= i_next;
         j_reg1 <= j_next1;
         j_reg2 <= j_reg1;
         k_reg <= k_next;
         l_reg <= l_next;
         m_reg <= m_next;
         n_reg = n_next;
         x_reg <= x_next;
     end
endmodule
