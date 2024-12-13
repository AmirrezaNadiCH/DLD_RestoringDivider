`timescale 1ns/1ps

module Divider_tb;
	logic st;
	logic[7:0] Qbus_in, Mbus_in;
	logic clk=1'b0,rst=1'b0;
	wire[7:0] Abus_out, Qbus_out;
	wire ready;
	
	Divider UUT(.st(st), .Qbus_in(Qbus_in), .Mbus_in(Mbus_in), .clk(clk), .rst(rst), .Abus_out(Abus_out), .Qbus_out(Qbus_out), .ready(ready));
	
	always begin
		#10 clk = ~clk;
	end
	
	initial begin
		st = 1'b0;
		rst=1'b1;
		Qbus_in = 8'b11011011;
		Mbus_in = 8'b00001100;
		#40 rst = 1'b0;
		st = 1'b1;
		#26 st = 1'b0;
		#300 st=1;
		Qbus_in = 8'b10111100;
		Mbus_in = 8'b00011100;
		#24 st = 1'b0;
		#300 Qbus_in = 8'b11010111;
		Mbus_in = 8'b00010011;
		#36 st = 1'b1;
		#26 st = 1'b0;
		#300 $stop;
	end
endmodule
