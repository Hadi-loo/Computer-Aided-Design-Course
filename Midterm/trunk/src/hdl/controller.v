`timescale 1ns/1ns

`define idle                4'd0
`define init1               4'd1
`define read                4'd2
`define init2               4'd3
`define update_prev_page    4'd4
`define load_cur_page       4'd5
`define cal                 4'd6
`define write_to_file       4'd7
`define done                4'd8

module controller(clk, rst, start, read_file, write_reg1, write_reg2, cal_start, cal_finish, write_file, line_index, finish);

    input clk, rst, start;
    input cal_finish;
    output reg read_file;
    output reg write_reg1, write_reg2;
    output reg cal_start;
    output reg write_file;
    output reg finish;
    output [5:0] line_index;

    reg ld_cnt, inc_cnt;

    reg [3:0] pstate = `idle;
    reg [3:0] nstate;

    counter64 COUNTER64 (.clk(clk), .rst(rst), .inc(inc_cnt), .ld(ld_cnt), .cnt(line_index));

    always @(pstate, start, cal_finish, line_index) begin
        {nstate, read_file, ld_cnt, write_reg1, write_reg2, inc_cnt, cal_start, write_file, finish} = 12'b0;

        case (pstate)
            `idle:              begin nstate = (start) ? `init1 : `idle; end
            `init1:             begin nstate = `read; read_file = 1'b1; end
            `read:              begin nstate = `init2; ld_cnt = 1'b1; end
            `init2:             begin nstate = `update_prev_page; write_reg1 = 1'b1; end
            `update_prev_page:  begin nstate = `load_cur_page; write_reg2 = 1'b1; inc_cnt = 1'b1; end
            `load_cur_page:     begin nstate = `cal; write_reg1 = 1'b1; cal_start = 1'b1; end
            `cal:               begin nstate = (cal_finish) ? `write_to_file : `cal; end
            `write_to_file:     begin nstate = (line_index == 6'd63) ? `done : `update_prev_page; write_file = 1'b1; end
            `done:              begin nstate = `idle; finish = 1'b1; end
            default:            begin nstate = `idle; end
        endcase
    end

    always @(posedge clk or posedge rst)
        if (rst)
            pstate <= `idle;
        else
            pstate <= nstate;

endmodule