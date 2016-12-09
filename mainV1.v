module mainTest (vcc,gnd,left,right,segBcd,scoreLeft,scoreRight,joyInL,joyInR);
  output vcc;
  reg vcc;
  output gnd;
  reg gnd;

//  output [3:0]ostage;


  output [4:0]left;
  output [4:0]right;
  output [3:0]segBcd;

  output [4:0]scoreLeft;
  output [4:0]scoreRight;


  input [3:0]joyInL;
  input [3:0]joyInR;

  wire [2:0]Qleft;
  wire [2:0]Qright;
  wire [3:0]Qseg;
  wire [3:0]ans;

  wire scoreTrigL;
  wire scoreTrigR;

  wire [3:0]bcd;

  wire [2:0]joyLbcd;
  wire [2:0]joyRbcd;
  wire toggleL;
  wire toggleR;





  wire Qtrigger;

  always @ ( 1 ) begin
    vcc =1;
    gnd =0;
  end


  clickcountup clickcountup2(bcd,Qtrigger);

  //assign ostage = bcd;

  initialize init(Qleft,Qright,ans,Qseg,bcd);
  displayquestion display(left,right,segBcd,Qleft,Qright,Qseg);

  joy joyR(joyRbcd,joyInR);
  joy joyL(joyLbcd,joyInL);

  assign toggleL = joyInL[0] || joyInL[1] || joyInL[2] || joyInL[3];
  assign toggleR = joyInR[0] || joyInR[1] || joyInR[2] || joyInR[3];

  //wire [3:0]scoreLbcd;
  //wire [3:0]scoreRbcd;
  ansCheck ansCheck1(scoreLeft,scoreRight,scoreTrigL,scoreTrigR,joyLbcd,joyRbcd,toggleL,toggleR,ans);

  //scoreModule scoreL1(scoreLeft,scoreLbcd);
  //scoreModule scoreR1(scoreRight,scoreRbcd);

  assign Qtrigger = scoreTrigL || scoreTrigR;
// scoreTrigL || scoreTrigR ||








endmodule //

module ansCheck (scoreLOut,scoreROut,trigScoreL,trigScoreR,bcdJoyL,bcdJoyR,toggleL,toggleR,ans);
  output trigScoreL;
  output trigScoreR;
  output [4:0]scoreLOut;
  output [4:0]scoreROut;

  //reg [4:0]scoreLOut;
  //reg [4:0]scoreROut;

  //reg [3:0]scoreL;
  //reg [3:0]scoreR;

  input [2:0]bcdJoyL;
  input [2:0]bcdJoyR;
  input [3:0]ans;
  input toggleL,toggleR;

  reg trigScoreL,trigScoreR;

  /*always @ ( 1 ) begin
    scoreL = 2;
    scoreR =2;
  end
*/
  always @ (toggleL) begin
    if(bcdJoyL == ans )begin
      trigScoreL =1;

      end
    else trigScoreL =0;
  end

  always @ (toggleR) begin
    if(bcdJoyR == ans ) begin
      trigScoreR =1;

      end
    else trigScoreR =0;

  end
  wire [3:0]bcdL;
  wire [3:0]bcdR;

  clickcountup cL(bcdL,trigScoreL);
  clickcountup cR(bcdR,trigScoreR);

  scoreDisplay sd(scoreLOut,scoreROut,bcdL,bcdR);
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

  always @ ( in ) begin
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
    output [3:0]segBcd;
    output [3:0]ans;
    input [3:0]state;
    reg [2:0]outL;
    reg [2:0]outR;
    reg [3:0]segBcd;
    reg [3:0]ans;

    always @ ( state ) begin

        if(state ==0)begin
            outL = 1;
            outR = 1;
            segBcd = 0;
            ans = 1;
           end
        else if(state ==1) begin
            outL = 2;
            outR = 2;
            segBcd = 2;
            ans = 2;
            end
          else if(state ==2)begin
                outL = 3;
                outR = 3;
                segBcd = 3;
                ans = 3;
               end
        else if(state ==3) begin
                outL = 4;
                outR = 4;
                segBcd = 4;
                ans = 4;
                end

        else if(state ==4)begin
                  outL = 5;
                  outR = 5;
                  segBcd = 5;
                  ans = 3;
                 end

      else if(state ==5) begin
                     outL = 4;
                     outR = 4;
                     segBcd = 6;
                     ans = 2;
                     end
      else if(state ==6) begin
                   outL = 3;
                  outR = 3;
                 segBcd = 7;
                   ans = 1;
                  end
      else if(state ==7) begin
                 outL = 2;
                     outR = 2;
                 segBcd = 8;
                       ans = 2;
                       end
          else if(state ==8) begin
                    outL = 2;
                 outR = 3;
                   segBcd = 9;
                   ans = 3;
                   end


          else if(state ==9)begin
                 outL = 0;
                outR = 1;
                segBcd = 1;
                   ans = 4;
                end
          else if(state ==10)begin
                outL = 5;
               outR = 5;
               segBcd = 0;
                  ans = 0;
               end

        else begin
            outL = 0;
            outR = 0;
            segBcd = 0;
            ans = 0;
           end


    end



