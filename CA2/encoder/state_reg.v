`timescale 1ns/1ns

module state_reg (clk, rst, 
                    write_page, write_page_line_index, write_page_data, 
                    write_state, write_state_data,
                    load_state, file_index,
                    read_page_line_index, read_page_data,
                    read_state_data);
    
    input clk, rst;
    input write_page;
    input [5:0] write_page_line_index;
    input [24:0] write_page_data;
    input write_state;
    input [1599:0] write_state_data;
    input load_state;
    input [9:0] file_index;
    input [5:0] read_page_line_index;
    output [24:0] read_page_data;
    output [1599:0] read_state_data;
    
    reg [24:0] state [63:0];
    reg [255:0] input_file_name;
    
    always @(posedge clk) begin
        if (rst) begin
            state <= 0;
        end
        else if (load_state) begin
            $sformat(input_file_name, "input_%0d.txt", file_index);
            $readmemb(input_file_name, state);
        end
        else if (write_page) begin
            state[write_page_line_index] <= write_page_data;
        end
        else if (write_state) begin
            state <= write_state_data;
        end
    end

    assign read_page_data = state[read_page_line_index];
    assign read_state_data = state;

endmodule