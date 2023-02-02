`timescale 1ns/1ns

module encoder_datapath(clk, rst,
                        file_index, iteration,
                        CP_start, CP_finish,
                        PE_start, PE_finish,
                        RC_start, RC_finish);
    
    input clk, rst;
    input [9:0] file_index;
    input [4:0] iteration;
    input CP_start, PE_start, RC_start;
    output CP_finish, PE_finish, RC_finish;

    // colParity module
    colParity CP (.clk(clk), .rst(rst), 
                    .file_index(file_index), .start(CP_start), .finish(CP_finish));

    // here comes rotate module


    // permute module
    permute PE (.clk(clk), 
                .start(PE_start), .finish(PE_finish), 
                .file_index(file_index));
    
    // here comes revaluate module
    

    // addRC module
    addRC RC (  .clk(clk),
                .start(RC_start), .finish(RC_finish),
                .file_index(file_index), .iteration(iteration));
    

endmodule