endmodule //






module displayquestion (left,right,segBcd,ileft,iright,iseg);
  output [4:0]left;
  output [4:0]right;
  output [3:0]segBcd;
  input [2:0]ileft;
  input [2:0]iright;
  input [3:0]iseg;

  reg [4:0]left;
  reg [4:0]right;
  reg [3:0]segBcd;


  always @ ( ileft ) begin
    case (ileft)
      0: left = 5'b00000;
      1: left = 5'b00001;
      2: left = 5'b00011;
      3: left = 5'b00111;
      4: left = 5'b01111;
      5: left = 5'b11111;
      default: left = 5'b00000;
    endcase


  end

    always @ ( iright ) begin
    case (iright)
      0: right= 5'b00000;
      1: right = 5'b00001;
      2: right = 5'b00011;
      3: right = 5'b00111;
      4: right = 5'b01111;
      5: right = 5'b11111;
      default: right = 5'b00000;
    endcase
    end

    always @ ( iseg ) begin
      segBcd = iseg;
    end



endmodule //

module scoreDisplay(ledL,ledR,bcdL,bcdR);
  output [4:0]ledL;
  output [4:0]ledR;
  input [3:0]bcdL;
  input [3:0]bcdR;

  reg [4:0]ledL;
  reg [4:0]ledR;

  always @(bcdL || bcdR)
  begin
      case (bcdL)
          0 : ledL = 5'b00000;
          1 : ledL = 5'b00001;
          2 : ledL = 5'b00011;
          3 : ledL = 5'b00111;
          4 : ledL = 5'b01111;
          5 : ledL = 5'b11111;
          default : ledL = 5'b00000;
      endcase

      case (bcdR)
          0 : ledR = 5'b00000;
          1 : ledR = 5'b00001;
          2 : ledR = 5'b00011;
          3 : ledR = 5'b00111;
          4 : ledR = 5'b01111;
          5 : ledR = 5'b11111;
          default : ledR = 5'b00000;
      endcase
  end





endmodule
/*module scoreModule(led,bcd); //display score

output [4:0] led;
    input [3:0]bcd;

     reg [4:0] led;


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
*/

module clickcountup(bcd,trigger); //count up 0 - 5
	input trigger;
	output [3:0]bcd;
	reg [3:0]bcd;


	always @(negedge trigger)
	begin
  /*
    if(bcd == 11)
      bcd = 1;
    else bcd = bcd+1;
    */
  	case(bcd)
			0 : bcd = 1;
			1 : bcd = 2;
			2 : bcd = 3;
			3 : bcd = 4;
			4 : bcd = 5;
			5 : bcd = 6;
      6 : bcd = 7;
      7 : bcd = 8;
      8 : bcd = 9;
      9 : bcd = 10;
			default : bcd = 0;
		endcase

	end
	endmodule
