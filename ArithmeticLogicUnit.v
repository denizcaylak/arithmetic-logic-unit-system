`timescale 1ns / 1ps



module ArithmeticLogicUnit(
    input Clock,
    input [15:0] A,
    input [15:0] B,
    input [4:0] FunSel,
    input WF,
    output reg [3:0] FlagsOut = 4'b0,
    output [15:0] ALUOut
);


reg [15:0] result;
reg [16:0] rescarry;

reg Z=0,C,N,O;

assign ALUOut = result;

 always @(*) begin 
 	
 	
 	
    case (FunSel)
        
        5'b00000: begin                    //8 BIT
            result[7:0] = A[7:0];
        end
        5'b00001: begin
            result[7:0] = B[7:0];
        end
        5'b00010: begin
            result[7:0] = ~A[7:0];
        end
        5'b00011: begin
            result[7:0] = ~B[7:0];
        end
        5'b00100: begin  
            result[7:0] = A[7:0] + B[7:0];
            if ((A[7] == B[7]) & (B[7] != ALUOut[7])) begin
            O = 1;
            end else O = 0;
            rescarry[8:0]=  A[7:0] + B[7:0];
            C=rescarry[8]; 
        end
        5'b00101: begin
            result[7:0] = A[7:0] + B[7:0] + FlagsOut[2];
            if ((A[7] == B[7]) & (B[7] != ALUOut[7])) begin
            O = 1;
            end else O = 0;

            rescarry[8:0]=  A[7:0] + B[7:0] + FlagsOut[2];
            C=rescarry[8];
        end
        5'b00110: begin
            result[7:0] = A[7:0] - B[7:0];
            if ((A[7] == B[7]) & (B[7] != ALUOut[7])) begin
            O = 1;
            end else O = 0;
        end
        5'b00111: begin
            result[7:0] = A[7:0] & B[7:0];            
        end
        5'b01000: begin
            result[7:0] = A[7:0] | B[7:0];
        end
        5'b01001: begin
            result[7:0] = A[7:0] ^ B[7:0];
        end
        5'b01010: begin
            result[7:0] =  ~(A[7:0] & B[7:0]);
        end
        5'b01011: begin  //LSL A
            C = A[7];
            result[7:0] = A[7:0] << 1;
        end
        5'b01100: begin  //LSR A
            C = A[0];
            result[7:0] = A[7:0] >> 1;
        end
        5'b01101: begin //ASR A
            if (A[7] == 1) begin
            	result[7] = 1'b1; 
        		result[6] = A[7]; 
        		result[5] = A[6]; 
        		result[4] = A[5]; 
        		result[3] = A[4]; 
        		result[2] = A[3]; 
        		result[1] = A[2]; 
        		result[0] = A[1]; 
    	    end
    	    
    	    else begin       
        		result = A[7:0] >> 1;
    		end
        end
        5'b01110: begin //CSL A
        	C = A[7];
            result[0] = C;
            result[1] = A[0];
            result[2] = A[1];
            result[3] = A[2];
            result[4] = A[3];
            result[5] = A[4];
            result[6] = A[5];
            result[7] = A[6];
            
			
        end
         5'b01111: begin //CSR A
            C= A[0];
            result[0] = A[1];
            result[1] = A[2];
            result[2] = A[3];
            result[3] = A[4];
            result[4] = A[5];
            result[5] = A[6];
            result[6] = A[7];
            result[7] = C;
            
        end                              //16 BIT
        5'b10000: begin
            result = A;
        end
        5'b10001: begin
            result = B;
        end
        5'b10010: begin
            result = ~A;
        end
        5'b10011: begin
            result = ~B;
        end
        5'b10100: begin  
            result = A + B;
            if ((A[15] == B[15]) & (B[15] != ALUOut[15])) begin
            O = 1;
            end else O = 0;  
            rescarry =A + B;
            C=rescarry[16];    
        end
        5'b10101: begin
            result = A + B + FlagsOut[2];
            if ((A[15] == B[15]) & (B[15] != ALUOut[15])) begin
            O = 1;
            end else O = 0;
            rescarry = A + B + FlagsOut[2];
            C =rescarry[16];
        end
        5'b10110: begin
            result = A - B;
            if ((A[15] == B[15]) & (B[15] != ALUOut[15])) begin
            O = 1;
            end else O = 0;
        end
        5'b10111: begin
            result = A & B;            
        end
        5'b11000: begin
            result = A | B;
        end
        5'b11001: begin
            result = A ^ B;
        end
        5'b11010: begin
            result =  ~(A & B);
        end
        5'b11011: begin  //LSL A
            C = A[15];
            result = A << 1;
        end
        5'b11100: begin  //LSR A
            C = A[0];
            result = A >> 1;
        end
        5'b11101: begin //ASR A
            if (A[15] == 1) begin
            	result[15] = 1'b1; 
        		result[14] = A[15]; 
        		result[13] = A[14]; 
        		result[12] = A[13]; 
        		result[11] = A[12]; 
        		result[10] = A[11]; 
        		result[9] = A[10]; 
        		result[8] = A[9];
            	result[7] = A[8]; 
        		result[6] = A[7]; 
        		result[5] = A[6]; 
        		result[4] = A[5]; 
        		result[3] = A[4]; 
        		result[2] = A[3]; 
        		result[1] = A[2]; 
        		result[0] = A[1]; 
    	    end
    	    
    	    else begin       
        		result = A >> 1;
    		end
        end
        5'b11110: begin //CSL A
        	C = A[15];
            result[0] = C;
            result[1] = A[0];
            result[2] = A[1];
            result[3] = A[2];
            result[4] = A[3];
            result[5] = A[4];
            result[6] = A[5];
            result[7] = A[6];
            result[8] = A[7];
            result[9] = A[8];
            result[10] = A[9];
            result[11] = A[10];
            result[12] = A[11];
            result[13] = A[12];
            result[14] = A[13];
            result[15] = A[14];
            
			
        end
         5'b11111: begin //CSR A
            C= A[0];
            result[0] = A[1];
            result[1] = A[2];
            result[2] = A[3];
            result[3] = A[4];
            result[4] = A[5];
            result[5] = A[6];
            result[6] = A[7];
            result[7] = A[8];
            result[8] = A[9];
            result[9] = A[10];
            result[10] = A[11];
            result[11] = A[12];
            result[12] = A[13];
            result[13] = A[14];
            result[14] = A[15];
            result[15] = C;
            
        end   
    endcase
    if (FunSel[4]==0) begin
             result[15:8] = 0;         
         end
    if(result == 0) begin       // 	ZERO FLAG
                Z = 1;
        end
    if(((result[7] == 1) && (FunSel[4]==0)) || ((result[15] == 1) && (FunSel[4]==1)))  begin        // NEGATIVE FLAG
                N = 1;
        end
                
        else begin
                N = 0;
        end
end
always @(posedge Clock) begin
    if (WF) begin
                FlagsOut <={Z,C,N,O};
    end
end
endmodule