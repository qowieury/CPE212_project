module mainTest (left,right,segBcd,scoreLeft,scoreRight,joyInL,joyInR);
  output [4:0]left;
  output [4:0]right;
  output [2:0]segBcd;

  output [4:0]scoreLeft;
  output [4:0]scoreRight;
  //input trigger;

  input [3:0]joyInL;
  input [3:0]joyInR;

  wire [2:0]Qleft;
  wire [2:0]Qright;
  wire [2:0]Qseg;
  wire [2:0]ans;

  wire scoreTrigL;
  wire scoreTrigR;

  wire [2:0]bcd;

  wire [2:0]joyLbcd;
  wire [2:0]joyRbcd;
  wire toggleL;
  wire toggleR;

//  wire trigScoreL;
//  wire trigScoreR;



  wire Qtrigger;



  clickcountup clickcountup2(bcd,Qtrigger);
  initialize init(Qleft,Qright,ans,Qseg,bcd);
  displayquestion display(left,right,segBcd,Qleft,Qright,Qseg);

  joy joyR(joyRbcd,joyInR);
  joy joyL(joyLbcd,joyInL);

  assign toggleL = joyInL[0] || joyInL[1] || joyInL[2] || joyInL[3];
  assign toggleR = joyInR[0] || joyInR[1] || joyInR[2] || joyInR[3];



  ansCheck ansCheck1(scoreTrigL,scoreTrigR,joyLbcd,joyRbcd,toggleL,toggleR,ans);



  assign Qtrigger = (scoreTrigL || scoreTrigR);




  scoreModule scoreL(scoreLeft,scoreTrigL);
  scoreModule scoreR(scoreRight,scoreTrigR);




endmodule //

module ansCheck (trigScoreL,trigScoreR,bcdJoyL,bcdJoyR,toggleL,toggleR,ans);
  output trigScoreL;
  output trigScoreR;
  input [2:0]bcdJoyL;
  input [2:0]bcdJoyR;
  input [2:0]ans;
  input toggleL,toggleR;

  reg trigScoreL,trigScoreR;

  always @ (toggleL || toggleR) begin
    if(bcdJoyL[0] == ans[0] && bcdJoyL[1] == ans[1] &&bcdJoyL[2] == ans[2] )
      trigScoreL =1;
    else trigScoreL =0;

    if(bcdJoyR[0] == ans[0] && bcdJoyR[1] == ans[1] &&bcdJoyR[2] == ans[2] )
      trigScoreR =1;
    else trigScoreR =0;

  end
/*  always @ (toggleR) begin
  if(bcdJoyR[0] == ans[0] && bcdJoyR[1] == ans[1] &&bcdJoyR[2] == ans[2] )
      trigScoreR =1;
    else trigScoreR =0;

  end
*/

endmodule //


module joy (bcd,in);
  output [2:0]bcd;
  input [3:0]in;
  reg [2:0]bcd;

  always @ ( in[0] || in[1] || in[2] || in[3] ) begin
    case (in)
      4'b1110:begin
        bcd = 1;

      end
      4'b1101:begin
        bcd = 2;
      end
      4'b1011:begin
        bcd = 3;
      end
      4'b0111:begin
        bcd = 4;
      end
      default:begin
        bcd = 0;
      end
    endcase

  end



endmodule //


module initialize (outL,outR,ans,segBcd,state); //initial question
    output [2:0]outL;
    output [2:0]outR;
    output [2:0]segBcd;
    output [2:0]ans;
    input [2:0]state;
    reg [2:0]outL;
    reg [2:0]outR;
    reg [2:0]segBcd;
    reg [2:0]ans;

    always @ ( state ) begin
      case (state)
        0 :begin
            outL = 1;
            outR = 1;
            segBcd = 0;
            ans = 1;
           end
        1 : begin
            outL = 2;
            outR = 2;
            segBcd = 2;
            ans = 2;
            end
          2 :begin
                outL = 3;
                outR = 3;
                segBcd = 2;
                ans = 3;
               end
            3 : begin
                outL = 4;
                outR = 4;
                segBcd = 5;
                ans = 4;
                end

              4 :begin
                  outL = 5;
                  outR = 5;
                  segBcd = 3;
                  ans = 2;
                 end
                 //--------------------
                 5 : begin
                     outL = 2;
                     outR = 2;
                     segBcd = 5;
                     ans = 4;
                     end
                     6 : begin
                         outL = 3;
                         outR = 3;
                         segBcd = 5;
                         ans = 3;
                         end
                         7 : begin
                             outL = 2;
                             outR = 5;
                             segBcd = 5;
                             ans = 1;
                             end
                             8 : begin
                                 outL = 1;
                                 outR = 2;
                                 segBcd = 5;
                                 ans = 2;
                                 end


                 5 :begin
                 outL = 1;
                outR = 5;
                segBcd = 3;
                   ans = 0;
                end
                6 :begin
                outL = 1;
               outR = 3;
               segBcd = 3;
                  ans = 6;
               end

        default:begin
            outL = 0;
            outR = 0;
            segBcd = 0;
            ans = 0;
           end
      endcase

    end



endmodule //






module displayquestion (left,right,segBcd,ileft,iright,iseg);
  output [4:0]left;
  output [4:0]right;
  output [2:0]segBcd;
  input [2:0]ileft;
  input [2:0]iright;
  input [2:0]iseg;

  reg [4:0]left;
  reg [4:0]right;
  reg [2:0]segBcd;


  always @ ( 1 ) begin
    case (ileft)
      0: left = 5'b00000;
      1: left = 5'b00001;
      2: left = 5'b00011;
      3: left = 5'b00111;
      4: left = 5'b01111;
      5: left = 5'b11111;
      default: left = 5'b00000;
    endcase

    case (iright)
      0: right= 5'b00000;
      1: right = 5'b00001;
      2: right = 5'b00011;
      3: right = 5'b00111;
      4: right = 5'b01111;
      5: right = 5'b11111;
      default: right = 5'b00000;
    endcase

    segBcd = iseg;

  end



endmodule //

module scoreModule(led,trigger); //display score

    input trigger;
     output [4:0] led;
     reg [4:0] led;
     wire [2:0]bcd;

		clickcountup clickcountup1(bcd,t);

    always @(bcd)
    begin
        case (bcd)
            0 : led = 5'b00000;
            1 : led = 5'b00001;
			      2 : led = 5'b00011;
			      3 : led = 5'b00111;
			      4 : led = 5'b01111;
			      5 : led = 5'b11111;
            default : led = 5'b00000;
        endcase
    end

endmodule

module clickcountup(bcd,trigger); //count up 0 - 5
	input trigger;
	output [2:0]bcd;
	reg [2:0]bcd;


	always @(negedge trigger)
	begin
    if(bcd == 7)
      bcd = 0;
    else bcd = bcd+1;

  	/*case(bcd)
			0 : bcd = 1;
			1 : bcd = 2;
			2 : bcd = 3;
			3 : bcd = 4;
			4 : bcd = 5;
			5 : bcd = 6;
      6 : bcd = 0;
			default : bcd = 0;
		endcase
*/
	end
	endmodule
