`timescale 1ns/1ns

module permute(clk, start, finish, file_index);

    input clk, start;
    input [9:0] file_index;

    output finish;

    wire rst, read_file, write_file, write_reg;
    wire [5:0] line_index;

    permute_datapath permute_DP(.clk(clk), .rst(rst), 
                .read_file(read_file), .file_index(file_index), 
                .line_index(line_index), .write_reg(write_reg), 
                .write_file(write_file));

    permute_controller permute_CU(.clk(clk), .rst(rst), 
                .start(start), .finish(finish),
                .read_file(read_file), .write_file(write_file),
                .line_index(line_index), .write_reg(write_reg));

endmodule