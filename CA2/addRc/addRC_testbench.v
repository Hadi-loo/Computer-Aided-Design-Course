`timescale 1ns/1ns
module addRC_testbecnh();

    reg clk = 0, start = 0;
    wire finish;
    reg [9:0] file_index;
    reg [4:0] iteration = 4'd0;

    addRC UUT (.clk(clk), .start(start), .finish(finish), .file_index(file_index), .iteration(iteration));

    always #5 clk = ~clk;
    initial begin 
        for (file_index = 1; file_index < 3; file_index = file_index + 1) begin
            start = 1;
            #20;
            start = 0;
            wait (finish);
	    iteration = 4'd2;
        end
    end

endmodule