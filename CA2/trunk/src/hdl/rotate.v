`timescale 1ns/1ns

module rotate(clk, start, finish, file_index);

    input clk;
    input start;
    output finish;
    input [9:0] file_index;

    wire rst;
    wire read_file, write_file;

    rotate_datapath ROTATE_DP (.clk(clk), .rst(rst), 
                                .read_file(read_file), .write_file(write_file), 
                                .file_index(file_index));

    rotate_controller ROTATE_CU (.clk(clk), .rst(rst), 
                                .start(start), .finish(finish), 
                                .read_file(read_file), .write_file(write_file));

endmodule