module d_latch (
    input clk,
    input d,
    output q,
    output q_n
);
  wire r = clk & (~ d);
  wire s = clk & d;

  rs_latch rs_latch (s, r, q, q_n); 

endmodule
