`timescale 1ns/1ns

module revaluateTop_datapath(clk, rst, read_file, write_file, file_index, revaluate_start, revaluate_done);

    input clk, rst;
    input read_file, write_file;
    input [9:0] file_index;
    input revaluate_start;
    output revaluate_done;

    wire [1599:0] revaluate_in;
    wire [1599:0] revaluate_out;

    revaluate_read_from_file REVALUATE_RFF (.clk(clk), .rst(rst),
                                            .read_file(read_file), .file_index(file_index),
                                            .data_out(revaluate_in));
    
    Revaluate REVALUATE (.clk(clk), .rst(rst),
                         .data_in(revaluate_in), .data_out(revaluate_out),
                         .start(revaluate_start), .done(revaluate_done));

    revaluate_write_file REVALUATE_WF (.clk(clk), .rst(rst),
                                       .write_file(write_file), .file_index(file_index),
                                       .data_in(revaluate_out));

endmodule