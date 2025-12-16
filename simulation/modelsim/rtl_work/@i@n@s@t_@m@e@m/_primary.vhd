library verilog;
use verilog.vl_types.all;
entity INST_MEM is
    port(
        PC              : in     vl_logic_vector(31 downto 0);
        reset           : in     vl_logic;
        Instruction_Code: out    vl_logic_vector(31 downto 0)
    );
end INST_MEM;
