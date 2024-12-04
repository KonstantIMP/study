`timescale 1 ns / 100 ps;
module d_flip_flop_testbench;
  reg clk, d;
  wire q, q_n;

  d_flip_flop d_flip_flop (
    .clk (clk),
    .d (d),
    .q (q),
    .q_n (q_n)
  );

  initial
    $dumpvars;

  initial
    begin
      $monitor ("%0d | clk = %b | d = %b | q = %b | q_n = %b", $time, clk, d, q, q_n);
      # 10; clk = 0; d = 0;
      # 10; clk = 1; d = 0;
      # 10; clk = 1; d = 1;
      # 10; clk = 0; d = 1;
      # 10; clk = 0; d = 0;
      # 10; clk = 0; d = 1;
      # 10; clk = 1; d = 1;
      # 10; clk = 0; d = 1;
      # 10; clk = 0; d = 0;
      # 10;
    end
endmodule
