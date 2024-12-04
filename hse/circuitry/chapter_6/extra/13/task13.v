module task10 #(
    parameter LEDS = 8
) (
    input clk,
    input rst_n,
    input button,
    input data_in,
    output [LEDS - 1 : 0] leds
);
  wire direction;

  t_flip_flop tff (
    .t (button),
    .rst_n (rst_n),
    .out (direction)
  );

  shift_directional_reg #(.WIDTH (LEDS)) shift_directional_reg (
    .clk (clk),
    .rst_n (rst_n),
    .data_in (data_in),
    .shift_en (1),
    .direction (~direction),
    .data_out (leds)
  );

endmodule
