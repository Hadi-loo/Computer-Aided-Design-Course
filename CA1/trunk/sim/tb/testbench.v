`timescale 1ns/ns

module testbench();

    reg clk = 0, start = 0;
    wire finish;
    reg [9:0] file_index;

    main UUT (.clk(clk), .start(start), .finish(finish), .file_index(file_index));

    always #5 clk = ~clk;
    initial begin 
        for (file_index = 0; file_index < 3; file_index = file_index + 1) begin
            start = 1;
            #20;
            start = 0;
            wait (finish);
        end
    end

endmodule