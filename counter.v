module counter(

input wire clk, // 1hz

input wire[18:0] timeset,
input wire [1:0] state,


output [18:0] present_time
);
//setting initial value
reg[3:0] sec = 4'b0000;
reg[2:0] second10 = 3'b000;
reg[3:0] minute = 4'b0000;
reg[2:0] minute10 = 3'b000;
reg[3:0] hour = 4'b0000;
reg hour10 = 1'b0;

assign present_time[18]    = hour10;
assign present_time[17:14] = hour[3:0];
assign present_time[13:11] = minute10[2:0];
assign present_time[10:7]  = minute[3:0];
assign present_time[6:4]   = second10[2:0];
assign present_time[3:0]   = sec[3:0];



always@(posedge clk)
begin
// time setting from state machine
if(state[1:0] == 2'b01) begin 
hour10        <= timeset[18];
hour[3:0]     <= timeset[17:14];
minute10[2:0] <= timeset[13:11];
minute[3:0]   <= timeset[10:7];
second10[2:0] <= timeset[6:4];
sec[3:0]      <= timeset[3:0];
end

else begin
if(state[1:0] == 2'b00) begin

sec <= sec + 4'b0001;

if (sec == 4'b1001) begin // 00:00:09
sec      <= 4'b0000;
second10 <= second10 + 3'b001;
end

if (second10 == 3'b101 && sec == 4'b1001) begin // 00:00:59
second10 <= 3'b000;
minute   <= minute + 4'b0001;
end

if (minute == 4'b1001 && second10 == 3'b101 && sec == 4'b1001) begin // 00:09:59
minute   <= 4'b0000;
minute10 <= minute10 + 3'b001;
end

if (minute10 == 3'b101 && minute == 4'b1001 && second10 == 3'b101 && sec == 4'b1001) begin // 00:59:59
minute10 <= 3'b000;
hour     <= hour + 4'b0001;
end

if (hour == 4'b1001 && minute10 == 3'b101 && minute == 4'b1001 && second10 == 3'b101 && sec == 4'b1001) begin // 09:59:59
hour     <= 4'b0000;
hour10   <= hour10 + 1'b1;
end

if (hour10==1'b1 && hour == 4'b0001 && minute10 == 3'b101 && minute == 4'b1001 && second10 == 3'b101 && sec == 4'b1001) begin // 11:59:59
sec      <= 4'b0000;
second10 <= 3'b000;
minute   <= 4'b0000;
minute10 <= 3'b000;
hour     <= 4'b0000;
hour10   <= 1'b0;
end

end

end

end

endmodule


