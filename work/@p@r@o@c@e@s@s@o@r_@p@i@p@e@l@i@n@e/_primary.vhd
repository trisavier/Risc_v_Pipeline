library verilog;
use verilog.vl_types.all;
entity PROCESSOR_PIPELINE is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        zero            : out    vl_logic
    );
end PROCESSOR_PIPELINE;
