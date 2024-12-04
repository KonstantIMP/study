module substractor #(
    parameter WIDTH = 8
) (
    input [WIDTH - 1 : 0] x,
    input [WIDTH - 1 : 0] y,
    input carry_in,
    output [WIDTH - 1 : 0] z,
    output carry_out
);
  assign z = x - y - carry_in;
  assign carry_out = x > (y + carry_in);
endmodule
