module shift_register #(
    parameter WIDTH = 4
) (
    input clk,
    input rst_n,
    input data_in,
    input shift_en,
    output [WIDTH - 1 : 0] data_out,
    output serial_out
);
  wire [0 : WIDTH] w;

  assign w[0] = data_in;
  assign data_out = w[1 : WIDTH];
  assign serial_out = w[WIDTH];

  genvar i;
  generate
    for (i = 0; i < WIDTH; i = i + 1)
    begin: stage
      d_flip_flop dff (
        .clk (clk & shift_en),
        .rst_n (rst_n),
        .d (w[i]),
        .q (w[i + 1])
      );
    end
  endgenerate
endmodule
