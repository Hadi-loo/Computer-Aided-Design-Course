`timescale 1ns/1ns

module revaluateTop(clk, file_index, start, finish);

    input clk;
    input [9:0] file_index;
    input start;

    output finish;

    wire rst;
    wire read_file, write_file;
    wire revaluate_start, revaluate_done;

    revaluateTop_datapath REVALUATETOP_DP (.clk(clk), .rst(rst),
        .read_file(read_file), .write_file(write_file),
        .file_index(file_index),
        .revaluate_start(revaluate_start), .revaluate_done(revaluate_done));

    revaluateTop_controller REVALUATETOP_CU (.clk(clk), .rst(rst),
        .start(start), .finish(finish),
        .read_file(read_file), .write_file(write_file),
        .revaluate_start(revaluate_start), .revaluate_done(revaluate_done));

endmodule