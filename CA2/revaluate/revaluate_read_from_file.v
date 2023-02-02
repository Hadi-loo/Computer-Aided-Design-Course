`timescale 1ns/1ns
module revaluate_read_from_file(clk, rst, read_file, file_index, data_out);

    input clk, rst, read_file;
    input [9:0] file_index;

    reg [24:0] mem [63:0];
    output [1599:0] data_out;
    reg [255:0] input_file_name;

    always @(posedge clk) begin 
	    if (read_file) begin    
            $sformat(input_file_name, "input_%0d.txt", file_index);
            $readmemb(input_file_name, mem);
        end
    end

    assign data_out = {mem[63], mem[62], mem[61], mem[60], 
                        mem[59], mem[58], mem[57], mem[56], mem[55], mem[54], mem[53], mem[52], mem[51], mem[50], 
                        mem[49], mem[48], mem[47], mem[46], mem[45], mem[44], mem[43], mem[42], mem[41], mem[40], 
                        mem[39], mem[38], mem[37], mem[36], mem[35], mem[34], mem[33], mem[32], mem[31], mem[30], 
                        mem[29], mem[28], mem[27], mem[26], mem[25], mem[24], mem[23], mem[22], mem[21], mem[20], 
                        mem[19], mem[18], mem[17], mem[16], mem[15], mem[14], mem[13], mem[12], mem[11], mem[10], 
                        mem[9], mem[8], mem[7], mem[6], mem[5], mem[4], mem[3], mem[2], mem[1], mem[0]};

endmodule