`timescale 1ns/1ns

module main_TB();

    reg clk = 0, rst = 1, start = 0;
    wire finish;
    reg [9:0] file_index;

    main UUT (  .clk(clk), .rst(rst), 
                .file_index(file_index), 
                .start(start), .finish(finish));

    always #5 clk = ~clk;

    initial begin 
        #50;
        rst = 0;
        #50;
        for (file_index = 1; file_index < 3; file_index = file_index + 1) begin
            start = 1;
            #30;
            start = 0;
            wait (finish);
        end
    end

endmodule