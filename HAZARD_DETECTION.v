// ============================================================================
// HAZARD_DETECTION.v - Detects Load-Use Hazards
// ============================================================================

module HAZARD_DETECTION(
    input [4:0] id_ex_rd,
    input id_ex_mem_read,
    input [4:0] if_id_rs1,
    input [4:0] if_id_rs2,
    output reg stall_pc,
    output reg stall_if_id,
    output reg flush_id_ex
);

    always @(*) begin
        stall_pc = 1'b0;
        stall_if_id = 1'b0;
        flush_id_ex = 1'b0;
        
        // Load-Use Hazard Detection
        if (id_ex_mem_read && 
            ((id_ex_rd == if_id_rs1) || (id_ex_rd == if_id_rs2)) &&
            (id_ex_rd != 5'b00000)) begin
            stall_pc = 1'b1;
            stall_if_id = 1'b1;
            flush_id_ex = 1'b1;
        end
    end

endmodule