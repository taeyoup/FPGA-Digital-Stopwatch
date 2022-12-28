module LEDdriver(
input wire [1:0] STATE,
input wire AL_ON,	//from state machine 
input wire Clk_2Hz,
input wire AL_switch,
output reg [7:0] LED
);

always@(*)
begin
  case(STATE[1:0])
    2'b00:  begin 
		LED[7] <= 1'b0;
		LED[6] <= 1'b0;  //state '0'
	   end
    2'b01:  begin
		LED[7] <= 1'b1;
		LED[6] <= 1'b0;  //state '1'
	   end
    2'b10:  begin
		LED[7] <= 1'b0;
		LED[6] <= 1'b1;  //state '2'
	   end
  endcase
  if(AL_switch == 1'b0)
    LED[5] <= 1'b0;
  else if(AL_switch == 1'b1)
    LED[5] <= 1'b1;
end

      
always@(posedge Clk_2Hz)     
begin 
  if(AL_ON == 1'b1)
  begin
    if(LED[4] !== 1'b1)
      begin
        LED[4] <= 1'b1;
	LED[3] <= 1'b1;
  	LED[2] <= 1'b1;
	LED[1] <= 1'b1;
	LED[0] <= 1'b1;
      end
  
     else if(LED[4] == 1'b1)
      begin
        LED[4] <= 1'b0;
	LED[3] <= 1'b0;
        LED[2] <= 1'b0;
	LED[1] <= 1'b0;
	LED[0] <= 1'b0;    
      end
  end
  else if(AL_ON == 1'b0)
    begin
      LED[4] <= 1'b0;
      LED[3] <= 1'b0;
      LED[2] <= 1'b0;
      LED[1] <= 1'b0;
      LED[0] <= 1'b0; 
    end
end
endmodule
