`timescale 1ns/1ns
module revaluate_write_file(clk, rst, write_file, file_index, data_in);

    input clk, rst, write_file;
    input [9:0] file_index;
    input [1599:0] data_in;

    reg [255:0] output_file_name;
    integer fd, i, start_index;	

    always @(posedge clk) begin
        if (rst) begin
            $fclose(output_file_name);
        end
        else if (write_file) begin 
            $sformat(output_file_name, "%0d_RERC.txt", file_index);
            fd = $fopen(output_file_name, "w");
            for (i = 63; i >= 0; i=i-1) begin
		        start_index = i*25+24;
                $fwriteb(fd, data_in[start_index-: 25]);
                $fwrite(fd, "\n");
            end
            $fclose(fd);
        end
    end

endmodule