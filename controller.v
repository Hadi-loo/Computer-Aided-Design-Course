`timescale 1ns/1ns
`define idle 3'b000
`define init 3'b001
`define read 3'b010
`define reg_write 3'b011
`define cal 3'b100
`define write 3'b101
`define done 3'b110

module controller(clk, index, start, rst, read_file, finish_read, write_reg, cal_finish, write_file, finish);
  input clk, start, finish_read, cal_finish;
  output reg read_file, write_reg, write_file, finish;
  output reg rst;
  output index;
  reg [2:0] pstate = `idle, nstate;
  reg cnt_inc;

  always @(pstate, start, finish_read, cal_finish, counter) begin
    {nstate, rst, read_file, write_reg, cnt_inc, write_file, finish} = 9'b0;
    case(pstate)
      `idle: begin nstate = (start) ? `init: `idle; end
      `init: begin nstate = `read; rst = 1'b1; read_file = 1'b1; end
      `read: begin nstate = finish_read ? `reg_write : `read; end
      `reg_write: begin nstate = `cal; write_reg = 1'b1; cnt_inc = 1'b1; end
      `cal: begin nstate = cal_finish ? `write : `cal; end
      `write: begin nstate = (counter == 0) ? `done : `reg_write; write_file = 1'b1; end
      `done: begin nstate = `idle; finish = 1'b1; end
      default: nstate =`idle; // pstate
    endcase
  end

  always @(posedge clk) begin
    pstate <= nstate;
  end

  assign index = counter;
  // 8-BIT counter
  reg [7:0] counter;
  always @(posedge clk) begin
    if (rst) begin
      counter <= 0;
    end
    else if (cnt_inc) begin
      counter <= counter + 1;
    end
  end

endmodule