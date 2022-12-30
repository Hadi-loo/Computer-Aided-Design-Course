`timescale 1ns/1ns
module write_file(clk, rst, write, index, load_next_file, data_in);

    input clk, rst, write, load_next_file;
    input [9:0] index;
    input [24:0] data_in;

    reg [71:0] output_file_name;

    always @(posedge clk) begin
        if (load_next_file) begin 
            $sformat(output_file_name, "output_%0d.txt", index);
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            $fclose(output_file_name);
        end
        else if (write_reg) begin
            $fwrite(output_file_name, "%0b", data_in);
        end
    end

endmodule