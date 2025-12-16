library verilog;
use verilog.vl_types.all;
entity EX_MEM_REG is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        ex_regwrite     : in     vl_logic;
        ex_alu_result   : in     vl_logic_vector(31 downto 0);
        ex_write_data   : in     vl_logic_vector(31 downto 0);
        ex_rd           : in     vl_logic_vector(4 downto 0);
        ex_zero         : in     vl_logic;
        mem_regwrite    : out    vl_logic;
        mem_alu_result  : out    vl_logic_vector(31 downto 0);
        mem_write_data  : out    vl_logic_vector(31 downto 0);
        mem_rd          : out    vl_logic_vector(4 downto 0);
        mem_zero        : out    vl_logic
    );
end EX_MEM_REG;
