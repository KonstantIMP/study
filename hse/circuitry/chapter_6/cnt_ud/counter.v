module counter #(
    parameter WIDTH = 8
) (
    input clk,
    input rst_n,
    input up_down,
    output [WIDTH - 1 : 0] cnt
);
    wire [WIDTH - 1 : 0] sum;
    wire [WIDTH - 1 : 0] sub;
    wire [WIDTH - 1 : 0] next;

    adder #(.WIDTH (WIDTH)) adder (
        .x (cnt),
        .y (1'b1),
        .carry_in (0),
        .z (sum)
    );

    substractor #(.WIDTH (WIDTH)) substractor (
        .x (cnt),
        .y (1'b1),
        .carry_in (0),
        .z (sub)
    );

    register #(.WIDTH (WIDTH)) register (
        .clk (clk),
        .rst_n (rst_n),
        .in (next),
        .out (cnt)
    );

    mux #(.WIDTH (WIDTH)) mux (
        .a (sum),
        .b (sub),
        .control (up_down),
        .out (next)
    );
endmodule
