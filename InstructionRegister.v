`timescale 1ns / 1ps



module InstructionRegister(
    input wire Clock,          // Clock input
    input wire [7:0] I,        // 8-bit input bus
    input wire LH,             // Selects whether to load lower or higher half
    input wire Write,          // Write enable signal
    output reg [15:0] IROut    // 16-bit Instruction Register Output
);

always @(posedge Clock) begin
    if (Write) begin                                    //If write is 1, then that block will execute.
        case (LH)                                       //Decide the IROut by checking the LH input. If 0, than LSB and if 1, MSB.
            1'b0: IROut[7:0] <= I;
            1'b1: IROut[15:8] <= I;
            default: ;
        endcase

    end
end

endmodule

