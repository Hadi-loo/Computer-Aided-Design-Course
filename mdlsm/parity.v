`timescale 1ns/1ns

module parity(clk, rst, cal_start, cal_finish, cur_page, prev_page, parity_out);

    input clk, rst, cal_start;
    input [0:24] cur_page;
    input [0:24] prev_page;

    output cal_finish;
    output [0:24] parity_out;

    wire [2:0] x_prev, x_cur, x_next;
    wire [2:0] y_prev, y_cur, y_next;

    parity_datapath PDP(.cur_page(cur_page), .prev_page(prev_page),
                        .x_prev(x_prev), .x_cur(x_cur), .x_next(x_next),
                        .y_cur(y_cur),
                        .parity_out(parity_out));
    
    parity_controller PC(.clk(clk), .rst(rst), 
                        .cal_start(cal_start), .cal_finish(cal_finish),
                        .x_prev(x_prev), .x_cur(x_cur), .x_next(x_next),
                        .y_prev(y_prev), .y_cur(y_cur), .y_next(y_next));

endmodule