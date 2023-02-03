`timescale 1ns/1ns

module counter64(clk, rst, inc, ld, cnt);

    input clk, rst, inc, ld;
    output reg [5:0] cnt;

    always @(posedge clk or posedge rst)
        if (rst)
            cnt <= 0;
        else if (ld)
            cnt <= 6'd63;
        else if (inc)
            cnt <= cnt + 1;

endmodule