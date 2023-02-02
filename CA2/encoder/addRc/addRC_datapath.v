`timescale 1ns/1ns
module addRC_datapath(  clk, rst, 
                        read_file, write_file, write_reg, 
                        file_index, line_index, 
                        iteration);

    input clk, rst;
    input read_file;
    input write_reg;
    input write_file;
    input [9:0] file_index;
    input [5:0] line_index;
    input [4:0] iteration;

    wire [24:0] reg_in;
    wire [24:0] reg_out;
    wire [63:0] const;
    wire [24:0] write_in;

    addRC_read_from_file addRC_RFF(.clk(clk), .rst(rst), 
                        .read_file(read_file), .file_index(file_index), .line_index(line_index), 
                        .data_out(reg_in));

    reg25 addRC_REG25 (.clk(clk), .rst(rst), 
                .ld(write_reg), .clr(rst), 
                .in(reg_in), .out(reg_out));

    consts addRC_CONSTS (.iteration(iteration), .const(const));

    addRC_func ADDRC_FUNC (.clk(clk), .rst(rst), 
                            .line_index(line_index), .page(reg_out), .lane(const), 
                            .page_out(write_in));

    addRC_write_file addRC_WF (.clk(clk), .rst(rst), 
                    .write_file(write_file), .file_index(file_index),
                    .data_in(write_in));

endmodule