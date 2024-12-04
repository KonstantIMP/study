module d_flip_flop (
    input clk,
    input d,
    output q,
    output q_n
);
  wire n1_clk = ~ clk;
  wire n1_q;

  d_latch n1 (
    .clk (n1_clk),
    .d (d),
    .q (n1_q)
  );

  d_latch n2 (
    .clk (clk),
    .d (n1_q),
    .q (q),
    .q_n (q_n)
  );

endmodule
