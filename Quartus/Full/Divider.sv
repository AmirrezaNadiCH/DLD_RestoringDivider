`timescale 1ns/1ns

module Divider(input st, input[7:0] Qbus_in, Mbus_in, input clk,rst, output[7:0] Abus_out, Qbus_out, output ready);

	wire plA, shA, initA, plQ, shQ, siQ, plM, MSB_ASM;
	Divider_Datapath Datapath(.Qbus_in(Qbus_in), .Mbus_in(Mbus_in), .plA(plA), .shA(shA), .initA(initA), .plQ(plQ), .shQ(shQ), .siQ(siQ), .plM(plM),
							  .clk(clk), .rst(rst), .Abus_out(Abus_out), .Qbus_out(Qbus_out), .MSB_ASM(MSB_ASM));
	Divider_Controller Controller(.st(st), .MSB_ASM(MSB_ASM), .clk(clk), .rst(rst), .ready(ready), .plA(plA), .shA(shA), .initA(initA), .plQ(plQ),
								  .shQ(shQ), .siQ(siQ), .plM(plM));

endmodule