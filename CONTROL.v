// ============================================================================
// CONTROL.v - Control Unit for RISC-V R-type Instructions
// ============================================================================

module CONTROL(
    input [6:0] funct7,
    input [2:0] funct3,
    input [6:0] opcode,
    output reg [3:0] alu_control,
    output reg regwrite_control
);

    always @(*) begin
        // Default values
        regwrite_control = 1'b0;
        alu_control = 4'b0000;
        
        // R-type instructions (opcode = 0110011)
        if (opcode == 7'b0110011) begin
            regwrite_control = 1'b1;
            
            case({funct7, funct3})
                10'b0000000_000: alu_control = 4'b0010; // ADD
                10'b0100000_000: alu_control = 4'b0100; // SUB
                10'b0000000_111: alu_control = 4'b0000; // AND
                10'b0000000_110: alu_control = 4'b0001; // OR
                10'b0000000_100: alu_control = 4'b0111; // XOR
                10'b0000000_001: alu_control = 4'b0011; // SLL
                10'b0000000_101: alu_control = 4'b0101; // SRL
                10'b0000001_000: alu_control = 4'b0110; // MUL
                10'b0000000_010: alu_control = 4'b1000; // SLT
                default: alu_control = 4'b0000;
            endcase
        end
    end

endmodule