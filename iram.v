module iram(CLK, RESET, ADDR, Q);
  input         CLK;
  input         RESET;
  input  [7:0]  ADDR;
  output [7:0] Q;

  reg    [7:0] mem[0:127]; // instruction memory with 8 bit entries

  wire   [6:0]  saddr;
  integer       i;
  
  assign Q = mem[ADDR];

  always @(posedge CLK) begin
    if(RESET) begin
		//This program loads 5 into A, loads 2 into B,
		//subtracts 2 from 5, copies the result into B,
		//clears B, then halts. This leaves A with 3 inside.
      mem[0]  <= 8'b0100_0000; //INC A
      mem[1]  <= 8'b0100_0000; //INC A
      mem[2]  <= 8'b0100_0000; //INC A
      mem[3]  <= 8'b0100_0000; //INC A
      mem[4]  <= 8'b0100_0000; //INC A
      mem[5]  <= 8'b0101_0000; //INC B
      mem[6]  <= 8'b0101_0000; //INC B
      mem[7]  <= 8'b1011_0100; //JMPZ B 4
      mem[8]  <= 8'b0111_0000; //DEC B
      mem[9]  <= 8'b0110_0000; //DEC A
		mem[10] <= 8'b1100_0101; //JMPE A A -3
		mem[11] <= 8'b1001_0000; //CPY B A
		mem[12] <= 8'b0011_0000; //CLR B
		mem[13] <= 8'b1110_0000; //HALT
    
      for(i = 14; i < 128; i = i + 1) begin
        mem[i] <= 8'b0000_0000;
      end
    end
  end

endmodule