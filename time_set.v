module time_set(
input wire [1:0] STATE,
input wire [3:0] switch,
output [18:0] timeset,
output [2:0] set_state	//time set cursor
);


reg[3:0] SET_sec = 4'b0000;
reg[2:0] SET_second10 = 3'b000;
reg[3:0] SET_min = 4'b0000;
reg[2:0] SET_minute10 = 3'b000;
reg[3:0] SET_hour = 4'b0000;
reg  SET_hour10 = 1'b0;
reg[2:0]  S_STATE = 3'b000;
assign timeset[3:0] = SET_sec[3:0];
assign timeset[6:4] = SET_second10[2:0];
assign timeset[10:7] = SET_min[3:0];
assign timeset[13:11] = SET_minute10[2:0];
assign timeset[17:14] = SET_hour[3:0];
assign timeset[18] = SET_hour10;
assign set_state[2:0] = S_STATE[2:0];
//time setting mode
always @ (posedge switch[1])	// switch input button '2' = 1
begin
  if(STATE [1:0] == 2'b01)
    begin
      S_STATE [2:0] <= S_STATE [2:0] + 3'b001;
      if(S_STATE [2:0] == 3'b110)
        begin
          S_STATE [2:0] <= 3'b000;
        end
    end
end

always @ (posedge switch[2])	//switch input button '3' = 1
  begin
    if(STATE [1:0] == 2'b01)
      begin
        if(S_STATE == 3'b000)
          begin
            SET_sec <= SET_sec + 4'b0001;
            if(SET_sec == 4'b1001)    //9sec>>10sec
               begin
                 SET_sec <= 4'b0000;
                 SET_second10 <= SET_second10 + 3'b001;          
            if(SET_second10 == 3'b101 && SET_sec == 4'b1001)	//59sec >> 1min
              begin
                SET_second10 <= 3'b000;
                SET_min <= SET_min + 4'b0001;             
            if(SET_min == 4'b1001)	//9min>>10min
              begin
                SET_min <= 4'b0000;
                SET_minute10 <= SET_minute10 + 3'b001;              
            if(SET_minute10 == 3'b101 && SET_min == 4'b1001)	//59min >> 1hour
              begin
                SET_minute10 <= 3'b000;
                SET_hour <= SET_hour + 4'b0001;              
            if(SET_hour == 4'b1001)	//9hour>> 10hour
              begin
                SET_hour <= 4'b0000;
                SET_hour10 <= SET_hour10 + 1'b1;
              end
          else if(SET_hour10 == 1'b1 && SET_hour == 4'b0001)  //11hour>> 0hour
              begin
                SET_hour <= 4'b0000;
                SET_hour10 <= 1'b0;
              end
	   end
	   end
	   end
	   end
       end
       
      else if(S_STATE == 3'b001)
        begin
          SET_second10 <= SET_second10 + 3'b001;
            if(SET_second10 == 3'b101)
              begin
                SET_second10 <= 3'b000;
                SET_min <= SET_min + 4'b0001;
              if(SET_min == 4'b1001)	//9min >> 10min
              begin
                SET_min <= 4'b0000;
                SET_minute10 <= SET_minute10 + 3'b001;              
              if(SET_minute10 == 3'b101 && SET_min == 4'b1001)	//59min >> 1hour
              begin
                SET_minute10 <= 3'b000;
                SET_hour <= SET_hour + 4'b0001;             
              if(SET_hour == 4'b1001)
              begin
                SET_hour <= 4'b0000;
                SET_hour10 <= SET_hour10 + 1'b1;
              end
             else if(SET_hour10 == 1'b1 && SET_hour == 4'b0001)  //11hour >> 0
              begin
                SET_hour <= 4'b0000;
                SET_hour10 <= 1'b0;
              end
	   end
	   end
	   end
        end
      else if(S_STATE == 3'b010)
        begin
          SET_min <= SET_min + 4'b0001;
            if(SET_min == 4'b1001)	//9min >> 10min
              begin
                SET_min <= 4'b0000;
                SET_minute10 <= SET_minute10 + 3'b001;             
            if(SET_minute10 == 3'b101 && SET_min == 4'b1001)	//59min >> 1hour
              begin
                SET_minute10 <= 3'b000;
                SET_hour <= SET_hour + 4'b0001;       
            if(SET_hour == 4'b1001)	//9hour >> 10hour
              begin
                SET_hour <= 4'b0000;
                SET_hour10 <= SET_hour10 + 1'b1;
              end
          else if(SET_hour10 == 1'b1 && SET_hour == 4'b0001)  //11hour >> 0
              begin
                SET_hour <= 4'b0000;
                SET_hour10 <= 1'b0;
              end
	end
	end
        end
      else if(S_STATE == 3'b011)
        begin
          SET_minute10 <= SET_minute10 + 3'b001;
          if(SET_minute10 == 3'b101)	//5x min >> 0xmin
              begin
                SET_minute10 <= 3'b000;
                SET_hour <= SET_hour + 4'b0001;              
            if(SET_hour == 4'b1001)	//9hour >> 10hour
              begin
                SET_hour <= 4'b0000;
                SET_hour10 <= SET_hour10 + 1'b1;
              end
          else if(SET_hour10 == 1'b1 && SET_hour == 4'b0001)  //11hour >> 0
              begin
                SET_hour <= 4'b0000;
                SET_hour10 <= 1'b0;
              end
	end
        end
      else if(S_STATE == 3'b100)
        begin
          SET_hour <= SET_hour + 4'b0001;
          if(SET_hour == 4'b1001)	//9hour >> 10hour
              begin
                SET_hour <= 4'b0000;
                SET_hour10 <= SET_hour10 + 1'b1;
              end
          else if(SET_hour10 == 1'b1 && SET_hour == 4'b0001)  //11hour >> 0
              begin
                SET_hour <= 4'b0000;
                SET_hour10 <= 1'b0;
              end
        end
      else if(S_STATE == 3'b101)
        begin
          SET_hour10 <= SET_hour10 + 1'b1;
        end
   end
end
endmodule