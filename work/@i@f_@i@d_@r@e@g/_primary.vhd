library verilog;
use verilog.vl_types.all;
entity IF_ID_REG is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        stall           : in     vl_logic;
        flush           : in     vl_logic;
        if_pc           : in     vl_logic_vector(31 downto 0);
        if_instruction  : in     vl_logic_vector(31 downto 0);
        id_pc           : out    vl_logic_vector(31 downto 0);
        id_instruction  : out    vl_logic_vector(31 downto 0)
    );
end IF_ID_REG;
