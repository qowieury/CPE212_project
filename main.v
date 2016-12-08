module main (left,right,segBcd,scoreLeft,scoreRight,trigger,joyInL,joyInR);
  output [4:0]left;
  output [4:0]right;
  output [2:0]segBcd;

  output [4:0]scoreLeft;
  output [4:0]scoreRight;
  input trigger;

  input [3:0]joyInL;
  input [3:0]joyInR;

  wire [2:0]Qleft;
  wire [2:0]Qright;
  wire [2:0]Qseg;
  wire [1:0]ans;

  wire scoreTrigL;
  wire scoreTrigR;

  wire [2:0]bcd;

  wire [1:0]joyLbcd;
  wire [1:0]joyRbcd;
  wire toggleL;
  wire toggleR;

//  wire trigScoreL;
//  wire trigScoreR;



  wire Qtrigger;

  clickcountup clickcountup2(bcd,Qtrigger);
  initialize init(Qleft,Qright,ans,Qseg,bcd);
  displayquestion display(left,right,segBcd,Qleft,Qright,Qseg);

  joy joyL(joyLbcd,toggleL,joyInL);
  joy joyR(joyRbcd,toggleR,joyInR);

  ansCheck ansCheck(scoreTrigL,scoreTrigR,joyLbcd,joyRbcd,toggleL,toggleR,ans);




  scoreModule scoreL(scoreLeft,scoreTrigL);
  scoreModule scoreR(scoreLeft,scoreTrigR);
  wire tmp1,tmp2;
  and andL(tmp1,scoreTrigL,toggleL);
  and andR(tmp2,scoreTrigR,toggleR);

  or or1(Qtrigger,tmp1,tmp2);





endmodule //

module ansCheck (trigScoreL,trigScoreR,bcdJoyL,bcdJoyR,toggleL,toggleR,ans);
  output trigScoreL;
  output trigScoreR;
  input [1:0]bcdJoyL;
  input [1:0]bcdJoyR;
  input toggleL;
  input toggleR;
  input [1:0]ans;

  reg trigScoreL;
  reg trigScoreR;



  always @ ( 1 ) begin
    if(toggleL) begin
      if(bcdJoyL == ans)
        trigScoreL = 1;
      else trigScoreL =0;
    end
      else begin
          if (toggleR)
            begin
              if (bcdJoyR == ans)
                trigScoreR =1;
              else trigScoreR =0;
            end
          end
  end

endmodule //


module joy (bcd,toggle,in);
  output [1:0]bcd;
  output toggle;
  input [3:0]in;

  reg [1:0]bcd;


  or or1(toggle,in[0],in[1],in[2],in[3]);

  always @ ( 1 ) begin
    case (in)
      4'b0001: bcd = 0;
      4'b0010: bcd = 1;
      4'b0100: bcd = 2;
      4'b1000: bcd = 3;
      default: ;
    endcase
  end

endmodule //


module initialize (outL,outR,ans,segBcd,state); //initial question
    output [2:0]outL;
    output [2:0]outR;
    output [2:0]segBcd;
    output [1:0]ans;
    input [2:0]state;
    reg [2:0]outL;
    reg [2:0]outR;
    reg [2:0]segBcd;
    reg [1:0]ans;

    always @ ( 1 ) begin
      case (state)
        0 :begin
            outL = 2;
            outR = 1;
            segBcd = 0;
            ans = 2;
           end
        1 : begin
            outL = 4;
            outR = 2;
            segBcd = 2;
            ans = 1;
            end
          2 :begin
                outL = 5;
                outR = 3;
                segBcd = 2;
                ans = 1;
               end
            3 : begin
                outL = 1;
                outR = 4;
                segBcd = 5;
                ans = 0;
                end
                4 :begin
                    outL = 3;
                    outR = 5;
                    segBcd = 0;
                    ans = 3;
                   end

        default:begin
            outL = 0;
            outR = 0;
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
    if(bcd == 5)
      bcd = 0;
    else bcd = bcd+1;

  	/*case(bcd)
			0 : bcd = 1;
			1 : bcd = 2;
			2 : bcd = 3;
			3 : bcd = 4;
			4 : bcd = 5;
			5 : bcd = 0;
			default : bcd = 0;
		endcase
    */
	end
	endmodule
