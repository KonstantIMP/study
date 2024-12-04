module divider #(
    parameter PWD_WIDTH = 4
) (
    input clk,
    input rst_n,
    input [PWD_WIDTH - 1 : 0] imp,
    output pwv_out
);
    wire [PWD_WIDTH - 1 : 0] cnt;

    counter #(.WIDTH (PWD_WIDTH)) counter (
        .clk (clk),
        .rst_n (rst_n),
        .load (1'b0),
        .data_load (1'b0),
        .cnt (cnt)
    );

    comparator #(.WIDTH (PWD_WIDTH)) comparator (
        .a (cnt),
        .b (imp),
        .lt (pwv_out)
    );
endmodule
