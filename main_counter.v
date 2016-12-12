module question_inti (bcd_left, bcd_right, tog_equal, bcd_segment, bcd_ans, bcd_state);
  output [3:0]bcd_left, bcd_right;
  output [3:0]bcd_segment, bcd_ans;
  output tog_equal;
  input [3:0]bcd_state;

  reg [3:0]bcd_left, bcd_right;
  reg [3:0]bcd_segment, bcd_ans;
  reg tog_equal;


  always @ (bcd_state) begin
    if (bcd_state == 0) begin
      bcd_left <= 1;
      bcd_right <= 1;
      tog_equal <= 0;
      bcd_segment <= 1;
      bcd_ans <= 1;
    end
    else if (bcd_state == 1) begin
      bcd_left <= 2;
      bcd_right <= 2;
      tog_equal <= 1;
      bcd_segment <= 2;
      bcd_ans <= 2;
    end
    else if (bcd_state == 2) begin
      bcd_left <= 3;
      bcd_right <= 3;
      tog_equal <= 0;
      bcd_segment <= 3;
      bcd_ans <= 3;
    end
    else if (bcd_state == 3) begin
      bcd_left <= 4;
      bcd_right <= 4;
      tog_equal <= 1;
      bcd_segment <= 4;
      bcd_ans <= 4;
    end
    else if (bcd_state == 4) begin
      bcd_left <= 5;
      bcd_right <= 5;
      tog_equal <= 0;
      bcd_segment <= 5;
      bcd_ans <= 3;
    end
    else if (bcd_state == 5) begin
      bcd_left <= 4;
      bcd_right <= 4;
      tog_equal <= 1;
      bcd_segment <= 4;
      bcd_ans <= 2;
    end
    else if (bcd_state == 6) begin
      bcd_left <= 3;
      bcd_right <= 3;
      tog_equal <= 0;
      bcd_segment <= 3;
      bcd_ans <= 1;
    end
    else if (bcd_state == 7) begin
      bcd_left <= 2;
      bcd_right <= 2;
      tog_equal <= 1;
      bcd_segment <= 2;
      bcd_ans <= 2;
    end
    else if (bcd_state == 8) begin
      bcd_left <= 1;
      bcd_right <= 1;
      tog_equal <= 0;
      bcd_segment <= 1;
      bcd_ans <= 3;
    end
    else if (bcd_state == 9) begin
      bcd_left <= 1;
      bcd_right <= 1;
      tog_equal <= 1;
      bcd_segment <= 0;
      bcd_ans <= 4;
    end
    else begin
      bcd_left <= 10;
      bcd_right <= 10;
      tog_equal <= 10;
      bcd_segment <= 0;
      bcd_ans <= 10;
    end
  end
endmodule // question_inti

module question_show (toggle_beep, led_left, led_right, led_equal, bcd_segment, in_left, in_right, in_equal, in_segment);
/*
  low-level module to show 5 digits led-problem and equal and segment
  @input [bcd]data and [active hight]in_equal
  @output [active hight]all led
  @delay xxx ns
  @
*/
  output [4:0]led_left, led_right;
  output [3:0]bcd_segment;
  output led_equal, toggle_beep;
  input [3:0]in_left, in_right, in_segment;
  input in_equal;

  reg [4:0]led_left, led_right;
  reg [3:0]bcd_segment;
  reg led_equal, toggle_beep;

  always @ (1)
  begin
    if (in_left >= 6 || in_right >= 6)
      begin
        toggle_beep = 1;
      end
    else
      begin
        toggle_beep = 0;
        case (in_left)
          0: led_left <= 5'b00000;
          1: led_left <= 5'b00001;
          2: led_left <= 5'b00011;
          3: led_left <= 5'b00111;
          4: led_left <= 5'b01111;
          5: led_left <= 5'b11111;
          10: led_left <= 5'b10101; //State test
          default: led_left <= 5'b01010;
        endcase
        case (in_right)
          0: led_right <= 5'b00000;
          1: led_right <= 5'b00001;
          2: led_right <= 5'b00011;
          3: led_right <= 5'b00111;
          4: led_right <= 5'b01111;
          5: led_right <= 5'b11111;
          10: led_right <= 5'b10101; //State test
          default: led_right <= 5'b01010;
        endcase
    end
  end

  always @ (1) begin
    bcd_segment <= in_segment;
    led_equal <= in_equal;
  end

endmodule // question_show

module score_count_show (led_player, trigger);
/*
  low-level module to show 5 digits led-score
  @output [5bit][active hight] led array
  @input trigger
  @design this function for Right-hand player if you want
    to use LH player you should invert-side of LED ex
    12345 -> 54321 it's eazy ways
  @delay 7.2ns [091259 0011]
*/
  input trigger;
  output [4:0]led_player;
  reg [4:0]led_player;
  wire [3:0]bcd;

  //counter module
  click_count_up clk_led_p1(bcd, trigger);

  //Working always
  always @ (1) begin
    case (bcd)
      0: led_player <= 5'b00000;
      1: led_player <= 5'b00001;
      2: led_player <= 5'b00011;
      3: led_player <= 5'b00111;
      4: led_player <= 5'b01111;
      5: led_player <= 5'b11111;
      default: led_player <= 5'b00000;
    endcase
  end
endmodule

module click_count_up(bcd, trigger);
  output [3:0]bcd;
  input trigger;
  reg [3:0]bcd;

  initial begin
    bcd <= 0;
  end

  always @ ( posedge trigger ) begin
    case (bcd)
      0: bcd <= 1;
      1: bcd <= 2;
      2: bcd <= 3;
      3: bcd <= 4;
      4: bcd <= 5;
      5: bcd <= 6;
      6: bcd <= 7;
      7: bcd <= 8;
      8: bcd <= 9;
      default: bcd <= 0;
    endcase
  end
endmodule
