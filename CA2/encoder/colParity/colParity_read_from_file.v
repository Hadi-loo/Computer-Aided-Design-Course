`timescale 1ns/1ns
module colParity_read_from_file(clk, rst, read_file, file_index, line_index, data_out);

    input clk, rst, read_file;
    input [9:0] file_index;
    input [5:0] line_index;

    reg [24:0] mem [63:0];
    output [24:0] data_out;
    reg [255:0] input_file_name;

    always @(posedge clk) begin 
	    if (read_file) begin    
            $sformat(input_file_name, "input_%0d_RCCP.txt", file_index);
            $readmemb(input_file_name, mem);
        end
    end

    assign data_out = mem[line_index];

endmodule