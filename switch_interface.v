module switch_interface(
input  mclk,
input [3:0]switch_in,
output reg [3:0] switch
);

reg [3:0] dff1 = 4'b0000;
reg [3:0] dff2 = 4'b0000;
reg [3:0] dff3 = 4'b0000;

wire [3:0] posswitch_DET;
wire [3:0] negswitch_DET;

always@(posedge mclk)
begin
 dff1[3:0] <= switch_in[3:0];
 dff2[3:0] <= dff1[3:0];
 dff3[3:0] <= dff2[3:0];
end

assign posswitch_DET[3:0] = ~dff3[3:0] & dff2[3:0]; // posedge det
assign negswitch_DET[3:0] = dff3[3:0] & ~dff2[3:0]; // negedge det

always @(posedge mclk)
begin
  if (posswitch_DET[0]) begin           
     switch[0] <= 1'b1;
  end
  else if (posswitch_DET[1]) begin
     switch[1] <= 1'b1;
  end
  else if (posswitch_DET[2]) begin
     switch[2] <= 1'b1;
  end
  else if (posswitch_DET[3]) begin
     switch[3] <= 1'b1;
  end
  
  else if (negswitch_DET[0]) begin
	  switch[0] <= 1'b0;
  end
  else if (negswitch_DET[1]) begin
	  switch[1] <= 1'b0;
  end
  else if (negswitch_DET[2]) begin
	  switch[2] <= 1'b0;
  end
  else if (negswitch_DET[3]) begin
	  switch[3] <= 1'b0;
  end
  
end


endmodule
