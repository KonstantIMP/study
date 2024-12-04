module task1 #(
    parameter WIDTH = 18,
    parameter LEDS_COUNT = 6
) (
    input clk,
    input rst_n,
    output [LEDS_COUNT * 8 - 1 : 0] out_leds
);
    wire [WIDTH - 1 : 0] to_bcd;
    wire [LEDS_COUNT * 4 - 1 : 0] to_led_w;

    counter #(.WIDTH (WIDTH)) counter (
        .clk (clk),
        .rst_n (rst_n),
        .data_load (1'b0),
        .load(0),
        .cnt (to_bcd)
    );

    bin2bcd #(.WIDTH (WIDTH), .DIGITS (LEDS_COUNT)) bin2bcd (
        .bin(to_bcd),
        .bcd (to_led_w)
    );

    led7 #(.COUNT (LEDS_COUNT)) led7 (
        .data (to_led_w),
        .leds (out_leds)
    );

endmodule
