module ALARM(
input wire [1:0] STATE,
input wire [3:0] switch,
input wire [18:0] present_time,
output [18:0] AL_time,
output [2:0] set_state2,
output AL_switch,
output AL_ON
);
//setting initial value
reg[3:0] AL_sec = 4'b0000;
reg[2:0] AL_second10 = 3'b000;
reg[3:0] AL_min = 4'b0000;
reg[2:0] AL_minute10 = 3'b000;
reg[3:0] AL_hour = 4'b0000;
reg AL_hour10 = 1'b0;
reg[2:0] S_STATE2 = 3'b000;
reg Alarm_switch = 1'b0;
reg Alarm_on = 1'b0;

assign AL_time[3:0] = AL_sec[3:0];
assign AL_time[6:4] = AL_second10[2:0];
assign AL_time[10:7] = AL_min[3:0];
assign AL_time[13:11] = AL_minute10[2:0];
assign AL_time[17:14] = AL_hour[3:0];
assign AL_time[18] = AL_hour10;
assign set_state2 = S_STATE2;
assign AL_switch = Alarm_switch;
assign AL_ON = Alarm_on;

always @ (posedge switch[1])	// switch input button '2' = 1
begin
  if(STATE [1:0] == 2'b10)
    begin
      S_STATE2 [2:0] <= S_STATE2 [2:0] + 3'b001;
      if(S_STATE2 [2:0] == 3'b110)
        begin
          S_STATE2 [2:0] <= 3'b000;
        end
    end
end
//alarm time setting mode
always @ (posedge switch[2])	//switch input button '3' = 1
  begin
    if(STATE [1:0] == 2'b10)
      begin
        if(S_STATE2 == 3'b000)
          begin
            AL_sec <= AL_sec + 4'b0001;
            if(AL_sec == 4'b1001)    //9sec>>10sec
               begin
                 AL_sec <= 4'b0000;
                 AL_second10 <= AL_second10 + 3'b001;           
            if(AL_second10 == 3'b101 && AL_sec == 4'b1001)	//59sec >> 1min
              begin
                AL_second10 <= 3'b000;
                AL_min <= AL_min + 4'b0001;              
            if(AL_min == 4'b1001)	//9min >> 10min
              begin
                AL_min <= 4'b0000;
                AL_minute10 <= AL_minute10 + 3'b001;              
            if(AL_minute10 == 3'b101 && AL_min == 4'b1001)	//59min >> 1hour
              begin
                AL_minute10 <= 3'b000;
                AL_hour <= AL_hour + 4'b0001;              
            if(AL_hour == 4'b1001)	//9hour >> 10hour
              begin
                AL_hour <= 4'b0000;
                AL_hour10 <= AL_hour10 + 1'b1;
              end
          else if(AL_hour10 == 1'b1 && AL_hour == 4'b0001)  //11hour >> 0
              begin
                AL_hour <= 4'b0000;
                AL_hour10 <= 1'b0;
              end
	end
	end
	end
	end
        end
       
      else if(S_STATE2 == 3'b001)
        begin
          AL_second10 <= AL_second10 + 3'b001;
            if(AL_second10 == 3'b101)	//5x sec >> 0x sec
              begin
                AL_second10 <= 4'b0000;
                AL_min <= AL_min + 4'b0001;              
            if(AL_min == 4'b1001)	//9min >> 10min
              begin
                AL_min <= 4'b0000;
                AL_minute10 <= AL_minute10 + 3'b001;              
            if(AL_minute10 == 3'b101 && AL_min == 4'b1001)	//59min >> 1hour
              begin
                AL_minute10 <= 3'b000;
                AL_hour <= AL_hour + 4'b0001;              
            if(AL_hour == 4'b1001)	//9hour >> 10hour
              begin
                AL_hour <= 4'b0000;
                AL_hour10 <= AL_hour10 + 1'b1;
              end
          else if(AL_hour10 == 1'b1 && AL_hour == 4'b0001)  //11hour >> 0
              begin
                AL_hour <= 4'b0000;
                AL_hour10 <= 1'b0;
              end
	end
	end
	end
        end
      else if(S_STATE2 == 3'b010)
        begin
          AL_min <= AL_min + 4'b0001;
            if(AL_min == 4'b1001)	//9min >> 10min
              begin
                AL_min <= 4'b0000;
                AL_minute10 <= AL_minute10 + 3'b001;             
            if(AL_minute10 == 3'b101 && AL_min == 4'b1001)	//59min >> 1hour
              begin
                AL_minute10 <= 3'b000;
                AL_hour <= AL_hour + 4'b0001;             
            if(AL_hour == 4'b1001)	//9hour >> 10hour
              begin
                AL_hour <= 4'b0000;
                AL_hour10 <= AL_hour10 + 1'b1;
              end
          else if(AL_hour10 == 1'b1 && AL_hour == 4'b0001)  //11hour >> 0
              begin
                AL_hour <= 4'b0000;
                AL_hour10 <= 1'b0;
              end
	end
	end
        end
      else if(S_STATE2 == 3'b011)
        begin
          AL_minute10 <= AL_minute10 + 3'b001;
          if(AL_minute10 == 3'b101)	// 5x min >> 0x min
              begin
                AL_minute10 <= 3'b000;
                AL_hour <= AL_hour + 4'b0001;              
            if(AL_hour == 4'b1001)	//9hour >> 10hour
              begin
                AL_hour <= 4'b0000;
                AL_hour10 <= AL_hour10 + 1'b1;
              end
          else if(AL_hour10 == 1'b1 && AL_hour == 4'b0001)  //11hour >> 0
              begin
                AL_hour <= 4'b0000;
                AL_hour10 <= 1'b0;
              end
	end
        end
      else if(S_STATE2 == 3'b100)
        begin
          AL_hour <= AL_hour + 4'b0001;
          if(AL_hour == 4'b1001)	//9hour >> 10hour
              begin
                AL_hour <= 4'b0000;
                AL_hour10 <= AL_hour10 + 1'b1;
              end
          else if(AL_hour10 == 1'b1 && AL_hour == 4'b0001)  //11hour >> 0
              begin
                AL_hour <= 4'b0000;
                AL_hour10 <= 1'b0;
              end
        end
      else if(S_STATE2 == 3'b101)
        begin
          AL_hour10 <= AL_hour10 + 1'b1;
        end
    end
end

always @(posedge switch[3])	//switch input button '4' = 1
begin
  Alarm_switch <= Alarm_switch + 1'b1;
end

always @(*)
begin
  if(Alarm_switch == 1'b1)
    begin 
      if(19'h0 <= present_time[18:0] - AL_time[18:0] && present_time[18:0] - AL_time[18:0] < 19'h10)
	begin
	  Alarm_on <= 1'b1;
	end
      else
	begin
	  Alarm_on <= 1'b0;
	end
    end
end


endmodule
