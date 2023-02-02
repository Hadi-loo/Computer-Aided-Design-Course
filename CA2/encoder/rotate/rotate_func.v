`timescale 1ns/1ns
`define NUM_PAGE 64
`define NUM_ROW 5
`define NUM_COLUMN 5
`define NUM_CELLS `NUM_PAGE * `NUM_COLUMN * `NUM_ROW
`define NUM_TURNS 24 
`define LEN_PAGE `NUM_COLUMN * `NUM_R

module rotate_func(page_in, page_out);

  // input [24:0] page_in[0:63];
  input [`NUM_PAGE * `NUM_COLUMN * `NUM_ROW - 1:0] page_in;
  output reg [`NUM_PAGE * `NUM_COLUMN * `NUM_ROW - 1:0] page_out;
  // output reg [24:0] page_out[0:63];
  integer lookUpTable [0:4][0:4];

  initial begin
    lookUpTable[0][0] = 0;
    lookUpTable[0][1] = 36;
    lookUpTable[0][2] = 3;
    lookUpTable[0][3] = 41;
    lookUpTable[0][4] = 18;
    
    lookUpTable[1][0] = 1;
    lookUpTable[1][1] = 44;
    lookUpTable[1][2] = 10;
    lookUpTable[1][3] = 45;
    lookUpTable[1][4] = 2;

    lookUpTable[2][0] = 62;
    lookUpTable[2][1] = 6;
    lookUpTable[2][2] = 43;
    lookUpTable[2][3] = 15;
    lookUpTable[2][4] = 61;

    lookUpTable[3][0] = 28;
    lookUpTable[3][1] = 55;
    lookUpTable[3][2] = 25;
    lookUpTable[3][3] = 21;
    lookUpTable[3][4] = 56;

    lookUpTable[4][0] = 27;
    lookUpTable[4][1] = 20;
    lookUpTable[4][2] = 39;
    lookUpTable[4][3] = 8;
    lookUpTable[4][4] = 14;
  end  

  integer shift_val;
  integer i,j,z;
  always @(page_in) begin
    for(j=0; j<5; j=j+1) begin
      for (i=0; i<5; i=i+1) begin
        for (z=0; z<64; z=z+1) begin   
          shift_val = lookUpTable[(i+3) % 5][(j+3) % 5];
          page_out[z * 25 + 5*j + i] = page_in[((z - shift_val) % 64) * 25 + 5*j + i];
        end
      end    
    end    
  end


endmodule