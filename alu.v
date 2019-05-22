module alu(aReg, bReg, opcode, result);
	input [7:0] aReg;
	input [7:0] bReg;
	input [2:0] opcode;
	output [7:0] result;
	reg [7:0] res;
	always @ (*) begin
		case(opcode)
			3'b000: res = 8'b0;
			3'b001: res = aReg + 8'd1;
			3'b010: res = aReg - 8'd1;
			3'b011: res = aReg;
			3'b100: res = bReg;
			3'b101: res = aReg - bReg;
			default: res = 8'b0;
		endcase
	end
	assign result = res;
endmodule
