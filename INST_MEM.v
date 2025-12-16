// ============================================================================
// INST_MEM.v - Instruction Memory (ROM)
// ============================================================================

module INST_MEM(
    input [31:0] PC,
    input reset,
    output reg [31:0] Instruction_Code
);

    always @(*) begin
        if (reset) begin
            Instruction_Code = 32'h00000000;
        end
        else begin
            case(PC)
                32'h00000000: Instruction_Code = 32'h00940333;  // add t1, s0, s1
                32'h00000004: Instruction_Code = 32'h413903b3;  // sub t2, s2, s3
                32'h00000008: Instruction_Code = 32'h035a02b3;  // mul t0, s4, s5
                32'h0000000C: Instruction_Code = 32'h017b4e33;  // xor t3, s6, s7
                32'h00000010: Instruction_Code = 32'h019c1eb3;  // sll t4, s8, s9
                32'h00000014: Instruction_Code = 32'h01bd5f33;  // srl t5, s10, s11
                32'h00000018: Instruction_Code = 32'h00d67fb3;  // and t6, a2, a3
                32'h0000001C: Instruction_Code = 32'h00f768b3;  // or a7, a4, a5
                default:      Instruction_Code = 32'h00000013;  // NOP
            endcase
        end
    end

endmodule