`timescale 1ns/1ns

module colParity_datapath (clk, rst, read_file, file_index, line_index, write_reg1, write_reg2, cal_start, cal_finish, write_file);

    input clk, rst, read_file;
    input write_reg1, write_reg2;
    input cal_start;
    input write_file;
    input [9:0] file_index;
    input [5:0] line_index;
    output cal_finish;

    wire [24:0] cur_page_in;
    wire [24:0] cur_page_out;
    wire [24:0] prev_page_out;
    wire [24:0] parity_out;

    read_from_file colParity_RFF (.clk(clk), .rst(rst), 
                        .read_file(read_file), 
                        .file_index(file_index), .line_index(line_index), 
                        .data_out(cur_page_in));

    reg25 colParity_CUR_PAGE (.clk(clk), .rst(rst), 
                    .ld(write_reg1), .clr(rst), 
                    .in(cur_page_in), .out(cur_page_out));

    reg25 colParity_PREV_PAGE(.clk(clk), .rst(rst), 
                    .ld(write_reg2), .clr(rst), 
                    .in(cur_page_out), .out(prev_page_out));

    parity colParity_PARITY  (.clk(clk), .rst(rst), 
                    .cal_start(cal_start), .cal_finish(cal_finish), 
                    .cur_page(cur_page_out), .prev_page(prev_page_out), .parity_out(parity_out));

    write_file colParity_WF  (.clk(clk), .rst(rst), 
                    .write_file(write_file), 
                    .file_index(file_index), 
                    .data_in(parity_out));

endmodule