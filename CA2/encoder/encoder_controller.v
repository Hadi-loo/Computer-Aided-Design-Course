`timescale 1ns/1ns

`define IDLE 4'd0
`define INIT 4'd1
`define CP_START 4'd2
`define CP_CAL 4'd3
`define RO_START 4'd4
`define RO_CAL 4'd5
`define PE_START 4'd6
`define PE_CAL 4'd7
`define RE_START 4'd8
`define RE_CAL 4'd9
`define RC_START 4'd10
`define RC_CAL 4'd11
`define IT_CHECK 4'd12
`define DONE 4'd13

module encoder_controller (clk, rst, 
                            start, finish, 
                            CP_start, CP_finish,
                            RO_start, RO_finish,
                            PE_start, PE_finish,
                            RE_start, RE_finish,
                            RC_start, RC_finish,
                            iteration);

    input clk, rst;
    input start;
    output reg finish;
    output reg CP_start, RO_start, PE_start, RE_start, RC_start;
    input CP_finish, RO_finish, PE_finish, RE_finish, RC_finish;
    output [4:0] iteration;

    reg [3:0] pstate = `IDLE;
    reg [3:0] nstate;

    reg cnt_inc;
    reg [4:0] counter;

    always @(pstate, start, CP_finish, RO_finish, PE_finish, RE_finish, RC_finish, counter) begin
        {nstate, CP_start, RO_start, PE_start, RE_start, RC_start, finish} = 10'b0;
        case (pstate)
            `IDLE: begin nstate = (start) ? `INIT : `IDLE; end
            `INIT: begin nstate = `CP_START; end
            `CP_START: begin nstate = `CP_CAL; CP_start = 1'b1; end
            `CP_CAL: begin nstate = (CP_finish) ? `RO_START : `CP_CAL; end
            `RO_START: begin nstate = `RO_CAL; RO_start = 1'b1; end
            `RO_CAL: begin nstate = (RO_finish) ? `PE_START : `RO_CAL; end
            `PE_START: begin nstate = `PE_CAL; PE_start = 1'b1; end
            `PE_CAL: begin nstate = (PE_finish) ? `RE_START : `PE_CAL; end
            `RE_START: begin nstate = `RE_CAL; RE_start = 1'b1; end
            `RE_CAL: begin nstate = (RE_finish) ? `RC_START : `RE_CAL; end
            `RC_START: begin nstate = `RC_CAL; RC_start = 1'b1; end
            `RC_CAL: begin nstate = (RC_finish) ? `IT_CHECK : `RC_CAL; end
            `IT_CHECK: begin nstate = (counter == 5'd23) ? `DONE : `CP_START; cnt_inc = 1'b1; end
            `DONE: begin nstate = `IDLE; finish = 1'b1; end
            default: begin nstate = `IDLE; end
        endcase
    end

    always @(posedge clk) begin
        if (rst) begin
            pstate <= `IDLE;
            counter <= 5'd0;
        end
        else begin
            pstate <= nstate;
            if (cnt_inc) begin
                counter <= counter + 1;
            end
        end
    end

    assign iteration = counter;

endmodule