`timescale 1ns/1ns
module reg25(clk,rst,ld,clr,in, out);

	input clk,rst,ld,clr;
	input [24:0] in;
	output reg [24:0] out;
	
	always @(rst, posedge clk) begin
		if (rst)
			out <= 0;
		else begin 
			if (clr)
				out <= 0;
			else if (ld) begin
				out <= in;	
			end
		end
	end
    
endmodule