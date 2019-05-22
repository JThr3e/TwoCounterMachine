module top_level(clockButton, reset, debugA, debugB, clk50mhz);
input reset;
input clk50mhz;
input clockButton;
wire CLK;

reg clk1hz;
reg [31:0] count;
always @ (posedge clk50mhz) begin
	if(count == 32'd25_000_000) begin 
		count <= 32'd0;
		clk1hz <= ~clk1hz;
	end else begin
		count <= count + 32'd1;
	end
end

assign CLK = clk1hz;

output [7:0] debugA;
output [7:0] debugB;

reg [7:0] programCounter;

wire [7:0] R1;
wire [7:0] R2;
wire [7:0] result;

wire [7:0] instr;
wire [7:0] imm;
wire aAddr;
wire bAddr;
wire WE;
wire jmpInstr;
wire halt;
wire jmp;
wire [2:0] opcode;

always @ (posedge CLK) begin
	if(~reset) begin
		programCounter <= 8'b0;
	end else begin
		if(~halt)begin
			if(jmp) begin
				programCounter <= programCounter + imm;
			end else begin
				programCounter <= programCounter + 8'd1;
			end
		end else begin
			programCounter <= programCounter;
		end
	end
end

assign jmp = jmpInstr & (result == 8'b0);

iram program (
	.CLK(CLK), 
	.RESET(reset), 
	.ADDR(programCounter), 
	.Q(instr)
);

decode decoder (
	.instr(instr), 
	.aAddr(aAddr),
	.bAddr(bAddr),
	.imm(imm), 
	.WBInstr(WE), 
	.jmpInstr(jmpInstr), 
	.halt(halt), 
	.aluOP(opcode)
);

regfile file (
	.CLK(CLK),
	.reset(reset),
	.WE(WE),
	.WB(result),
	.srcA(aAddr),
	.srcB(bAddr),
	.dest(aAddr),
	.R1(R1),
	.R2(R2),
	.debugA(debugA),
	.debugB(debugB)
);

alu testALU (
	.aReg(R1),
	.bReg(R2),
	.opcode(opcode),
	.result(result)
);

endmodule
