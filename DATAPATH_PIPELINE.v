// ============================================================================
// DATAPATH_PIPELINE.v - 5-Stage Pipelined Datapath
// ============================================================================
// Contains: IF/ID, ID/EX, EX/MEM, MEM/WB registers
//           Forwarding Unit, Hazard Detection Unit
// ============================================================================

module DATAPATH_PIPELINE(
    input clock,
    input reset,
    input [31:0] if_instruction,
    input [31:0] if_pc,
    output stall_pc,
    output [31:0] wb_write_data,
    output [4:0] wb_rd,
    output wb_regwrite,
    output zero_flag
);

    //========================================================================
    // IF/ID Pipeline Register Signals
    //========================================================================
    wire [31:0] id_instruction;
    wire [31:0] id_pc;
    wire stall_if_id;
    wire flush_if_id;
    
    //========================================================================
    // ID Stage Signals
    //========================================================================
    wire [6:0] id_opcode;
    wire [4:0] id_rs1, id_rs2, id_rd;
    wire [2:0] id_funct3;
    wire [6:0] id_funct7;
    wire [31:0] id_read_data1, id_read_data2;
    wire id_regwrite;
    wire [3:0] id_alu_control;
    
    //========================================================================
    // ID/EX Pipeline Register Signals
    //========================================================================
    wire [31:0] ex_pc;
    wire [31:0] ex_read_data1, ex_read_data2;
    wire [4:0] ex_rs1, ex_rs2, ex_rd;
    wire [3:0] ex_alu_control;
    wire ex_regwrite;
    wire flush_id_ex;
    
    //========================================================================
    // EX Stage Signals
    //========================================================================
    wire [31:0] ex_alu_result;
    wire ex_zero;
    wire [1:0] forward_a, forward_b;
    wire [31:0] ex_alu_input_a, ex_alu_input_b;
    
    //========================================================================
    // EX/MEM Pipeline Register Signals
    //========================================================================
    wire [31:0] mem_alu_result;
    wire [31:0] mem_write_data;
    wire [4:0] mem_rd;
    wire mem_regwrite;
    wire mem_zero;
    
    //========================================================================
    // MEM/WB Pipeline Register Signals
    //========================================================================
    wire [31:0] wb_alu_result;
    
    assign zero_flag = ex_zero;
    
    //========================================================================
    // Decode instruction fields (ID Stage)
    //========================================================================
    assign id_opcode = id_instruction[6:0];
    assign id_rd     = id_instruction[11:7];
    assign id_funct3 = id_instruction[14:12];
    assign id_rs1    = id_instruction[19:15];
    assign id_rs2    = id_instruction[24:20];
    assign id_funct7 = id_instruction[31:25];
    
    //========================================================================
    // IF/ID Pipeline Register
    //========================================================================
    IF_ID_REG if_id_reg(
        .clock(clock),
        .reset(reset),
        .stall(stall_if_id),
        .flush(flush_if_id),
        .if_pc(if_pc),
        .if_instruction(if_instruction),
        .id_pc(id_pc),
        .id_instruction(id_instruction)
    );
    
    //========================================================================
    // Control Unit (ID Stage)
    //========================================================================
    CONTROL control_unit(
        .funct7(id_funct7),
        .funct3(id_funct3),
        .opcode(id_opcode),
        .alu_control(id_alu_control),
        .regwrite_control(id_regwrite)
    );
    
    //========================================================================
    // Register File (ID Stage - Read, WB Stage - Write)
    //========================================================================
    REG_FILE reg_file(
        .read_reg_num1(id_rs1),
        .read_reg_num2(id_rs2),
        .write_reg(wb_rd),
        .write_data(wb_write_data),
        .read_data1(id_read_data1),
        .read_data2(id_read_data2),
        .regwrite(wb_regwrite),
        .clock(clock),
        .reset(reset)
    );
    
    //========================================================================
    // ID/EX Pipeline Register
    //========================================================================
    ID_EX_REG id_ex_reg(
        .clock(clock),
        .reset(reset),
        .flush(flush_id_ex),
        .id_regwrite(id_regwrite),
        .id_alu_control(id_alu_control),
        .id_pc(id_pc),
        .id_read_data1(id_read_data1),
        .id_read_data2(id_read_data2),
        .id_rs1(id_rs1),
        .id_rs2(id_rs2),
        .id_rd(id_rd),
        .ex_regwrite(ex_regwrite),
        .ex_alu_control(ex_alu_control),
        .ex_pc(ex_pc),
        .ex_read_data1(ex_read_data1),
        .ex_read_data2(ex_read_data2),
        .ex_rs1(ex_rs1),
        .ex_rs2(ex_rs2),
        .ex_rd(ex_rd)
    );
    
    //========================================================================
    // Forwarding Unit (EX Stage)
    //========================================================================
    FORWARDING_UNIT forwarding_unit(
        .id_ex_rs1(ex_rs1),
        .id_ex_rs2(ex_rs2),
        .ex_mem_rd(mem_rd),
        .ex_mem_regwrite(mem_regwrite),
        .mem_wb_rd(wb_rd),
        .mem_wb_regwrite(wb_regwrite),
        .forward_a(forward_a),
        .forward_b(forward_b)
    );
    
    //========================================================================
    // Forwarding Muxes (EX Stage)
    //========================================================================
    assign ex_alu_input_a = (forward_a == 2'b00) ? ex_read_data1 :
                            (forward_a == 2'b01) ? wb_write_data :
                            (forward_a == 2'b10) ? mem_alu_result :
                            ex_read_data1;
    
    assign ex_alu_input_b = (forward_b == 2'b00) ? ex_read_data2 :
                            (forward_b == 2'b01) ? wb_write_data :
                            (forward_b == 2'b10) ? mem_alu_result :
                            ex_read_data2;
    
    //========================================================================
    // ALU (EX Stage)
    //========================================================================
    ALU alu(
        .in1(ex_alu_input_a),
        .in2(ex_alu_input_b),
        .alu_control(ex_alu_control),
        .alu_result(ex_alu_result),
        .zero_flag(ex_zero)
    );
    
    //========================================================================
    // EX/MEM Pipeline Register
    //========================================================================
    EX_MEM_REG ex_mem_reg(
        .clock(clock),
        .reset(reset),
        .ex_regwrite(ex_regwrite),
        .ex_alu_result(ex_alu_result),
        .ex_write_data(ex_read_data2),
        .ex_rd(ex_rd),
        .ex_zero(ex_zero),
        .mem_regwrite(mem_regwrite),
        .mem_alu_result(mem_alu_result),
        .mem_write_data(mem_write_data),
        .mem_rd(mem_rd),
        .mem_zero(mem_zero)
    );
    
    //========================================================================
    // MEM/WB Pipeline Register
    //========================================================================
    MEM_WB_REG mem_wb_reg(
        .clock(clock),
        .reset(reset),
        .mem_regwrite(mem_regwrite),
        .mem_read_data(32'h00000000),  // No data memory for R-type only
        .mem_alu_result(mem_alu_result),
        .mem_rd(mem_rd),
        .wb_regwrite(wb_regwrite),
        .wb_read_data(),  // Unused
        .wb_alu_result(wb_alu_result),
        .wb_rd(wb_rd)
    );
    
    //========================================================================
    // Write Back Mux (WB Stage)
    //========================================================================
    assign wb_write_data = wb_alu_result;
    
    //========================================================================
    // Hazard Detection Unit
    //========================================================================
    HAZARD_DETECTION hazard_detection(
        .id_ex_rd(ex_rd),
        .id_ex_mem_read(1'b0),  // No load instruction for now
        .if_id_rs1(id_rs1),
        .if_id_rs2(id_rs2),
        .stall_pc(stall_pc),
        .stall_if_id(stall_if_id),
        .flush_id_ex(flush_id_ex)
    );
    
    assign flush_if_id = 1'b0;  // No branch prediction yet

endmodule