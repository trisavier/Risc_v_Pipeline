// ============================================================================
// EX_MEM_REG.v - Pipeline Register between EX and MEM stages
// ============================================================================

module EX_MEM_REG(
    input clock,
    input reset,
    input ex_regwrite,
    input [31:0] ex_alu_result,
    input [31:0] ex_write_data,
    input [4:0] ex_rd,
    input ex_zero,
    output reg mem_regwrite,
    output reg [31:0] mem_alu_result,
    output reg [31:0] mem_write_data,
    output reg [4:0] mem_rd,
    output reg mem_zero
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            mem_regwrite <= 1'b0;
            mem_alu_result <= 32'h00000000;
            mem_write_data <= 32'h00000000;
            mem_rd <= 5'b00000;
            mem_zero <= 1'b0;
        end
        else begin
            mem_regwrite <= ex_regwrite;
            mem_alu_result <= ex_alu_result;
            mem_write_data <= ex_write_data;
            mem_rd <= ex_rd;
            mem_zero <= ex_zero;
        end
    end

endmodule