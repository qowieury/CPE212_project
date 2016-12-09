module change_problem_logic(is_active, score_p1, score_p2);
/*
  low-level module for compair 2 player score for send toggle data next problem
  @output [1-bit] 1 if one of person have corrcet answer
  @input [1bit][active hight] one score of perple or both
*/
  output is_active;
  input score_p1, score_p2;
  or(is_active, score_p1, score_p2);
endmodule

module get_player_score(ret_score_p1, ret_score_p2, rm_in_bcd, prob);
/*
  check player answer with problem answer and get who player give score
  @output [active hight] 1-bit score_player1 OR score_player2
  @input [bcd] remote_raw_bcd , problem_bcd_answer
*/
  output ret_score_p1;
  output ret_score_p2;
  input [7:0]rm_in_bcd;
  input [2:0]prob;
  wire [2:0]player_ans;
  wire [1:0]players;

  reg ret_score_p1, ret_score_p2;
  remote_chk_ans_ply rcap(player_ans, players, rm_in_bcd);

  always @(1)
  begin
    if (player_ans == prob)
      begin
          case (players)
              1:ret_score_p1 = 1'b1;
              2:ret_score_p2 = 1'b1;
              default:
                begin
                  ret_score_p1 = 1'b0;
                  ret_score_p2 = 1'b0;
                end
          endcase
      end
    else
      begin
        ret_score_p1 = 1'b0;
        ret_score_p2 = 1'b0;
      end
  end
endmodule

module remote_chk_ans_ply(anssel, player, in_bcd);
/*
  check answer from remote both
  @retrun choice 1-4 [3:0]and player 1-2 [1:0]
  @input [active low] raw bcd[7:0] from remote
*/
  output [2:0]anssel;
  output [1:0]player;
  input [7:0]in_bcd;

  reg [2:0]anssel;
  reg [1:0]player;

  always @(1)
    begin
      case (in_bcd)
        8'b11111110 :
        begin
          anssel = 4;
          player = 2;
        end
        8'b11111101 :
        begin
          anssel = 3;
          player = 2;
        end
        8'b11111011 :
        begin
          anssel = 2;
          player = 2;
        end
        8'b11110111 :
        begin
          anssel = 1;
          player = 2;
        end
        8'b11101111 :
        begin
          anssel = 4;
          player = 1;
        end
        8'b11011111 :
        begin
          anssel = 3;
          player = 1;
        end
        8'b10111111 :
        begin
          anssel = 2;
          player = 1;
        end
        8'b01111111 :
        begin
          anssel = 1;
          player = 1;
        end
        default:
          begin
            anssel = 0;
            player = 0;
          end
      endcase
    end
endmodule
