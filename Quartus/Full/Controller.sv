`timescale 1ns/1ns

module modu8cnt(input init, cen, input clk,rst, output logic[2:0] Q, output co);
	always@(posedge clk, posedge rst) begin
		if(rst)
			Q <= 3'b000;
		else begin
			if(init)
				Q <= 8'b000;
			else if(cen)
				Q <= Q+1'b1;
		end
	end
	assign co = &{Q};
endmodule

module Divider_Controller(input st, input MSB_ASM, input clk,rst, output logic ready, output logic shQ, plQ, plM, initA, shA, plA, siQ);

	wire co;
	wire[2:0] cnt_out;
	logic initC, cen;
	modu8cnt counter(.init(initC), .cen(cen), .clk(clk), .rst(rst), .Q(cnt_out), .co(co));
	
	parameter Idle = 4'b1000;
	parameter Start = 4'b0100;
	parameter Load = 4'b0010;
	parameter SSR = 4'b0001;
	
	logic[3:0] state;
	logic[3:0] next_state;
	
	always@(posedge clk, posedge rst) begin
		if(rst) state <= Idle;
		else state <= next_state;
	end
	
	always@(state, co, st, MSB_ASM) begin
		shQ = 1'b0; 
		plQ = 1'b0;
		plM = 1'b0;
		initA = 1'b0;
		shA = 1'b0;
		plA = 1'b0;
		siQ = 1'b0;
		initC = 1'b0;
		cen = 1'b0;
		ready = 1'b0;
		next_state = Idle;
		case(state)
			Idle: begin
					ready = 1'b1;
					if(st) next_state = Start;
					else next_state = Idle;
				end
			Start: begin
					if(st) next_state = Start;
					else next_state = Load;
				end
			Load: begin
					plQ = 1'b1;
					plM = 1'b1;
					initA = 1'b1;
					initC = 1'b1;
					next_state = SSR;
				end
			SSR: begin
					shQ = 1'b1;
					cen = 1'b1;
					if(MSB_ASM)	shA = 1'b1;
					else begin
						plA = 1'b1;
						siQ = 1'b1;
					end
					if(co) next_state = Idle;
					else next_state = SSR;
				end
			default:
				next_state = Idle;
		endcase
	end
endmodule