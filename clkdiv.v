module clkdiv(
  input mclk, // 1Mhz
  output reg clkout, // 1Hz
  output reg clkout_2Hz
);
reg[19:0] rCnt=20'h0_0000;
reg[19:0] rCnt_2=20'h0_0000;

always @(posedge mclk)	//1Hz
begin
  if (rCnt[19:0] >= 20'h7_a120) begin	//500000
    rCnt[19:0] <= 20'h0_0000;
    clkout <= ~clkout;
  end
else begin
  rCnt[19:0] <= rCnt[19:0] + 20'h0_0001;
     end
end

always @(posedge mclk)	//2Hz
begin
  if (rCnt_2[19:0] >= 20'h3_d090) begin	//250000
    rCnt_2[19:0] <= 20'h0_0000;
    clkout_2Hz <= ~clkout_2Hz;
  end
else begin
  rCnt_2[19:0] <= rCnt_2[19:0] + 20'h0_0001;
     end
end

endmodule

