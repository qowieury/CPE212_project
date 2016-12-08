module main (mled_left, mled_right, mled_equal, mbcd_segment, min_hex_joy);

//Not finished @091259 0130
  output [4:0]mled_left,mled_right;
  output mled_equal;
  output [2:0]mbcd_segment;
  input [7:0]min_hex_joy;

  wire [4:0]wbcd_left, wbcd_right, wbcd_segment;
  wire wtog_equal;
  wire [2:0]wstate;
  wire wtrigger;


  //starting state with zero
  click_count_up cup(wstate, wtrigger);

  //initial question
  //module question_inti (bcd_left, bcd_right, tog_equal, bcd_segment, ans, state);
  question_inti q1(wbcd_left, wbcd_right, wtog_equal, wbcd_segment, wans, wstate);

  //Show question in display
  //module question_show (led_left, led_right, led_equal, bcd_segment, in_left, in_right, in_equal, in_segment);
  question_show qs1(mled_left, mled_right, mled_equal, mbcd_segment, wbcd_left, wbcd_right, wtog_equal, wbcd_segment);

  //LocalMethod: wait player press buttom
  //module get_player_score(ret_score_p1, ret_score_p2, rm_in_bcd, prob);
  get_player_score gps1(ret_score_p1, ret_score_p2, rm_in_bcd, prob);

  //LocalMethod: change state
  //module change_problem_logic(is_active, score_p1, score_p2);
  change_problem_logic ch1(wtrigger, score_p1, score_p2);
endmodule // main
