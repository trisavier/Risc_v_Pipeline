library verilog;
use verilog.vl_types.all;
entity DATAPATH_PIPELINE is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        if_instruction  : in     vl_logic_vector(31 downto 0);
        if_pc           : in     vl_logic_vector(31 downto 0);
        stall_pc        : out    vl_logic;
        wb_write_data   : out    vl_logic_vector(31 downto 0);
        wb_rd           : out    vl_logic_vector(4 downto 0);
        wb_regwrite     : out    vl_logic;
        zero_flag       : out    vl_logic
    );
end DATAPATH_PIPELINE;
