module divider #(
    parameter N = 10,
    parameter WIDTH = $clog2(N)
) (
    input clk,
    input rst_n,
    output clk_div
);
    wire [WIDTH - 1 : 0] cnt;

    counter #(.WIDTH (WIDTH)) counter (
        .clk (clk),
        .rst_n (rst_n),
        .data_load (1'b0),
        .load (clk_div),
        .cnt (cnt)
    );

    comparator #(.WIDTH (WIDTH)) comparator (
        .a (cnt),
        .b (N - 1),
        .eq (clk_div)
    );
endmodule
