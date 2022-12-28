module seg7dec (

input clk,  // 2hz
input wire[18:0] timeset,
input wire[18:0] AL_time,
input wire[18:0] present_time,
input wire[2:0] S_STATE,
input wire[2:0] S_STATE2,
input wire[1:0] state,

output reg [0:6] SEG1, // hour10
output reg [0:6] SEG2, // hour
output reg [0:6] SEG3, // minute10
output reg [0:6] SEG4, // minute
output reg [0:6] SEG5, // second10
output reg [0:6] SEG6  // sec
);

always @(*)
begin

if (state[1:0] == 2'b01) begin // timeset mode

 case (timeset[18]) // hour10
 0: SEG1[0:6] = 7'b011_1111;
 1: SEG1[0:6] = 7'b000_0110;
 endcase

 case (timeset[17:14]) // hour
 4'h0: SEG2[0:6] = 7'b011_1111;
 4'h1: SEG2[0:6] = 7'b000_0110;
 4'h2: SEG2[0:6] = 7'b101_1011;
 4'h3: SEG2[0:6] = 7'b100_1111;
 4'h4: SEG2[0:6] = 7'b110_0110;
 4'h5: SEG2[0:6] = 7'b110_1101;
 4'h6: SEG2[0:6] = 7'b111_1101;
 4'h7: SEG2[0:6] = 7'b000_0111;
 4'h8: SEG2[0:6] = 7'b111_1111;
 4'h9: SEG2[0:6] = 7'b110_1111;
endcase

case (timeset[13:11]) // minute10
 4'h0: SEG3[0:6] = 7'b011_1111;
 4'h1: SEG3[0:6] = 7'b000_0110;
 4'h2: SEG3[0:6] = 7'b101_1011;
 4'h3: SEG3[0:6] = 7'b100_1111;
 4'h4: SEG3[0:6] = 7'b110_0110;
 4'h5: SEG3[0:6] = 7'b110_1101;
endcase

case (timeset[10:7]) // minute
 4'h0: SEG4[0:6] = 7'b011_1111;
 4'h1: SEG4[0:6] = 7'b000_0110;
 4'h2: SEG4[0:6] = 7'b101_1011;
 4'h3: SEG4[0:6] = 7'b100_1111;
 4'h4: SEG4[0:6] = 7'b110_0110;
 4'h5: SEG4[0:6] = 7'b110_1101;
 4'h6: SEG4[0:6] = 7'b111_1101;
 4'h7: SEG4[0:6] = 7'b000_0111;
 4'h8: SEG4[0:6] = 7'b111_1111;
 4'h9: SEG4[0:6] = 7'b110_1111;
endcase

case (timeset[6:4]) // second10
 4'h0: SEG5[0:6] = 7'b011_1111;
 4'h1: SEG5[0:6] = 7'b000_0110;
 4'h2: SEG5[0:6] = 7'b101_1011;
 4'h3: SEG5[0:6] = 7'b100_1111;
 4'h4: SEG5[0:6] = 7'b110_0110;
 4'h5: SEG5[0:6] = 7'b110_1101;
endcase

case (timeset[3:0]) // sec
 4'h0: SEG6[0:6] = 7'b011_1111;
 4'h1: SEG6[0:6] = 7'b000_0110;
 4'h2: SEG6[0:6] = 7'b101_1011;
 4'h3: SEG6[0:6] = 7'b100_1111;
 4'h4: SEG6[0:6] = 7'b110_0110;
 4'h5: SEG6[0:6] = 7'b110_1101;
 4'h6: SEG6[0:6] = 7'b111_1101;
 4'h7: SEG6[0:6] = 7'b000_0111;
 4'h8: SEG6[0:6] = 7'b111_1111;
 4'h9: SEG6[0:6] = 7'b110_1111;
endcase


// slected segment flash code (0.5sec) (timeset)
if (S_STATE[2:0] == 3'b101 && clk == 1) begin
 case (timeset[18]) // hour10
 0: SEG1[0:6] = 7'b011_1111;
 1: SEG1[0:6] = 7'b000_0110;
 endcase
end

else if (S_STATE[2:0] == 3'b101 && clk == 0) begin
  SEG1[0:6] = 7'b000_0000;
end

if (S_STATE[2:0] == 3'b100 && clk == 1) begin
 case (timeset[17:14]) // hour
 4'h0: SEG2[0:6] = 7'b011_1111;
 4'h1: SEG2[0:6] = 7'b000_0110;
 4'h2: SEG2[0:6] = 7'b101_1011;
 4'h3: SEG2[0:6] = 7'b100_1111;
 4'h4: SEG2[0:6] = 7'b110_0110;
 4'h5: SEG2[0:6] = 7'b110_1101;
 4'h6: SEG2[0:6] = 7'b111_1101;
 4'h7: SEG2[0:6] = 7'b000_0111;
 4'h8: SEG2[0:6] = 7'b111_1111;
 4'h9: SEG2[0:6] = 7'b110_1111;
endcase
end

else if (S_STATE[2:0] == 3'b100 && clk == 0) begin
  SEG2[0:6] = 7'b000_0000;
end

if (S_STATE[2:0] == 3'b011 && clk == 1) begin
 case (timeset[13:11]) // minute10
 4'h0: SEG3[0:6] = 7'b011_1111;
 4'h1: SEG3[0:6] = 7'b000_0110;
 4'h2: SEG3[0:6] = 7'b101_1011;
 4'h3: SEG3[0:6] = 7'b100_1111;
 4'h4: SEG3[0:6] = 7'b110_0110;
 4'h5: SEG3[0:6] = 7'b110_1101;
 endcase
end

else if (S_STATE[2:0] == 3'b011 && clk == 0) begin
  SEG3[0:6] = 7'b000_0000;
end

if (S_STATE[2:0] == 3'b010 && clk == 1) begin
case (timeset[10:7]) // minute
 4'h0: SEG4[0:6] = 7'b011_1111;
 4'h1: SEG4[0:6] = 7'b000_0110;
 4'h2: SEG4[0:6] = 7'b101_1011;
 4'h3: SEG4[0:6] = 7'b100_1111;
 4'h4: SEG4[0:6] = 7'b110_0110;
 4'h5: SEG4[0:6] = 7'b110_1101;
 4'h6: SEG4[0:6] = 7'b111_1101;
 4'h7: SEG4[0:6] = 7'b000_0111;
 4'h8: SEG4[0:6] = 7'b111_1111;
 4'h9: SEG4[0:6] = 7'b110_1111;
endcase
end

else if (S_STATE[2:0] == 3'b010 && clk == 0) begin
  SEG4[0:6] = 7'b000_0000;
end

if (S_STATE[2:0] == 3'b001 && clk == 1) begin
case (timeset[6:4]) // second10
 4'h0: SEG5[0:6] = 7'b011_1111;
 4'h1: SEG5[0:6] = 7'b000_0110;
 4'h2: SEG5[0:6] = 7'b101_1011;
 4'h3: SEG5[0:6] = 7'b100_1111;
 4'h4: SEG5[0:6] = 7'b110_0110;
 4'h5: SEG5[0:6] = 7'b110_1101;
endcase
end

else if (S_STATE[2:0] == 3'b001 && clk == 0) begin
  SEG5[0:6] = 7'b000_0000;
end

if (S_STATE[2:0] == 3'b000 && clk == 1) begin
case (timeset[3:0]) // sec
 4'h0: SEG6[0:6] = 7'b011_1111;
 4'h1: SEG6[0:6] = 7'b000_0110;
 4'h2: SEG6[0:6] = 7'b101_1011;
 4'h3: SEG6[0:6] = 7'b100_1111;
 4'h4: SEG6[0:6] = 7'b110_0110;
 4'h5: SEG6[0:6] = 7'b110_1101;
 4'h6: SEG6[0:6] = 7'b111_1101;
 4'h7: SEG6[0:6] = 7'b000_0111;
 4'h8: SEG6[0:6] = 7'b111_1111;
 4'h9: SEG6[0:6] = 7'b110_1111;
endcase
end

else if (S_STATE[2:0] == 3'b000 && clk == 0) begin
  SEG6[0:6] = 7'b000_0000;
end

end


// AL_time
if (state[1:0] == 2'b10) begin

case (AL_time[18]) // hour10
 4'h0: SEG1[0:6] = 7'b011_1111;
 4'h1: SEG1[0:6] = 7'b000_0110;
endcase

case (AL_time[17:14]) // hour
 4'h0: SEG2[0:6] = 7'b011_1111;
 4'h1: SEG2[0:6] = 7'b000_0110;
 4'h2: SEG2[0:6] = 7'b101_1011;
 4'h3: SEG2[0:6] = 7'b100_1111;
 4'h4: SEG2[0:6] = 7'b110_0110;
 4'h5: SEG2[0:6] = 7'b110_1101;
 4'h6: SEG2[0:6] = 7'b111_1101;
 4'h7: SEG2[0:6] = 7'b000_0111;
 4'h8: SEG2[0:6] = 7'b111_1111;
 4'h9: SEG2[0:6] = 7'b110_1111;
endcase

case (AL_time[13:11]) // minute10
 4'h0: SEG3[0:6] = 7'b011_1111;
 4'h1: SEG3[0:6] = 7'b000_0110;
 4'h2: SEG3[0:6] = 7'b101_1011;
 4'h3: SEG3[0:6] = 7'b100_1111;
 4'h4: SEG3[0:6] = 7'b110_0110;
 4'h5: SEG3[0:6] = 7'b110_1101;
endcase

case (AL_time[10:7]) // minute
 4'h0: SEG4[0:6] = 7'b011_1111;
 4'h1: SEG4[0:6] = 7'b000_0110;
 4'h2: SEG4[0:6] = 7'b101_1011;
 4'h3: SEG4[0:6] = 7'b100_1111;
 4'h4: SEG4[0:6] = 7'b110_0110;
 4'h5: SEG4[0:6] = 7'b110_1101;
 4'h6: SEG4[0:6] = 7'b111_1101;
 4'h7: SEG4[0:6] = 7'b000_0111;
 4'h8: SEG4[0:6] = 7'b111_1111;
 4'h9: SEG4[0:6] = 7'b110_1111;
endcase

case (AL_time[6:4]) // second10
 4'h0: SEG5[0:6] = 7'b011_1111;
 4'h1: SEG5[0:6] = 7'b000_0110;
 4'h2: SEG5[0:6] = 7'b101_1011;
 4'h3: SEG5[0:6] = 7'b100_1111;
 4'h4: SEG5[0:6] = 7'b110_0110;
 4'h5: SEG5[0:6] = 7'b110_1101;
endcase

case (AL_time[3:0]) // sec
 4'h0: SEG6[0:6] = 7'b011_1111;
 4'h1: SEG6[0:6] = 7'b000_0110;
 4'h2: SEG6[0:6] = 7'b101_1011;
 4'h3: SEG6[0:6] = 7'b100_1111;
 4'h4: SEG6[0:6] = 7'b110_0110;
 4'h5: SEG6[0:6] = 7'b110_1101;
 4'h6: SEG6[0:6] = 7'b111_1101;
 4'h7: SEG6[0:6] = 7'b000_0111;
 4'h8: SEG6[0:6] = 7'b111_1111;
 4'h9: SEG6[0:6] = 7'b110_1111;
endcase


// slected segment flash code (0.5sec) (AL_time)
if (S_STATE2[2:0] == 3'b101 && clk == 1) begin
 case (AL_time[18]) // hour10
 0: SEG1[0:6] = 7'b011_1111;
 1: SEG1[0:6] = 7'b000_0110;
 endcase
end

else if (S_STATE2[2:0] == 3'b101 && clk == 0) begin
  SEG1[0:6] = 7'b000_0000;
end

if (S_STATE2[2:0] == 3'b100 && clk == 1) begin
 case (AL_time[17:14]) // hour
 4'h0: SEG2[0:6] = 7'b011_1111;
 4'h1: SEG2[0:6] = 7'b000_0110;
 4'h2: SEG2[0:6] = 7'b101_1011;
 4'h3: SEG2[0:6] = 7'b100_1111;
 4'h4: SEG2[0:6] = 7'b110_0110;
 4'h5: SEG2[0:6] = 7'b110_1101;
 4'h6: SEG2[0:6] = 7'b111_1101;
 4'h7: SEG2[0:6] = 7'b000_0111;
 4'h8: SEG2[0:6] = 7'b111_1111;
 4'h9: SEG2[0:6] = 7'b110_1111;
endcase
end

else if (S_STATE2[2:0] == 3'b100 && clk == 0) begin
  SEG2[0:6] = 7'b000_0000;
end

if (S_STATE2[2:0] == 3'b011 && clk == 1) begin
 case (AL_time[13:11]) // minute10
 4'h0: SEG3[0:6] = 7'b011_1111;
 4'h1: SEG3[0:6] = 7'b000_0110;
 4'h2: SEG3[0:6] = 7'b101_1011;
 4'h3: SEG3[0:6] = 7'b100_1111;
 4'h4: SEG3[0:6] = 7'b110_0110;
 4'h5: SEG3[0:6] = 7'b110_1101;
 endcase
end

else if (S_STATE2[2:0] == 3'b011 && clk == 0) begin
  SEG3[0:6] = 7'b000_0000;
end

if (S_STATE2[2:0] == 3'b010 && clk == 1) begin
case (AL_time[10:7]) // minute
 4'h0: SEG4[0:6] = 7'b011_1111;
 4'h1: SEG4[0:6] = 7'b000_0110;
 4'h2: SEG4[0:6] = 7'b101_1011;
 4'h3: SEG4[0:6] = 7'b100_1111;
 4'h4: SEG4[0:6] = 7'b110_0110;
 4'h5: SEG4[0:6] = 7'b110_1101;
 4'h6: SEG4[0:6] = 7'b111_1101;
 4'h7: SEG4[0:6] = 7'b000_0111;
 4'h8: SEG4[0:6] = 7'b111_1111;
 4'h9: SEG4[0:6] = 7'b110_1111;
endcase
end

else if (S_STATE2[2:0] == 3'b010 && clk == 0) begin
  SEG4[0:6] = 7'b000_0000;
end

if (S_STATE2[2:0] == 3'b001 && clk == 1) begin
case (AL_time[6:4]) // second10
 4'h0: SEG5[0:6] = 7'b011_1111;
 4'h1: SEG5[0:6] = 7'b000_0110;
 4'h2: SEG5[0:6] = 7'b101_1011;
 4'h3: SEG5[0:6] = 7'b100_1111;
 4'h4: SEG5[0:6] = 7'b110_0110;
 4'h5: SEG5[0:6] = 7'b110_1101;
endcase
end

else if (S_STATE2[2:0] == 3'b001 && clk == 0) begin
  SEG5[0:6] = 7'b000_0000;
end

if (S_STATE2[2:0] == 3'b000 && clk == 1) begin
case (AL_time[3:0]) // sec
 4'h0: SEG6[0:6] = 7'b011_1111;
 4'h1: SEG6[0:6] = 7'b000_0110;
 4'h2: SEG6[0:6] = 7'b101_1011;
 4'h3: SEG6[0:6] = 7'b100_1111;
 4'h4: SEG6[0:6] = 7'b110_0110;
 4'h5: SEG6[0:6] = 7'b110_1101;
 4'h6: SEG6[0:6] = 7'b111_1101;
 4'h7: SEG6[0:6] = 7'b000_0111;
 4'h8: SEG6[0:6] = 7'b111_1111;
 4'h9: SEG6[0:6] = 7'b110_1111;
endcase
end

else if (S_STATE2[2:0] == 3'b000 && clk == 0) begin
  SEG6[0:6] = 7'b000_0000;
end

end





// present time
if (state[1:0] == 2'b00) begin

case (present_time[18]) // hour10
 0: SEG1[0:6] = 7'b011_1111;
 1: SEG1[0:6] = 7'b000_0110;
endcase

case (present_time[17:14]) // hour
 4'h0: SEG2[0:6] = 7'b011_1111;
 4'h1: SEG2[0:6] = 7'b000_0110;
 4'h2: SEG2[0:6] = 7'b101_1011;
 4'h3: SEG2[0:6] = 7'b100_1111;
 4'h4: SEG2[0:6] = 7'b110_0110;
 4'h5: SEG2[0:6] = 7'b110_1101;
 4'h6: SEG2[0:6] = 7'b111_1101;
 4'h7: SEG2[0:6] = 7'b000_0111;
 4'h8: SEG2[0:6] = 7'b111_1111;
 4'h9: SEG2[0:6] = 7'b110_1111;
endcase

case (present_time[13:11]) // minute10
 4'h0: SEG3[0:6] = 7'b011_1111;
 4'h1: SEG3[0:6] = 7'b000_0110;
 4'h2: SEG3[0:6] = 7'b101_1011;
 4'h3: SEG3[0:6] = 7'b100_1111;
 4'h4: SEG3[0:6] = 7'b110_0110;
 4'h5: SEG3[0:6] = 7'b110_1101;
endcase

case (present_time[10:7]) // minute
 4'h0: SEG4[0:6] = 7'b011_1111;
 4'h1: SEG4[0:6] = 7'b000_0110;
 4'h2: SEG4[0:6] = 7'b101_1011;
 4'h3: SEG4[0:6] = 7'b100_1111;
 4'h4: SEG4[0:6] = 7'b110_0110;
 4'h5: SEG4[0:6] = 7'b110_1101;
 4'h6: SEG4[0:6] = 7'b111_1101;
 4'h7: SEG4[0:6] = 7'b000_0111;
 4'h8: SEG4[0:6] = 7'b111_1111;
 4'h9: SEG4[0:6] = 7'b110_1111;
endcase

case (present_time[6:4]) // second10
 4'h0: SEG5[0:6] = 7'b011_1111;
 4'h1: SEG5[0:6] = 7'b000_0110;
 4'h2: SEG5[0:6] = 7'b101_1011;
 4'h3: SEG5[0:6] = 7'b100_1111;
 4'h4: SEG5[0:6] = 7'b110_0110;
 4'h5: SEG5[0:6] = 7'b110_1101;
endcase

case (present_time[3:0]) // sec
 4'h0: SEG6[0:6] = 7'b011_1111;
 4'h1: SEG6[0:6] = 7'b000_0110;
 4'h2: SEG6[0:6] = 7'b101_1011;
 4'h3: SEG6[0:6] = 7'b100_1111;
 4'h4: SEG6[0:6] = 7'b110_0110;
 4'h5: SEG6[0:6] = 7'b110_1101;
 4'h6: SEG6[0:6] = 7'b111_1101;
 4'h7: SEG6[0:6] = 7'b000_0111;
 4'h8: SEG6[0:6] = 7'b111_1111;
 4'h9: SEG6[0:6] = 7'b110_1111;
endcase

end

end

endmodule
