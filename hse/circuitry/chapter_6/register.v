module register #(
    parameter WIDTH = 8
) (
    input clk,
    input rst_n,
    input [WIDTH - 1 : 0] in,
    output [WIDTH - 1 : 0] out
);
  genvar i;
  generate
    for (i = 0; i < WIDTH; i = i + 1)
    begin: stage
      d_flip_flop dff (
        .clk (clk),
        .rst_n (rst_n),
        .d (in[WIDTH - i - 1]),
        .q (out[WIDTH - i - 1])
      );
    end
  endgenerate
endmodule
