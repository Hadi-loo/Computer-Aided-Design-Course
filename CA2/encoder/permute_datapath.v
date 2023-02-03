`timescale 1ns/1ns

module permute_datapath (clk, rst, read_file, file_index, line_index, write_reg, write_file);

    input clk, rst, read_file, write_reg, write_file;
    input [9:0] file_index;
    input [5:0] line_index;

    wire [24:0] reg25_in;
    wire [24:0] reg25_out;
    wire [24:0] perm_out;

    permute_read_file permute_RF (.clk(clk), .rst(rst), 
                        .read_file(read_file), .file_index(file_index), 
                        .line_index(line_index), .data_out(reg25_in));

    reg25 permute_Reg25 (.clk(clk), .rst(rst), 
                .ld(write_reg), .clr(rst), 
                .in(reg25_in), .out(reg25_out));

    permutaion permute_Permutation (.in(reg25_out), .out(perm_out));

    permute_write_file permute_WF (.clk(clk), .rst(rst), 
                        .write_file(write_file), .file_index(file_index),
                        .data_in(perm_out));
    
endmodule