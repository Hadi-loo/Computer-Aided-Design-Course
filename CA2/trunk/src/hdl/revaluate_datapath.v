`timescale 1ns/1ns

module revaluate_datapath (clk, rst, read_file, file_index, line_index, write_reg, write_file);

    input clk, rst, read_file, write_reg, write_file;
    input [9:0] file_index;
    input [5:0] line_index;

    wire [24:0] reg25_in;
    wire [24:0] reg25_out;
    wire [24:0] reval_out;

    revaluate_read_file revaluate_RF (.clk(clk), .rst(rst), 
                        .read_file(read_file), .file_index(file_index), 
                        .line_index(line_index), .data_out(reg25_in));

    reg25 revaluate_Reg25 (.clk(clk), .rst(rst), 
                .ld(write_reg), .clr(rst), 
                .in(reg25_in), .out(reg25_out));

    revaluate_func revaluate_RFUNC (.p_in(reg25_out), .p_out(reval_out));

    revaluate_write_file revaluate_WF (.clk(clk), .rst(rst), 
                        .write_file(write_file), .file_index(file_index),
                        .data_in(reval_out));
    
endmodule