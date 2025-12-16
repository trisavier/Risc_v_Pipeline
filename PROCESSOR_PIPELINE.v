// ============================================================================
// PROCESSOR_PIPELINE.v - Top Module for 5-Stage Pipelined RISC-V Processor
// ============================================================================
// Stages: IF → ID → EX → MEM → WB
// Features: Forwarding, Hazard Detection, Stall Control
// ============================================================================

module PROCESSOR_PIPELINE( 
    input clock, 
    input reset,
    output zero
);

    //========================================================================
    // IF Stage Signals
    //========================================================================
    wire [31:0] if_pc;
    wire [31:0] if_instruction;
    wire stall_pc;
    
    //========================================================================
    // Pipeline Outputs (for monitoring)
    //========================================================================
    wire [31:0] wb_write_data;
    wire [4:0] wb_rd;
    wire wb_regwrite;
    wire zero_flag;
    
    assign zero = zero_flag;
    
    //========================================================================
    // Instruction Fetch Unit (IF Stage)
    //========================================================================
    IFU_PIPELINE ifu_module(
        .clock(clock),
        .reset(reset),
        .stall(stall_pc),
        .if_pc(if_pc),
        .if_instruction(if_instruction)
    );
    
    //========================================================================
    // Pipelined Datapath (All other stages: ID, EX, MEM, WB)
    //========================================================================
    DATAPATH_PIPELINE datapath_module(
        .clock(clock),
        .reset(reset),
        .if_instruction(if_instruction),
        .if_pc(if_pc),
        .stall_pc(stall_pc),
        .wb_write_data(wb_write_data),
        .wb_rd(wb_rd),
        .wb_regwrite(wb_regwrite),
        .zero_flag(zero_flag)
    );

endmodule


// ============================================================================
// IFU_PIPELINE - Instruction Fetch Unit with Stall Support
// ============================================================================
module IFU_PIPELINE(
    input clock,
    input reset,
    input stall,
    output reg [31:0] if_pc,
    output [31:0] if_instruction
);

    // Instruction Memory
    INST_MEM instr_mem(
        .PC(if_pc),
        .reset(reset),
        .Instruction_Code(if_instruction)
    );
    
    // Program Counter with stall support
    always @(posedge clock or posedge reset)
    begin
        if (reset)
            if_pc <= 32'h00000000;
        else if (stall)
            if_pc <= if_pc;  // Keep PC when stalled
        else
            if_pc <= if_pc + 32'h00000004;  // Increment by 4
    end

endmodule