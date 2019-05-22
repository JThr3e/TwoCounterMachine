module regfile(CLK, reset, WE, WB, srcA, srcB, dest, R1, R2, debugA, debugB);
input CLK;
input reset;
input WE;	//Write enable
input srcA; //src A address
input srcB; //src B address
input dest; //destination address
input [7:0] WB; //Write back input
output [7:0] R1; //r1 ouput
output [7:0] R2; //r2 ouput

output [7:0] debugA;
output [7:0] debugB;

reg [7:0] aReg;
reg [7:0] bReg;

always @ (posedge CLK) begin
	if(~reset) begin
		aReg <= 8'b0;
		bReg <= 8'b0;
	end else begin
		if(WE) begin
			if(dest == 1'b0) begin
				aReg <= WB;
			end else begin
				bReg <= WB;
			end
		end
	end
end

//0 -> A, 1 -> B
assign R1 = srcA ? bReg : aReg;
assign R2 = srcB ? bReg : aReg;

assign debugA = aReg;
assign debugB = bReg;

endmodule

