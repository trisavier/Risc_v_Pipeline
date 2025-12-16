// ============================================================================
// IF_ID_REG.v - Pipeline Register between IF and ID stages
// ============================================================================

module IF_ID_REG(
    input clock,
    input reset,
    input stall,
    input flush,
    input [31:0] if_pc,
    input [31:0] if_instruction,
    output reg [31:0] id_pc,
    output reg [31:0] id_instruction
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            id_pc <= 32'h00000000;
            id_instruction <= 32'h00000013;  // NOP
        end
        else if (flush) begin
            id_pc <= 32'h00000000;
            id_instruction <= 32'h00000013;  // NOP
        end
        else if (stall) begin
            id_pc <= id_pc;
            id_instruction <= id_instruction;
        end
        else begin
            id_pc <= if_pc;
            id_instruction <= if_instruction;
        end
    end

endmodule