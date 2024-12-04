module rs_flip_flop (
    input clk,
    input r,
    input s,
    output q,
    output q_n
);
  rs_latch rs_latch (
    .r (clk & r),
    .s (clk & s),
    .q (q),
    .q_n (q_n)
  );
endmodule
