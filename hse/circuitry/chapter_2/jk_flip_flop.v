module sr_latch(s, r, q, qbar);
    input s, r;
    output q, qbar;
    nand(q, s, qbar);
    nand(qbar, r, q);
endmodule

module jk_flip_flop (
    input clk,
    input j,
    input k,
    output q,
    output q_n
);
  wire sn = clk & q_n & j;
  wire rn = clk & q & k;
  sr_latch SRL (sn, rn, q, q_n);
endmodule
