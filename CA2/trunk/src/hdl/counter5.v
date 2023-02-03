`timescale 1ns/1ns

module counter5(clk, rst, inc, prev, cur, next);

    input clk, rst, inc;
    output reg [2:0] prev, cur, next;

    always @(posedge clk) begin
        if (rst) begin 
            prev <= 3'd4;
            cur <= 3'd0;
            next <= 3'd1;
        end
        else if (inc) begin
            prev <= cur;
            cur <= next;
            if (next == 3'd4)
                next <= 3'd0;
            else
                next <= next + 1;
        end
    end

endmodule