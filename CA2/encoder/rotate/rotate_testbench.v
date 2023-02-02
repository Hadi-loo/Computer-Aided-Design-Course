`timescale 1ns/1ns

module rotate_testbench();

    reg clk = 0, start = 0;
    wire finish;
    reg [9:0] file_index;

    rotate UUT (clk, start, finish, file_index);

    always #5 clk = ~clk;

    initial begin 
        #50;
        for (file_index = 1; file_index < 3; file_index = file_index + 1) begin
            start = 1;
            #30;
            start = 0;
            wait (finish);
        end
    end

endmodule