`timescale 1ns/1ns

`define idle    3'd0
`define init    3'd1
`define cal     3'd2
`define check_y 3'd3
`define inc_x   3'd4
`define check_x 3'd5
`define done    3'd6

module parity_controller(clk, rst, cal_start, cal_finish, 
                        x_prev, x_cur, x_next, 
                        y_prev, y_cur, y_next);

    input clk, rst, cal_start;
    output reg cal_finish;

    output [2:0] x_prev, x_cur, x_next;
    output [2:0] y_prev, y_cur, y_next;

    reg clr, x_inc, y_inc;

    reg [2:0] pstate = `idle;
    reg [2:0] nstate;

    counter5 counter_x (.clk(clk), .rst(clr), .inc(x_inc), 
                        .prev(x_prev), .cur(x_cur), .next(x_next));

    counter5 counter_y (.clk(clk), .rst(clr), .inc(y_inc),
                        .prev(y_prev), .cur(y_cur), .next(y_next));

    always @(pstate, cal_start, x_cur, y_cur) begin
        {nstate, clr, x_inc, y_inc, cal_finish} = 7'b0;

        case (pstate) 
            `idle:      begin nstate = cal_start ? `init : `idle; end
            `init:      begin nstate = `cal; clr = 1'b1; end
            `cal:       begin nstate = `check_y; y_inc = 1'b1; end
            `check_y:   begin nstate = (y_cur == 3'd0) ? `inc_x : `cal; end
            `inc_x:     begin nstate = `check_x; x_inc = 1'b1; end
            `check_x:   begin nstate = (x_cur == 3'd0) ? `done : `cal; end
            `done:      begin nstate = `idle; cal_finish = 1'b1; end
            default:    begin nstate = `idle; end
        endcase
    end

    always @(posedge clk) begin
        if (rst)
            pstate <= `idle;
        else
            pstate <= nstate;
    end

endmodule