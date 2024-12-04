module d_flip_flop (
    input clk,
    input rst_n,
    input d,
    output reg q,
    output reg q_n
);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 0;
      q_n <= 1;
    end else begin
      q <= d;
      q_n <= ~ d; 
    end
  end  
endmodule
