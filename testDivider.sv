`timescale 1ns/1ns

module Divider_tb;
	logic st;
	logic[7:0] Qbus_in, Mbus_in;
	logic clk=1'b0,rst=1'b0;
	wire[7:0] Abus_out, Qbus_out;
	wire ready;
	
	Divider UUT(.st(st), .Qbus_in(Qbus_in), .Mbus_in(Mbus_in), .clk(clk), .rst(rst), .Abus_out(Abus_out), .Qbus_out(Qbus_out), .ready(ready));
	
	always begin
		#5 clk = ~clk;
	end
	
	initial begin
		st = 1'b0;
		rst=1'b1;
		Qbus_in = 8'b11011011;
		Mbus_in = 8'b00001100;
		#20 rst = 1'b0;
		st = 1'b1;
		#13 st = 1'b0;
		#150 st=1;
		Qbus_in = 8'b10111100;
		Mbus_in = 8'b00011100;
		#12 st = 1'b0;
		#150 $stop;
		
		
		
	end
	

endmodule
