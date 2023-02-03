`timescale 1ns/1ns
module permute_write_file(clk, rst, write_file, file_index, data_in);

    input clk, rst, write_file;
    input [9:0] file_index;
    input [24:0] data_in;

    reg [255:0] output_file_name;
	integer fd;	

    always @(posedge clk) begin
        if (rst) begin
            $fclose(output_file_name);
        end
        else if (write_file) begin 
            $sformat(output_file_name, "%0d_PERE.txt", file_index);
		    fd = $fopen(output_file_name, "a");
            $fwriteb(fd, data_in);
		    $fwrite(fd, "\n");
		    $fclose(fd);
        end
    end

endmodule