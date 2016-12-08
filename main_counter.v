module question_inti (bcd_left, bcd_right, tog_equal, bcd_segment, ans, state);
  output [2:0]bcd_left, bcd_right, bcd_segment, ans;
  output tog_equal;
  input [2:0]state;

  reg [2:0]bcd_left, bcd_right, bcd_segment, ans;
  reg tog_equal;


  always @ (1) begin
    case (state)
      0:
        begin
          bcd_left = 1;
          bcd_right = 1;
          tog_equal = 0;
          bcd_segment = 0;
          ans = 1;
        end
      1:
        begin
          bcd_left = 2;
          bcd_right = 2;
          tog_equal = 0;
          bcd_segment = 3;
          ans = 2;
        end
      2:
        begin
          bcd_left = 3;
          bcd_right = 3;
          tog_equal = 0;
          bcd_segment = 3;
          ans = 3;
        end
      3:
        begin
          bcd_left = 4;
          bcd_right = 4;
          tog_equal = 0;
          bcd_segment = 4;
          ans = 4;
        end
      4:
        begin
          bcd_left = 5;
          bcd_right = 5;
          tog_equal = 0;
          bcd_segment = 5;
          ans = 1;
        end
      5:
        begin
          bcd_left = 1;
          bcd_right = 1;
          tog_equal = 0;
          bcd_segment = 1;
          ans = 2;
        end

      default:
        begin
          bcd_left <= 0;
          bcd_right <= 0;
          tog_ans = 0;
          bcd_segment = 0;
          ans = 1;
        end
    endcase
  end
endmodule // question_inti

module question_show (led_left, led_right, led_equal, bcd_segment, in_left, in_right, in_equal, in_segment);
/*
  low-level module to show 5 digits led-problem and equal and segment
  @input [bcd]data and [active hight]in_equal
  @output [active hight]all led
  @delay xxx ns
  @
*/
  output [4:0]led_left, led_right;
  output [2:0]bcd_segment;
  output led_equal;
  input [2:0]in_left, in_right, in_segment;
  input in_equal;

  reg [4:0]led_left, led_right;
  reg [2:0]bcd_segment;
  reg led_equal;

  always @ ( 1 ) begin
    case (in_left)
      0: led_left <= 5'b00000;
      1: led_left <= 5'b00001;
      2: led_left <= 5'b00011;
      3: led_left <= 5'b00111;
      4: led_left <= 5'b01111;
      5: led_left <= 5'b11111;
      default: led_left <= 5'b00000;
    endcase

    case (in_right)
      0: led_right <= 5'b00000;
      1: led_right <= 5'b00001;
      2: led_right <= 5'b00011;
      3: led_right <= 5'b00111;
      4: led_right <= 5'b01111;
      5: led_right <= 5'b11111;
      default: led_right <= 5'b00000;
    endcase

    bcd_segment <= in_segment;
    led_equal <= in_equal;
  end

endmodule // question_show

module score_show (led_player, trigger);
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
  wire [2:0]bcd;

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
  output [2:0]bcd;
  input trigger;
  reg [2:0]bcd;

  initial begin
    bcd <= 0;
  end

  always @ ( negedge trigger ) begin
    if(bcd >= 7)
      bcd <= 0;
    else
      bcd <= bcd+1;
  end
endmodule
