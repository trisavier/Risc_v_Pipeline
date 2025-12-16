// ============================================================================
// FORWARDING_UNIT.v - Data Forwarding Logic for Hazard Resolution
// ============================================================================

module FORWARDING_UNIT(
    input [4:0] id_ex_rs1,
    input [4:0] id_ex_rs2,
    input [4:0] ex_mem_rd,
    input ex_mem_regwrite,
    input [4:0] mem_wb_rd,
    input mem_wb_regwrite,
    output reg [1:0] forward_a,
    output reg [1:0] forward_b
);

    always @(*) begin
        forward_a = 2'b00;
        forward_b = 2'b00;
        
        // EX Hazard - Forward from EX/MEM
        if (ex_mem_regwrite && 
            (ex_mem_rd != 5'b00000) &&
            (ex_mem_rd == id_ex_rs1)) begin
            forward_a = 2'b10;
        end
        
        if (ex_mem_regwrite && 
            (ex_mem_rd != 5'b00000) &&
            (ex_mem_rd == id_ex_rs2)) begin
            forward_b = 2'b10;
        end
        
        // MEM Hazard - Forward from MEM/WB
        if (mem_wb_regwrite &&
            (mem_wb_rd != 5'b00000) &&
            !(ex_mem_regwrite && (ex_mem_rd != 5'b00000) && (ex_mem_rd == id_ex_rs1)) &&
            (mem_wb_rd == id_ex_rs1)) begin
            forward_a = 2'b01;
        end
        
        if (mem_wb_regwrite &&
            (mem_wb_rd != 5'b00000) &&
            !(ex_mem_regwrite && (ex_mem_rd != 5'b00000) && (ex_mem_rd == id_ex_rs2)) &&
            (mem_wb_rd == id_ex_rs2)) begin
            forward_b = 2'b01;
        end
    end

endmodule