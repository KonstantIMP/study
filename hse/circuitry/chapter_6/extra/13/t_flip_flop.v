module t_flip_flop (
    input t,
    input rst_n,
    output reg out
);
  always @(posedge t or negedge rst_n) begin
    if (!rst_n) begin
        out <= 0;
    end else begin
        out <= ~out;
    end
  end
endmodule
