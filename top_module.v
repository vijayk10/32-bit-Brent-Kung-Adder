module top_module (
	input clk, ci,
	input [31:0] A, B,
	output reg [31:0] sum,
	output reg co
);

reg [31:0] At, Bt;
reg Cit;
wire [31:0] St;
wire Cot;

brent_kung_adder dut (At, Bt, Cit, St, Cot);

always @(posedge clk) begin
	At <= A;
	Bt <= B;
	Cit <= ci;
	
	sum <= St;
	co <= Cot;
end

endmodule 