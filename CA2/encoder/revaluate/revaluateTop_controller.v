`timescale 1ns/1ns

`define idle            3'd0
`define init            3'd1
`define read            3'd2
`define cal             3'd3
`define write           3'd4
`define done            3'd5

module revaluateTop_controller (clk, rst, start, read_file, write_file, finish, revaluate_start, revaluate_done);

    input clk, start;
    input revaluate_done;
    
    output reg read_file, write_file;
    output reg rst, finish;
    output reg revaluate_start;

    reg [2:0] pstate = `idle;
    reg [2:0] nstate;

    always @(pstate, start, revaluate_done) begin
        {rst, read_file, write_file, finish, revaluate_start} = 5'b0;
        case (pstate)
            `idle: begin nstate = (start) ? `init : `idle; end
            `init: begin nstate = `read; rst = 1'b1; read_file = 1'b1; end
            `read: begin nstate = `cal; revaluate_start = 1'b1; end
            `cal: begin nstate = (revaluate_done) ? `write : `cal; end
            `write: begin nstate = `done; write_file = 1'b1; end
            `done: begin nstate = `idle; finish = 1'b1; end
            default: begin nstate = `idle; end
        endcase
    end

    always @(posedge clk) begin
        pstate <= nstate;
    end

endmodule