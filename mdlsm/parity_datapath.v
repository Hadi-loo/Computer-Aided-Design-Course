`timescale 1ns/1ns

module parity_datapath (cur_page, prev_page,
                        x_prev, x_cur, x_next,
                        y_cur,
                        parity_out);

    input [0:24] cur_page;
    input [0:24] prev_page;
    input [2:0] x_prev, x_cur, x_next;
    input [2:0] y_cur;

    output reg [0:24] parity_out;

    reg col1, col2;

    always @(x_prev, x_cur, x_next, y_cur) begin
        col1 = cur_page[x_prev] ^ cur_page[5 + x_prev] ^ cur_page[10 + x_prev] ^ cur_page[15 + x_prev] ^ cur_page[20 + x_prev];
        col2 = prev_page[x_next] ^ prev_page[5 + x_next] ^ prev_page[10 + x_next] ^ prev_page[15 + x_next] ^ prev_page[20 + x_next];
        parity_out[x_cur*5 + y_cur] = cur_page[x_cur*5 + y_cur] ^ col1 ^ col2;
    end

endmodule