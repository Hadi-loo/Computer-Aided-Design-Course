`timescale 1ns/1ns

module rotate_datapath(clk, rst, read_file, file_index, write_file);

    input clk, rst;
    input read_file, write_file;
    input [9:0] file_index;

    wire [1599:0] rotate_func_in;
    wire [1599:0] rotate_func_out;

    rotate_read_from_file ROTATE_RFF(.clk(clk), .rst(rst),
                                    .read_file(read_file), .file_index(file_index),
                                    .data_out(rotate_func_in));

    rotate_func ROTATE_FUNC(.page_in(rotate_func_in), .page_out(rotate_func_out));

    rotate_write_file ROTATE_WF(.clk(clk), .rst(rst),
                                .write_file(write_file), .file_index(file_index),
                                .data_in(rotate_func_out));


endmodule