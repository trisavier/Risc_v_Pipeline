// ============================================================================
// PROCESSOR_PIPELINE_tb.v - Testbench for Pipelined Processor
// ============================================================================

`timescale 1ns/1ps

module PROCESSOR_PIPELINE_tb;

    reg clock;
    reg reset;
    wire zero;

    PROCESSOR_PIPELINE uut (
        .clock(clock),
        .reset(reset),
        .zero(zero)
    );

    // Clock generation - 10ns period
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    // Test sequence
    initial begin
        $display("========================================");
        $display("RISC-V Pipelined Processor Simulation");
        $display("========================================");
        
        reset = 1;
        #25;
        
        reset = 0;
        $display("Time=%0t: Reset released", $time);
        
        #250;
        
        $display("\n========================================");
        $display("Final Register Values:");
        $display("========================================");
        $display("x6  (t1) = %h", uut.datapath_module.reg_file.reg_memory[6]);
        $display("x7  (t2) = %h", uut.datapath_module.reg_file.reg_memory[7]);
        $display("x5  (t0) = %h", uut.datapath_module.reg_file.reg_memory[5]);
        $display("x28 (t3) = %h", uut.datapath_module.reg_file.reg_memory[28]);
        $display("========================================");
        
        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t | PC=%h | Instr=%h | Stall=%b", 
                 $time,
                 uut.if_pc,
                 uut.if_instruction,
                 uut.stall_pc);
    end

    // VCD dump
    initial begin
        $dumpfile("processor_pipeline_wave.vcd");
        $dumpvars(0, PROCESSOR_PIPELINE_tb);
    end

endmodule