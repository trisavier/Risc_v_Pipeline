library verilog;
use verilog.vl_types.all;
entity FORWARDING_UNIT is
    port(
        id_ex_rs1       : in     vl_logic_vector(4 downto 0);
        id_ex_rs2       : in     vl_logic_vector(4 downto 0);
        ex_mem_rd       : in     vl_logic_vector(4 downto 0);
        ex_mem_regwrite : in     vl_logic;
        mem_wb_rd       : in     vl_logic_vector(4 downto 0);
        mem_wb_regwrite : in     vl_logic;
        forward_a       : out    vl_logic_vector(1 downto 0);
        forward_b       : out    vl_logic_vector(1 downto 0)
    );
end FORWARDING_UNIT;
