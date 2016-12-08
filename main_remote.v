module main_remote(seg_p1, seg_p2);
  output [6:0]seg_p1;
  output [6:0]seg_p2;
endmodule

module remote_chk_ans_ply(anssel, player, in_bcd);
/*
  @retrun choice 1-4 and player 1-2
  @input raw bcd from remote
*/
  output [1:0]anssel;
  output [1:0]player;
  input [3:0]in_bcd;

  reg [1:0]anssel;
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
