`timescale 1ns / 1ps


module ArithmeticLogicUnitSystem(
    input [2:0] RF_OutASel, 
    input [2:0] RF_OutBSel, 
    input [2:0] RF_FunSel, 
    input [3:0] RF_RegSel,
    input [3:0] RF_ScrSel,
    input [4:0] ALU_FunSel,
    input [1:0] ARF_OutCSel,
    input [1:0] ARF_OutDSel,
    input [2:0] ARF_FunSel,
    input [2:0] ARF_RegSel,
    input IR_LH,
    input IR_Write,
    input Mem_WR,
    input Mem_CS,
    input [1:0] MuxASel,
    input [1:0] MuxBSel,
    input MuxCSel,
    input Clock,
    input ALU_WF
    );
    
    reg [7:0] MuxCOut; reg [15:0] MuxBOut; reg [15:0] MuxAOut;
    wire [15:0] OutA; wire [15:0] OutB; 
    wire [15:0] ALUOut; wire [3:0] ALUOutFlag;
    wire [15:0] OutC; wire [15:0] Address;
    wire [15:0] IROut;
    wire [7:0] MemOut;
    
    
    RegisterFile RF (.Clock(Clock), .I(MuxAOut), .OutASel(RF_OutASel), .OutBSel(RF_OutBSel), .FunSel(RF_FunSel), .RegSel(RF_RegSel), .ScrSel(RF_ScrSel), .OutA(OutA), .OutB(OutB));
    AddressRegisterFile ARF (.Clock(Clock), .I(MuxBOut), .OutCSel(ARF_OutCSel), .OutDSel(ARF_OutDSel), .FunSel(ARF_FunSel), .RegSel(ARF_RegSel), .OutC(OutC), .OutD(Address));
    ArithmeticLogicUnit ALU (.Clock(Clock), .A(OutA), .B(OutB), .FunSel(ALU_FunSel), .FlagsOut(ALUOutFlag), .ALUOut(ALUOut), .WF(ALU_WF));
    InstructionRegister IR (.Clock(Clock), .I(MemOut), .LH(IR_LH), .Write(IR_Write), .IROut(IROut));
    Memory MEM (.Address(Address), .Data(MuxCOut), .WR(Mem_WR), .CS(Mem_CS), .Clock(Clock), .MemOut(MemOut));
    
    
    always @(*) begin
            case (MuxASel)
                2'b00: MuxAOut = ALUOut;
                2'b01: MuxAOut = OutC;
                2'b10: begin
                    MuxAOut = 0;
                    MuxAOut[7:0] = MemOut[7:0];
                end
                2'b11: begin
                    MuxAOut <= 0;
                    MuxAOut[7:0] = IROut[7:0];
                end
            endcase
            case (MuxBSel)
                2'b00: MuxBOut = ALUOut;
                2'b01: MuxBOut = OutC;
                2'b10: begin
                    MuxBOut = 0;
                    MuxBOut[7:0] = MemOut[7:0];
                end
                2'b11: begin
                    MuxBOut = 0;
                    MuxBOut[7:0] = IROut[7:0];
                end
            endcase
            case (MuxCSel)
                1'b0: MuxCOut = ALUOut[7:0];
                1'b1: MuxCOut = ALUOut[15:8];
            endcase
        end
    
endmodule
