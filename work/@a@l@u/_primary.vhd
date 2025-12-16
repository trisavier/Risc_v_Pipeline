library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        in1             : in     vl_logic_vector(31 downto 0);
        in2             : in     vl_logic_vector(31 downto 0);
        alu_control     : in     vl_logic_vector(3 downto 0);
        alu_result      : out    vl_logic_vector(31 downto 0);
        zero_flag       : out    vl_logic
    );
end ALU;
