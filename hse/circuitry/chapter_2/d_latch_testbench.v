`timescale 1 ns / 100 ps
module d_latch_testbench;
  reg clk, d;
  wire q, q_n;

  d_latch d_latch (clk, d, q, q_n);

  initial
    $dumpvars;

  initial
    begin
      $monitor ("%0d | clk = %b | d = %b | q = %b | q_n = %b", $time, clk, d, q, q_n);
      # 10; clk = 0; d = 0;
      # 10; clk = 1; d = 0;
      # 10; clk = 0; d = 0;
      # 10; clk = 0; d = 1;
      # 10; clk = 1; d = 1;
      # 10; clk = 1; d = 0;
      # 10; clk = 1; d = 1;
      # 10; clk = 0; d = 0;
      # 10; clk = 0; d = 1;
      # 10;
    end
endmodule
