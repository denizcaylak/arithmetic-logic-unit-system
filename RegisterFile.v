`timescale 1ns / 1ps


module RegisterFile(
    input wire Clock,              // Clock
    input wire [15:0] I,           // 16-bit input
    input wire [2:0] OutASel,      // Output A select
    input wire [2:0] OutBSel,      // Output B select
    input wire [2:0] FunSel,       // Function select
    input wire [3:0] RegSel,       // Register select
    input wire [3:0] ScrSel,       // Scratch register select
    output reg [15:0] OutA,        // Output A
    output reg [15:0] OutB         // Output B
    );
 
    wire [15:0] QR1, QR2, QR3, QR4;        // General purpose registers
    wire [15:0] QS1, QS2, QS3, QS4;        // Scratch registers

    wire ER1, ER2, ER3, ER4, ES1, ES2, ES3, ES4;

    assign {ER1, ER2, ER3, ER4} = ~RegSel; //Assigning to complement of RegSel because for RegSel input, is bit is 0, that means that enable wire will activated.
    assign {ES1, ES2, ES3, ES4} = ~ScrSel; //Assigning to complement of ScrSel because for ScrSel input, is bit is 0, that means that enable wire will activated.

    //INITIALIZING AND WIRING THE REGISTERS WITH THEIR INPUTS AND OUTPUTS.
    
    Register R1 (
        .Clock(Clock),
        .E(ER1),
        .FunSel(FunSel),
        .I(I),
        .Q(QR1)
    );
    
    Register R2 (
        .Clock(Clock),
        .E(ER2),
        .FunSel(FunSel),
        .I(I),
        .Q(QR2)
    );
    
    Register R3 (
        .Clock(Clock),
        .E(ER3),
        .FunSel(FunSel),
        .I(I),
        .Q(QR3)
    );
    
    Register R4 (
        .Clock(Clock),
        .E(ER4),
        .FunSel(FunSel),
        .I(I),
        .Q(QR4)
    );
    
    Register S1 (
        .Clock(Clock),
        .E(ES1),
        .FunSel(FunSel),
        .I(I),
        .Q(QS1)
    );
    
    Register S2 (
        .Clock(Clock),
        .E(ES2),
        .FunSel(FunSel),
        .I(I),
        .Q(QS2)
    );
    
    Register S3 (
        .Clock(Clock),
        .E(ES3),
        .FunSel(FunSel),
        .I(I),
        .Q(QS3)
    );
    
    Register S4 (
        .Clock(Clock),
        .E(ES4),
        .FunSel(FunSel),
        .I(I),
        .Q(QS4)
    );

    
    always @(*) begin    
        case (OutASel)                          //Deciding the OutA by checking the OutASel input and assigning the correct register.
            3'b000: OutA <= QR1;
            3'b001: OutA <= QR2;
            3'b010: OutA <= QR3;
            3'b011: OutA <= QR4;
            3'b100: OutA <= QS1;
            3'b101: OutA <= QS2;
            3'b110: OutA <= QS3;
            3'b111: OutA <= QS4;
        endcase
            
        case (OutBSel)                          //Deciding the OutB by checking the OutBSel input and assigning the correct register.
            3'b000: OutB <= QR1;
            3'b001: OutB <= QR2;
            3'b010: OutB <= QR3;
            3'b011: OutB <= QR4;
            3'b100: OutB <= QS1;
            3'b101: OutB <= QS2;
            3'b110: OutB <= QS3;
            3'b111: OutB <= QS4;
        endcase
    end
endmodule
