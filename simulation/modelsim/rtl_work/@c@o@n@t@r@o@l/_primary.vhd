library verilog;
use verilog.vl_types.all;
entity CONTROL is
    port(
        funct7          : in     vl_logic_vector(6 downto 0);
        funct3          : in     vl_logic_vector(2 downto 0);
        opcode          : in     vl_logic_vector(6 downto 0);
        alu_control     : out    vl_logic_vector(3 downto 0);
        regwrite_control: out    vl_logic
    );
end CONTROL;
