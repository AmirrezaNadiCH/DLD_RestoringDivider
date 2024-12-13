`timescale 1ns/1ns

module register #(parameter SIZE = 8)(input[SIZE-1:0] PI, input si, input shE, plE, init, input clk,rst, output logic[SIZE-1:0] Q, output so);

	always@(posedge clk, posedge rst) begin
		if(rst)	Q <= {(SIZE-1){1'b0}};
		else begin
			if(init) Q <= {(SIZE-1){1'b0}};
			else begin
				if(plE)	Q <= PI;
				else if(shE)	Q <= {Q[SIZE-2:0],si};
			end
		end
	end
	assign so = Q[SIZE-1];

endmodule

module shifter #(parameter SIZE = 8)(input[SIZE-1:0] A, input B, output[SIZE-1:0] Q);
	assign Q = {A[SIZE-2:0],B};
endmodule

module subtractor #(parameter SIZE = 8)(input[SIZE-1:0] A,B, output[SIZE-1:0] Q);
	assign Q = A - B;
endmodule


module Divider_Datapath(input[7:0] Qbus_in,Mbus_in, input plA, shA, initA, plQ, shQ, siQ, plM, input clk, rst,
						output[7:0] Abus_out, Qbus_out, output MSB_ASM);

	supply0 GND;
	wire soQ;
	register Q(.PI(Qbus_in), .si(siQ), .shE(shQ), .plE(plQ), .init(GND), .clk(clk), .rst(rst), .Q(Qbus_out), .so(soQ));
	
	wire[7:0] A_out;
	wire[7:0] ASM;
	wire soA;
	register A(.PI(ASM), .si(soQ), .shE(shA), .plE(plA), .init(initA), .clk(clk), .rst(rst), .Q(A_out), .so(soA));
	
	wire[7:0] M_out;
	wire soM;
	register M(.PI(Mbus_in), .si(GND), .shE(GND), .plE(plM), .init(GND), .clk(clk), .rst(rst), .Q(M_out), .so(soM));
	
	wire[7:0] shift_out;
	shifter shift(.A(A_out), .B(soQ), .Q(shift_out));
	
	subtractor sub(.A(shift_out), .B(M_out), .Q(ASM));
	
	assign MSB_ASM = ASM[7];
	assign Abus_out = A_out;

endmodule