module task10 #(
    parameter LEDS_COUNT = 6
) (
    input clk,
    input rst_n,
    output [LEDS_COUNT * 8 - 1 : 0] out_leds
);
    wire [LEDS_COUNT - 1 : 0] gray;

    gray_counter #(.WIDTH (LEDS_COUNT)) gray_counter (
        .clk (clk),
        .rst_n (rst_n),
        .cnt (gray)
    );

    genvar i;
    generate
        for (i = 0; i < LEDS_COUNT; i = i + 1) begin
            wire [4 - 1 : 0] zero_or_one;

            mux #(.WIDTH (4)) n_mux (
                .a (4'b0001),
                .b (4'b0000),
                .control (gray[LEDS_COUNT - i - 1]),
                .out (zero_or_one)
            );

            led7 #(.COUNT (1)) n_led (
                .data (zero_or_one),
                .leds (out_leds[8 * (LEDS_COUNT - i) - 1 : 8 * (LEDS_COUNT - i - 1)])
            );
        end
    endgenerate
endmodule
