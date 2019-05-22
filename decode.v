module decode (instr, aAddr, bAddr, imm, WBInstr, jmpInstr, halt, aluOP);
input [7:0] instr;
output reg aAddr;
output reg bAddr;
output reg WBInstr;
output reg jmpInstr;
output reg halt;
output reg [2:0] aluOP;
output reg [7:0] imm;

always @ (*) begin
	case(instr[7:5])
		//NOP
		3'b000: begin aAddr = 1'bx; bAddr = 1'bx; WBInstr = 1'b0; jmpInstr = 1'b0; 
					halt = 1'b0; aluOP = 3'bxxx; imm = 8'bxxxxxxxx; end
		//CLR r
		3'b001: begin aAddr = instr[4]; bAddr = 1'bx; WBInstr = 1'b1; jmpInstr = 1'b0; 
				  halt = 1'b0; aluOP = 3'b000; imm = 8'bxxxxxxxx; end
		//INC r
		3'b010: begin aAddr = instr[4]; bAddr = 1'bx; WBInstr = 1'b1; jmpInstr = 1'b0; 
				  halt = 1'b0; aluOP = 3'b001; imm = 8'bxxxxxxxx; end
		//DEC r
		3'b011: begin aAddr = instr[4]; bAddr = 1'bx; WBInstr = 1'b1; jmpInstr = 1'b0; 
				  halt = 1'b0; aluOP = 3'b010; imm = 8'bxxxxxxxx; end
		//CPY r1 r2
		3'b100: begin aAddr = instr[4]; bAddr = instr[5]; WBInstr = 1'b1; jmpInstr = 1'b0; 
				  halt = 1'b0; aluOP = 3'b100; imm = 8'bxxxxxxxx; end
		//JMPZ r imm
		3'b101: begin aAddr = instr[4]; bAddr = 1'bx; WBInstr = 1'b0; jmpInstr = 1'b1; 
				  halt = 1'b0; aluOP = 3'b011; 
				  imm = {instr[3],instr[3],instr[3],instr[3],instr[3:0]}; end
		//JMPE r1 r2 imm
		3'b110: begin aAddr = instr[4]; bAddr = instr[5]; WBInstr = 1'b0; jmpInstr = 1'b1; 
				  halt = 1'b0; aluOP = 3'b101; 
				  imm = {instr[2],instr[2],instr[2],instr[2],instr[2],instr[2:0]}; end
		//HALT
		3'b111: begin aAddr = 1'bx; bAddr = 1'bx; WBInstr = 1'b0; jmpInstr = 1'b0; 
				  halt = 1'b1; aluOP = 3'bxxx; imm = 8'bxxxxxxxx; end
	endcase

end
endmodule
