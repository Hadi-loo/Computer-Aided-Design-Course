`timescale 1ns/1ns
module consts(iteration, const);
    input [4:0] iteration;
    output reg [63:0] const;

    always @(iteration) begin 
        case(iteration)
            5'd0: const = 64'h0000000000000001;
            5'd1: const = 64'h0000000000008082;
            5'd2: const = 64'h800000000000808a;
            5'd3: const = 64'h8000000080008000;
            5'd4: const = 64'h000000000000808b;
            5'd5: const = 64'h0000000080000001;
            5'd6: const = 64'h8000000080008081;
            5'd7: const = 64'h8000000000008009;
            5'd8: const = 64'h000000000000008a;
            5'd9: const = 64'h0000000000000088;
            5'd10: const = 64'h0000000080008009;
            5'd11: const = 64'h000000008000000a;
            5'd12: const = 64'h000000008000808b;
            5'd13: const = 64'h800000000000008b;
            5'd14: const = 64'h8000000000008089;
            5'd15: const = 64'h8000000000008003;
            5'd16: const = 64'h8000000000008002;
            5'd17: const = 64'h8000000000000080;
            5'd18: const = 64'h000000000000800a;
            5'd19: const = 64'h800000008000000a;
            5'd20: const = 64'h8000000080008081;
            5'd21: const = 64'h8000000000008080;
            5'd22: const = 64'h0000000080000001;
            5'd23: const = 64'h8000000080008008;
            default: const = 64'h0000000000000000;
        endcase
    end
endmodule