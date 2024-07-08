`timescale 1ns / 1ps


module Register(
    input wire E,                       //Enable input
    input wire [2:0] FunSel,            //3-bit Function Selection input 
    input wire [15:0] I,                //16-bit input of register
    input wire Clock,                   //Clock
    output reg [15:0] Q                 //16-bit Output
    );
    
    always @(posedge Clock) begin
        if (E) begin                                                // If E is high, then this block will be executed.
            case (FunSel)
                3'b000: Q <= Q - 1'b1;                              // Decrement
                3'b001: Q <= Q + 1'b1;                              // Increment
                3'b010: Q <= I;                                     // Load
                3'b011: Q <= 16'h0000;                              // Clear
                3'b100: begin                                       // Clear and write low
                    Q[15:8] <= 8'h00;
                    Q[7:0] <= I[7:0];
                end
                3'b101: Q[7:0] <= I[7:0];                           // Only write low
                3'b110: Q[15:8] <= I[7:0];                          // Only write high
                3'b111: begin                                       // Sign extend and write low
                    Q[15:8] <= {I[7], {6{I[7]}}};
                    Q[7:0] <= I[7:0];
                end
                default: ;                                          // Retain value (default)
            endcase
        end
    end
    
endmodule
