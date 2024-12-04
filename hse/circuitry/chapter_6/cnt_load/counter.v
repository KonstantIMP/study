module counter #(
    parameter WIDTH = 8
) (
    input clk,
    input rst_n,
    input [WIDTH - 1 : 0] data_load,
    input load,
    output [WIDTH - 1 : 0] cnt
);
  wire [WIDTH - 1 : 0] adder_next;
  wire [WIDTH - 1 : 0] next;

  wire adder_carry_out;

  mux #(.WIDTH (WIDTH)) load_mux (
    .a (data_load),
    .b (adder_next),
    .control (load),
    .out (next)
  );

  adder #(.WIDTH (WIDTH)) adder (
    .x (cnt),
    .y (1'b1),
    .carry_in (1'b0),
    .z (adder_next),
    .carry_out (adder_carry_out)
  );

  register #(.WIDTH (WIDTH)) register (
    .clk (clk),
    .rst_n (rst_n /*& (~ adder_carry_out)*/), // + carry_out?
    .in (next),
    .out (cnt)
  );
endmodule
