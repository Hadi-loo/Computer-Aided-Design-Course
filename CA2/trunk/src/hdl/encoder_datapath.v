`timescale 1ns/1ns

module encoder_datapath(clk, rst,
                        file_index, iteration,
                        CP_start, CP_finish,
                        RO_start, RO_finish,
                        PE_start, PE_finish,
                        RE_start, RE_finish,
                        RC_start, RC_finish);
    
    input clk, rst;
    input [9:0] file_index;
    input [4:0] iteration;
    input CP_start, RO_start, PE_start, RE_start, RC_start;
    output CP_finish, RO_finish, PE_finish, RE_finish, RC_finish;

    // colParity module
    colParity CP (  .clk(clk), .rst(rst),  
                    .start(CP_start), .finish(CP_finish),
                    .file_index(file_index));

    // rotate module
    rotate RO (     .clk(clk), 
                    .start(RO_start), .finish(RO_finish), 
                    .file_index(file_index));

    // permute module
    permute PE (    .clk(clk), 
                    .start(PE_start), .finish(PE_finish), 
                    .file_index(file_index));
    
    // revaluate module
    revaluate RE (   .clk(clk), 
                        .start(RE_start), .finish(RE_finish), 
                        .file_index(file_index));

    // addRC module
    addRC RC (      .clk(clk),
                    .start(RC_start), .finish(RC_finish),
                    .file_index(file_index), .iteration(iteration));
    

endmodule