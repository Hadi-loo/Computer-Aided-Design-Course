`timescale 1ns/1ns
module write_file(clk, rst, write_file, file_index, data_in);

    input clk, rst, write_file;
    input [9:0] file_index;
    input [24:0] data_in;

    reg [71:0] output_file_name;

    always @(posedge clk) begin
        if (rst) begin
            $fclose(output_file_name);
        end
        else if (write_file) begin 
            $sformat(output_file_name, "output_%0d.txt", index);
            $fwrite(output_file_name, "%0b", data_in);
        end
    end

endmodule