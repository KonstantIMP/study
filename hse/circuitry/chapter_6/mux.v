module mux #(
    parameter WIDTH = 8
) (
    input [WIDTH - 1 : 0] a,
    input [WIDTH - 1 : 0] b,
    input control,
    output [WIDTH - 1 : 0] out
);
  assign out = control ? a : b;
endmodule
