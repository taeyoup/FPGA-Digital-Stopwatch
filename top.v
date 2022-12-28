module top(
  input wire mclk,
  input wire [3:0] switch_in,
  output wire [6:0] SEG1, // hour10
  output wire [6:0] SEG2, // hour
  output wire [6:0] SEG3, // minute10
  output wire [6:0] SEG4, // minute
  output wire [6:0] SEG5, // second10
  output wire [6:0] SEG6, // sec
  
  output wire [7:0] LED
  );
  
  wire [3:0] switch;
  wire clk;	//1Hz
  wire Clk_2Hz;	//2Hz
  wire Clk_100Hz;	//100Hz
  wire [18:0] AL_time;	//Alarm set time
  wire [18:0] present_time;
  wire [18:0] timeset;
  wire AL_ON;
  wire AL_switch;
  wire [1:0] state;
  wire [2:0] set_state;
  wire [2:0] set_state2;
  
  
  clkdiv clkdiv_0 (.mclk(mclk), .clkout(clk), .clkout_2Hz(Clk_2Hz));
  switch_interface switch_interface_0(.mclk(mclk), .switch_in(switch_in[3:0]), .switch(switch[3:0]));
  State_machine State_machine_0 (.switch(switch[3:0]), .state(state[1:0]));
  counter counter_0 (.timeset(timeset[18:0]), .clk(clk), .state(state[1:0]), .present_time(present_time[18:0]));
  ALARM ALARM_0 (.STATE(state[1:0]), .switch(switch[3:0]), .AL_time(AL_time[18:0]), .AL_switch(AL_switch), .present_time(present_time[18:0]), .AL_ON(AL_ON), .set_state2(set_state2[2:0]));
  seg7dec seg7dec_0 (.present_time(present_time[18:0]), .clk(Clk_2Hz), .S_STATE(set_state[2:0]), .S_STATE2(set_state2[2:0]), .state(state[1:0]), .AL_time(AL_time[18:0]), .timeset(timeset[18:0]), .SEG1(SEG1[6:0]), .SEG2(SEG2[6:0]), .SEG3(SEG3[6:0]), .SEG4(SEG4[6:0]), .SEG5(SEG5[6:0]), .SEG6(SEG6[6:0]));
  LEDdriver LEDdriver_0 (.STATE(state[1:0]), .AL_switch(AL_switch), .AL_ON(AL_ON), .Clk_2Hz(Clk_2Hz), .LED(LED[7:0]));
  time_set  time_set_0 (.STATE(state), .switch(switch[3:0]), .timeset(timeset[18:0]), .set_state(set_state[2:0]));
   
  
endmodule
