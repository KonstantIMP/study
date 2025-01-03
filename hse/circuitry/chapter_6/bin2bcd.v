module bin2bcd #(
  parameter WIDTH = 18,
  parameter DIGITS = 4
) (
    input [WIDTH - 1 : 0] bin,
    output reg [DIGITS * 4 - 1 : 0] bcd
);
  integer i, j;
  always@*
  begin
    bcd = 0;
    for (i=WIDTH-1; i>=0; i=i-1) 
    begin  
      for (j=DIGITS-1; j >= 0; j = j - 1)
        if (bcd[4*j +: 4] >= 5) 
          bcd[4*j +: 4] = bcd[4*j +: 4] + 3;
      bcd = bcd << 1;
      bcd[0] = bin[i];
    end
  end
endmodule
