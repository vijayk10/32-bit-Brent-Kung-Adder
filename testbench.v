module testbench;
reg [31:0] A,B;
wire [15:0] G2,P2;
wire [7:0] G3, P3;
wire [3:0] G4,P4;
wire [1:0] G5,P5;
wire [31:0] S;
wire Co;

brent_kung_adder dut(A,B, 1'b0, S,Co );
  initial 
    begin
      A = 103;
      B = 166;
		
      #50
		A = 79;
		B = 156;
		
		#50
		A = 222;
		B = 993;
		
		#50
		A = 149;
		B = 502;
		
		#50
		A = 1018;
		B = 788;
		
		#100
		
		
//      $display("%b, %b", A, B);
//      $display("G2,P2 %b, %b", G2, P2);
//      $display("G3,P3 %b, %b", G3, P3);
//      $display("G4,P4 %b, %b", G4, P4);
//      $display("G5,P5 %b, %b", G5, P5);
//      $display("%b, %d", S,S);
      $finish ;
    end
endmodule
