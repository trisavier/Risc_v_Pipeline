library verilog;
use verilog.vl_types.all;
entity MEM_WB_REG is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        mem_regwrite    : in     vl_logic;
        mem_read_data   : in     vl_logic_vector(31 downto 0);
        mem_alu_result  : in     vl_logic_vector(31 downto 0);
        mem_rd          : in     vl_logic_vector(4 downto 0);
        wb_regwrite     : out    vl_logic;
        wb_read_data    : out    vl_logic_vector(31 downto 0);
        wb_alu_result   : out    vl_logic_vector(31 downto 0);
        wb_rd           : out    vl_logic_vector(4 downto 0)
    );
end MEM_WB_REG;
