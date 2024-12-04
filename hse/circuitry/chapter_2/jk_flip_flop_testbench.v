`timescale 1 ns / 100 ps;
module jk_flip_flop_testbench;
  reg clk, j, k;
  wire q, q_n;

  jk_flip_flop jk_flip_flop (
    .clk (clk),
    .j (j),
    .k (k),
    .q (q),
    .q_n (q_n)
  );

  initial
    $dumpvars;

  initial
    begin
      $monitor ("%0d | clk = %b | j = %b | k = %b | q = %b | q_n = %b", $time, clk, j, k, q, q_n);
      # 10; clk = 0; j = 0; k = 0;
      # 10; clk = 1; j = 0; k = 0;
      # 10; clk = 1; j = 1; k = 0;
      # 10; clk = 1; j = 0; k = 1;
      # 10; clk = 1; j = 1; k = 1;
      # 10; clk = 0; j = 0; k = 0;
      # 10; clk = 0; j = 1; k = 1;
      # 10; clk = 1; j = 1; k = 1;
      # 10; clk = 0; j = 0; k = 0;
      # 10; clk = 0; j = 1; k = 0;
      # 10; clk = 1; j = 1; k = 0;
      # 10; clk = 0; j = 0; k = 0;
      # 10; clk = 0; j = 1; k = 1;
      # 10; clk = 1; j = 1; k = 1;
      # 10; clk = 0; j = 0; k = 0;
      # 10; clk = 0; j = 0; k = 1;
      # 10; clk = 1; j = 0; k = 1;
      # 10; clk = 0; j = 0; k = 0;
      # 10;
    end

endmodule
