library verilog;
use verilog.vl_types.all;
entity ID_EX_REG is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        flush           : in     vl_logic;
        id_regwrite     : in     vl_logic;
        id_alu_control  : in     vl_logic_vector(3 downto 0);
        id_pc           : in     vl_logic_vector(31 downto 0);
        id_read_data1   : in     vl_logic_vector(31 downto 0);
        id_read_data2   : in     vl_logic_vector(31 downto 0);
        id_rs1          : in     vl_logic_vector(4 downto 0);
        id_rs2          : in     vl_logic_vector(4 downto 0);
        id_rd           : in     vl_logic_vector(4 downto 0);
        ex_regwrite     : out    vl_logic;
        ex_alu_control  : out    vl_logic_vector(3 downto 0);
        ex_pc           : out    vl_logic_vector(31 downto 0);
        ex_read_data1   : out    vl_logic_vector(31 downto 0);
        ex_read_data2   : out    vl_logic_vector(31 downto 0);
        ex_rs1          : out    vl_logic_vector(4 downto 0);
        ex_rs2          : out    vl_logic_vector(4 downto 0);
        ex_rd           : out    vl_logic_vector(4 downto 0)
    );
end ID_EX_REG;
