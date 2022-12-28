module State_machine(
input  wire [3:0] switch,
output  [1:0] state
);

reg [1:0] STATE = 2'b00;
assign state[1:0] = STATE[1:0];

always @(posedge switch[0])
begin
  if (STATE[1:0] >= 2'b10) begin      
    STATE[1:0] <= 2'b00;
  end   
  else begin 
    STATE[1:0] <= STATE[1:0] + 2'b01;
  end
end
endmodule
