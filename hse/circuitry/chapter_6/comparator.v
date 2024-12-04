module comparator #(
    parameter WIDTH = 8
) (
    input [WIDTH - 1 : 0] a,
    input [WIDTH - 1 : 0] b,
    output eq,
    output gt,
    output lt
);
  assign eq = a != b ? 0 : 1;
  assign gt = (a > b) ? 1 : 0;
  assign lt = (a < b) ? 1 : 0;
endmodule
