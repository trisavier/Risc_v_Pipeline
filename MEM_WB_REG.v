// ============================================================================
// MEM_WB_REG.v - Pipeline Register between MEM and WB stages
// ============================================================================

module MEM_WB_REG(
    input clock,
    input reset,
    input mem_regwrite,
    input [31:0] mem_read_data,
    input [31:0] mem_alu_result,
    input [4:0] mem_rd,
    output reg wb_regwrite,
    output reg [31:0] wb_read_data,
    output reg [31:0] wb_alu_result,
    output reg [4:0] wb_rd
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            wb_regwrite <= 1'b0;
            wb_read_data <= 32'h00000000;
            wb_alu_result <= 32'h00000000;
            wb_rd <= 5'b00000;
        end
        else begin
            wb_regwrite <= mem_regwrite;
            wb_read_data <= mem_read_data;
            wb_alu_result <= mem_alu_result;
            wb_rd <= mem_rd;
        end
    end

endmodule