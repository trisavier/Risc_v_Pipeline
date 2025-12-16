// ============================================================================
// ID_EX_REG.v - Pipeline Register between ID and EX stages
// ============================================================================

module ID_EX_REG(
    input clock,
    input reset,
    input flush,
    input id_regwrite,
    input [3:0] id_alu_control,
    input [31:0] id_pc,
    input [31:0] id_read_data1,
    input [31:0] id_read_data2,
    input [4:0] id_rs1,
    input [4:0] id_rs2,
    input [4:0] id_rd,
    output reg ex_regwrite,
    output reg [3:0] ex_alu_control,
    output reg [31:0] ex_pc,
    output reg [31:0] ex_read_data1,
    output reg [31:0] ex_read_data2,
    output reg [4:0] ex_rs1,
    output reg [4:0] ex_rs2,
    output reg [4:0] ex_rd
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            ex_regwrite <= 1'b0;
            ex_alu_control <= 4'b0000;
            ex_rd <= 5'b00000;
            ex_rs1 <= 5'b00000;
            ex_rs2 <= 5'b00000;
            ex_read_data1 <= 32'h00000000;
            ex_read_data2 <= 32'h00000000;
            ex_pc <= 32'h00000000;
        end
        else if (flush) begin
            ex_regwrite <= 1'b0;
            ex_alu_control <= 4'b0000;
            ex_rd <= 5'b00000;
            ex_rs1 <= 5'b00000;
            ex_rs2 <= 5'b00000;
            ex_read_data1 <= 32'h00000000;
            ex_read_data2 <= 32'h00000000;
            ex_pc <= 32'h00000000;
        end
        else begin
            ex_regwrite <= id_regwrite;
            ex_alu_control <= id_alu_control;
            ex_rd <= id_rd;
            ex_rs1 <= id_rs1;
            ex_rs2 <= id_rs2;
            ex_read_data1 <= id_read_data1;
            ex_read_data2 <= id_read_data2;
            ex_pc <= id_pc;
        end
    end

endmodule