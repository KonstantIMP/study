module shift_directional_reg #(
    parameter WIDTH = 8
) (
    input clk,
    input rst_n,
    input data_in,
    input shift_en,
    input direction,
    output reg [WIDTH - 1 : 0] data_out,
    output serial_out
);
  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
        data_out <= {WIDTH{1'b0}};
    else if(shift_en) begin
        if (direction)
            data_out <= {data_in,data_out[WIDTH-1:1]};
        else
            data_out <= {data_out[WIDTH-2:0], data_in};
    end
  end
   
   assign serial_out = data_out[0];
    
endmodule
