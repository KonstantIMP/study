module gray_counter #(
    parameter WIDTH = 4
) (
    input clk,
    input rst_n,
    output [WIDTH - 1 : 0] cnt
);
  wire [WIDTH - 1 : 0] cnt_bin;

  counter #(.WIDTH (WIDTH)) counter (
    .clk (clk),
    .rst_n (rst_n),
    .data_load (1'b0),
    .load (1'b0),
    .cnt (cnt_bin)
  );

  bin2gray #(.WIDTH (WIDTH)) bin2gray (
    .in (cnt_bin),
    .out (cnt)
  );
endmodule