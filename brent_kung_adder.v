module brent_kung_adder(
    input [31:0] A, B,
    input Ci,
    output [31:0] S,
    output Co
//    output [15:0] G2,P2,
//    output [7:0] G3, P3,
//    output [3:0] G4,P4,
//    output [1:0] G5,P5
);
    wire [31:0] P1, G1;
    wire [32:1] C;
	 wire [15:0] G2,P2;
	 wire [7:0] G3, P3;
	 wire [3:0] G4,P4;
	 wire [1:0] G5,P5;
	 wire G6, P6;
    
    /////// Generating 1st order P's and G's signals ////////
    assign P1 = A ^ B;
    assign G1 = A & B;
    
    //////// Generating 2nd order P's and G's signals ///////
    genvar i;
    generate
        for(i=0; i<=30; i=i+2) begin: second_stage  //32
            assign G2[i/2] = G1[i+1] | (P1[i+1] & G1[i]);
            assign P2[i/2] = P1[i+1] & P1[i];
        end
    endgenerate
    
    /////// Generating 3rd order P's and G's signals //////
    generate
        for(i=0; i<=14; i=i+2) begin: third_stage   //16
            assign G3[i/2] = G2[i+1] | (P2[i+1] & G2[i]);
            assign P3[i/2] = P2[i+1] & P2[i];
        end
    endgenerate
    
    ///////  Generating 4th order P's and G's signals /////
    generate
        for(i=0; i<=6; i=i+2) begin: fourth_stage  //8
            assign G4[i/2] = G3[i+1] | (P3[i+1] & G3[i]);
            assign P4[i/2] = P3[i+1] & P3[i];
        end
    endgenerate
    
    ///////  Generating 5th order P's and G's signals
    generate
        for(i=0; i<=2; i=i+2) begin: fifth_stage  //4
            assign G5[i/2] = G4[i+1] | (P4[i+1] & G4[i]);
            assign P5[i/2] = P4[i+1] & P4[i];
        end
    endgenerate
    
    //////// Generating 6th order P's and G's signals
    assign G6 = G5[1] | (P5[1] & G5[0]);
    assign P6 = P5[1] & P5[0];
    
    //////// Generating carry which can be calculated directly from input carry /////
    assign C[1] = G1[0] | (P1[0] & Ci);
    assign C[2] = G2[0] | (P2[0] & Ci);
    assign C[4] = G3[0] | (P3[0] & Ci);
    assign C[8] = G4[0] | (P4[0] & Ci);
    assign C[16] = G5[0] | (P5[0] & Ci);
    assign C[32] = G6 | (P6 & Ci);
    
	 /////// Now generating all carry signals at remaining stages ////////////
    assign C[3] = G1[2] | (P1[2] & C[2]);
    
    assign C[5] = G1[4] | (P1[4] & C[4]);
    assign C[6] = G2[2] | (P2[2] & C[4]);
    assign C[7] = G1[6] | (P1[6] & C[6]);
    
    assign C[9] = G1[8] | (P1[8] & C[8]);
    assign C[10] = G2[4] | (P2[4] & C[8]);
    assign C[11] = G1[10] | (P1[10] & C[10]);
    assign C[12] = G3[2] | (P3[2] & C[8]);
    assign C[13] = G1[12] | (P1[12] & C[12]);
    assign C[14] = G2[6] | (P2[6] & C[12]);
    assign C[15] = G1[14] | (P1[14] & C[14]);
    
    assign C[17] = G1[16] | (P1[16] & C[16]);
    assign C[18] = G2[8] | (P2[8] & C[16]);     //2nd order => /2
    assign C[19] = G1[18] | (P1[18] & C[18]);
    assign C[20] = G3[4] | (P3[4] & C[16]); //3rd order = /4
    assign C[21] = G1[20] | (P1[20] & C[20]);
    assign C[22] = G2[10] | (P2[10] & C[20]);
    assign C[23] = G1[22] | (P1[22] & C[22]);
    assign C[24] = G4[2] | (P4[2] & C[16]); //4th order => /8
    assign C[25] = G1[24] | (P1[24] & C[24]);
    assign C[26] = G2[12] | (P2[12] & C[24]);
    assign C[27] = G1[26] | (P1[26] & C[26]);
    assign C[28] = G3[6] | (P3[6] & C[24]);
    assign C[29] = G1[28] | (P1[28] & C[28]);
    assign C[30] = G2[14] | (P2[14] & C[28]);
    assign C[31] = G1[30] | (P1[30] & C[30]);
    
    ///////////////////////
    assign S = P1 ^ {C[31:1],Ci};
    assign Co = C[32];
    
endmodule