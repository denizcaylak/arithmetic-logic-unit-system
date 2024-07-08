`timescale 1ns / 1ps


module AddressRegisterFile(
    input wire Clock,              // Clock
    input wire [15:0] I,           // 16-bit input
    input wire [1:0] OutCSel,      // 2-bit OutputC Selector
    input wire [1:0] OutDSel,      // 2-bit OutputD Selector
    input wire [2:0] FunSel,       // Function select
    input wire [2:0] RegSel,       // Register select
    output reg [15:0] OutC,        // Output C
    output reg [15:0] OutD         // Output D
    );
    
    wire EPC, EAR, ESP;             //Initializing enable wires for PC, AR and SP registers.
    wire [15:0] R1, R2, R3;         //Initializing 16-bit output wires.
    

    assign {EPC, EAR, ESP} = ~RegSel;   //Complementing of the RegSel because 0's in RegSel mean thar corresponding register will work. So I complemented it bit by bit.

    Register PC (                       //Wiring PC register.
        .Clock(Clock),
        .E(EPC),
        .FunSel(FunSel),
        .I(I),
        .Q(R1)
    );
        
    Register AR (                       //Wiring AR register.
        .Clock(Clock),
        .E(EAR),
        .FunSel(FunSel),
        .I(I),
        .Q(R2)
    );
        
    Register SP (                       //Wiring SP register.
        .Clock(Clock),
        .E(ESP),
        .FunSel(FunSel),
        .I(I),
        .Q(R3)
    );
    always @(*) begin
        
        case(OutCSel)                   //Deciding the OutputC by checking the OutCSel.
            2'b00: OutC <= R1;
            2'b01: OutC <= R1;
            2'b10: OutC <= R2;
            2'b11: OutC <= R3;
        endcase
        
        case(OutDSel)                   //Deciding the OutputD by checking the OutDSel.
            2'b00: OutD <= R1;
            2'b01: OutD <= R1;
            2'b10: OutD <= R2;
            2'b11: OutD <= R3;
       endcase
    end
endmodule
