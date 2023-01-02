`timescale 1ns/1ns

module main(clk, rst, file_index, start, finish);

    input clk, rst;
    input [9:0] file_index;
    input start;
    output finish;

    wire read_file;
    wire write_file;
    wire [5:0] line_index;
    wire write_reg1, write_reg2;
    wire cal_start;
    wire cal_finish;

    datapath DP (.clk(clk), .rst(rst), 
                .read_file(read_file), .file_index(file_index), .line_index(line_index), 
                .write_reg1(write_reg1), .write_reg2(write_reg2), 
                .cal_start(cal_start), .cal_finish(cal_finish), .write_file(write_file));

    controller CU ( .clk(clk), .rst(rst), 
                    .start(start), .read_file(read_file), 
                    .write_reg1(write_reg1), .write_reg2(write_reg2), 
                    .cal_start(cal_start), .cal_finish(cal_finish), 
                    .write_file(write_file), .line_index(line_index), 
                    .finish(finish));

endmodule