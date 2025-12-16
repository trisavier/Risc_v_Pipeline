library verilog;
use verilog.vl_types.all;
entity HAZARD_DETECTION is
    port(
        id_ex_rd        : in     vl_logic_vector(4 downto 0);
        id_ex_mem_read  : in     vl_logic;
        if_id_rs1       : in     vl_logic_vector(4 downto 0);
        if_id_rs2       : in     vl_logic_vector(4 downto 0);
        stall_pc        : out    vl_logic;
        stall_if_id     : out    vl_logic;
        flush_id_ex     : out    vl_logic
    );
end HAZARD_DETECTION;
