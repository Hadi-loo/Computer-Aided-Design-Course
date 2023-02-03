`timescale 1ns/1ns

module encdoer_testbench();

    reg clk = 0;
    reg rst = 1;
    reg start = 0;
    wire finish;
    reg [9:0] file_index;

    encoder UUT (.clk(clk), .rst(rst),
                .start(start), .finish(finish),
                .file_index(file_index));

    always #5 clk = ~clk;

    initial begin 
        #50
        rst = 0;
        #50
        for (file_index = 0; file_index < 8; file_index = file_index + 1) begin
            start = 1;
            #30
            start = 0;
            wait(finish);
        end
    end


endmodule