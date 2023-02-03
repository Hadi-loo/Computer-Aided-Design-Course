`timescale 1ns/1ns

module encoder(clk, rst, start, finish, file_index);

    input clk, rst, start;
    input [9:0] file_index;

    output finish;

    wire [4:0] iteration;
    wire CP_start, RO_start, PE_start, RE_start, RC_start;
    wire CP_finish, RO_finish, PE_finish, RE_finish, RC_finish;
 
    encoder_datapath ENCODER_DP (.clk(clk), .rst(rst),
        .CP_start(CP_start), .RO_start(RO_start), .PE_start(PE_start), .RE_start(RE_start), .RC_start(RC_start),
        .CP_finish(CP_finish), .RO_finish(RO_finish), .PE_finish(PE_finish), .RE_finish(RE_finish), .RC_finish(RC_finish),
        .iteration(iteration), .file_index(file_index));

    encoder_controller ENCODER_CU (.clk(clk), .rst(rst),
        .start(start), .finish(finish),
        .CP_start(CP_start), .RO_start(RO_start), .PE_start(PE_start), .RE_start(RE_start), .RC_start(RC_start),
        .CP_finish(CP_finish), .RO_finish(RO_finish), .PE_finish(PE_finish), .RE_finish(RE_finish), .RC_finish(RC_finish),
        .iteration(iteration));


endmodule