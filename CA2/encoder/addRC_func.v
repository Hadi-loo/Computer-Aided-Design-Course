`timescale 1ns/1ns

module addRC_func(clk, rst, line_index, page, lane, page_out);
    input clk, rst;
    input [5:0] line_index;
    input [24:0] page;
    input [0:63] lane;
    output reg [24:0] page_out;

    assign page_out[24:13] = page[24:13];
    assign page_out[12] = page[12] ^ lane[line_index];
    assign page_out[11:0] = page[11:0];

endmodule