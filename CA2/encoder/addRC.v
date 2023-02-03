`timescale 1ns/1ns
module addRC(clk, start, finish, file_index, iteration);

    input clk, start;
    input [9:0] file_index;
    input [4:0] iteration;

    output finish;

    wire rst, read_file, write_reg, write_file;
    wire [5:0] line_index;

    addRC_datapath DP_ADDRC (.clk(clk), .rst(rst), 
                            .read_file(read_file), .write_file(write_file), .write_reg(write_reg), 
                            .file_index(file_index), .line_index(line_index), 
                            .iteration(iteration));

    addRC_controller CU_ADDRC (.clk(clk), .rst(rst), 
                                .line_index(line_index), .start(start), 
                                .read_file(read_file), .write_reg(write_reg), 
                                .write_file(write_file), .finish(finish));

endmodule