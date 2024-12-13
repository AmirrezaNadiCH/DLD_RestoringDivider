`timescale 1ns/1ns

module modu8cnt_tb();

	logic init, cen;
	logic clk=0,rst=0;
	wire[3:0] Q;
	wire co;
	
	modu8cnt UUT(.init(init), .cen(cen), .clk(clk), .rst(rst), .Q(Q), .co(co));
	
	always begin
		#5 clk = ~clk;
	end
	
	initial begin
		rst = 1'b1;
		init = 1'b0;
		cen = 1'b0;
		#20 rst = 0;
		#7 cen = 1;
		#150 init = 1'b1;
		#15 init = 1'b0;
		#150 $stop;
	end
	
endmodule
