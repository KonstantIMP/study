module bin2gray #(
    parameter WIDTH = 4
) (
    input [WIDTH - 1 : 0] in,
    output [WIDTH - 1 : 0] out
);
  assign out = in ^ (in >> 1);  
endmodule