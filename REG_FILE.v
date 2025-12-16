// ============================================================================
// REG_FILE.v - 32x32 Register File for RISC-V
// ============================================================================

module REG_FILE(
    input [4:0] read_reg_num1,
    input [4:0] read_reg_num2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input regwrite,
    input clock,
    input reset,
    output [31:0] read_data1,
    output [31:0] read_data2
);

    // 32 registers, each 32-bit wide
    reg [31:0] reg_memory [31:0];
    
    integer i;
    
    // Initialize registers
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                reg_memory[i] <= 32'h00000000;
            end
            // Initialize some registers with test values
            reg_memory[8]  <= 32'h00000005;  // s0 = 5
            reg_memory[9]  <= 32'h00000003;  // s1 = 3
            reg_memory[18] <= 32'h00000008;  // s2 = 8
            reg_memory[19] <= 32'h00000002;  // s3 = 2
            reg_memory[20] <= 32'h00000004;  // s4 = 4
            reg_memory[21] <= 32'h00000006;  // s5 = 6
            reg_memory[22] <= 32'h0000000A;  // s6 = 10
            reg_memory[23] <= 32'h00000007;  // s7 = 7
            reg_memory[24] <= 32'h00000010;  // s8 = 16
            reg_memory[25] <= 32'h00000002;  // s9 = 2
            reg_memory[26] <= 32'h000000FF;  // s10 = 255
            reg_memory[27] <= 32'h00000004;  // s11 = 4
            reg_memory[12] <= 32'h0000FF00;  // a2
            reg_memory[13] <= 32'h000000FF;  // a3
            reg_memory[14] <= 32'h00000055;  // a4
            reg_memory[15] <= 32'h000000AA;  // a5
        end
        else if (regwrite && write_reg != 5'b00000) begin
            reg_memory[write_reg] <= write_data;
        end
    end
    
    // Read operations (combinational)
    assign read_data1 = (read_reg_num1 == 5'b00000) ? 32'h00000000 : reg_memory[read_reg_num1];
    assign read_data2 = (read_reg_num2 == 5'b00000) ? 32'h00000000 : reg_memory[read_reg_num2];

endmodule