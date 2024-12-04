module task2 #(
    parameter LEDS_COUNT = 6
) (
    input clk,
    input rst_n,
    output [LEDS_COUNT * 8 - 1 : 0] out_leds
);
    wire [LEDS_COUNT * 4 - 1 : 0] to_leds;

    counter #(.WIDTH (4)) counter (
        .clk (clk),
        .rst_n (rst_n),
        .data_load (1'b0),
        .load (0),
        .cnt (to_leds [4 - 1 : 0])
    );

    genvar i;
    generate
        for (i = 1; i < LEDS_COUNT; i++) begin
            assign to_leds [4 * (i + 1) - 1 : 4 * i] = to_leds [4 - 1 : 0];
        end
    endgenerate

    led7 #(.COUNT (LEDS_COUNT)) led7 (
        .data (to_leds),
        .leds (out_leds)
    );

endmodule
