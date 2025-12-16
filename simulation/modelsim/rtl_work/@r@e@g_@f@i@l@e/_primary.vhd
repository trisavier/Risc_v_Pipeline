library verilog;
use verilog.vl_types.all;
entity REG_FILE is
    port(
        read_reg_num1   : in     vl_logic_vector(4 downto 0);
        read_reg_num2   : in     vl_logic_vector(4 downto 0);
        write_reg       : in     vl_logic_vector(4 downto 0);
        write_data      : in     vl_logic_vector(31 downto 0);
        regwrite        : in     vl_logic;
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        read_data1      : out    vl_logic_vector(31 downto 0);
        read_data2      : out    vl_logic_vector(31 downto 0)
    );
end REG_FILE;
