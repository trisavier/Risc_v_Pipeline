library verilog;
use verilog.vl_types.all;
entity IFU_PIPELINE is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        stall           : in     vl_logic;
        if_pc           : out    vl_logic_vector(31 downto 0);
        if_instruction  : out    vl_logic_vector(31 downto 0)
    );
end IFU_PIPELINE;
