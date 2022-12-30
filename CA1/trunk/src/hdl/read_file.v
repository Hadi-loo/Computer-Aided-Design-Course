`timescale 1ns/1ns
module read_file(clk, rst, read, index, load_next_file, data_out);

    input clk, rst, read, load_next_file;
    input [9:0] index;

    output reg [24:0] data_out;
    reg [71:0] input_file_name;

    always @(posedge clk) begin
        if (load_next_file) begin 
            $sformat(input_file_name, "input_%0d.txt", index);
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            $fclose(input_file_name);
        end
        else if (read) begin
            $fscanf(input_file_name, "%b\n", data_out);
        end
    end

endmodule