
module maquinaAdjAdv(
  input wire clock,
  input wire ok,
  input wire reset,
  output reg fim,
  output reg [1:0]tipo,
  input wire [3:0] nota
);

  parameter zero = 4'b0000;
  parameter inval1 = 4'b0000;
  parameter inval2 = 4'b1000;
  parameter laBaixo = 4'b1110;
  parameter siBaixo = 4'b1111;
  parameter doAlto = 4'b0001;
  parameter reAlto = 4'b0010;

  parameter inicial = 4'b0000;
  parameter s1 = 4'b0001;
  parameter s2 = 4'b0010;
  parameter s3 = 4'b0011;
  parameter s4 = 4'b0100;
  parameter s6 = 4'b0101;
  parameter s8 = 4'b0110;
  parameter s10 = 4'b0111;
  parameter sErro = 4'b1000;
  parameter sAdjetivo = 4'b1001;
  parameter sAdjCompa = 4'b1010;
  parameter sAdverbio = 4'b1011;

  parameter erro = 2'b00;
  parameter adjetivo = 2'b01;
  parameter adjCompa = 2'b10;
  parameter adverbio = 2'b11;

  reg[3:0] state;
  reg[3:0] nextState;

  always @(posedge clock)begin
    if(reset)
      state <= inicial;
    else
      state <= nextState;
  end

  always @(posedge ok or posedge reset)begin
	if(reset)
		nextState = inicial;
	else begin
      case(state)
        inicial:
          begin
            if(nota == inval1 | nota == inval2)
              nextState = sErro;
            else
              nextState = s1;
          end
        s1:
          begin
              if(nota == inval1 | nota == inval2)
              nextState = sErro;
            else
              nextState = s2;
          end
        s2:
          begin
              if(nota == laBaixo)
                nextState = s3;
              else
                if(nota == siBaixo)
                  nextState = s4;
					 else
					   nextState = sErro;	
          end
        s3:
          begin
            if(nota == inval1 | nota == inval2)begin
              nextState = sAdjetivo;
            end
            else
              if(nota == doAlto)
               nextState = s6;
            else
              if(nota == siBaixo)
                nextState = s10;
              else begin
                nextState = sErro;
              end
          end
        s4:
          begin
              if(nota == inval1 | nota == inval2)begin
                nextState = sAdjetivo;
              end
              else
                if(nota == reAlto)
                  nextState = s8;
                else begin
                    nextState = sErro;
                end
          end
        s6:
          begin
            if(nota == inval1 | nota == inval2)begin
              nextState = sAdjCompa;
            end
            else
              begin
                nextState = sErro;
              end
          end
        s8:
          begin
            if(nota == inval1 | nota == inval2)begin
              nextState = sAdjCompa;
            end
            else
              begin
                nextState = sErro;
              end
          end
        s10:
          begin
            if(nota == inval1 | nota == inval2)begin
              nextState = sAdverbio;
            end
            else
              begin
                nextState = sErro;
              end
          end
		  sAdjetivo: begin
				nextState = sAdjetivo;
		  end
		  sAdjCompa: begin
				nextState = sAdjCompa;
		  end
		  sAdverbio: begin
				nextState = sAdverbio;
		  end
		  sErro: begin
				nextState = sErro;
		  end
      endcase
	  end
   end


  always @(state)begin
    case(state)
      inicial:begin
        fim = 0;
        tipo = erro;
      end
      s1:begin
        fim = 0;
        tipo = erro;
      end
      s2:begin
        fim = 0;
        tipo = erro;
      end
      s3:begin
        fim = 0;
        tipo = adjetivo;
      end
      s4:begin
        fim = 0;
        tipo = adjetivo;
      end
      s6:begin
        fim = 0;
        tipo = adjCompa;
      end
      s8:begin
        fim = 0;
        tipo = adjCompa;
      end
      s10:begin
        fim = 0;
        tipo = adverbio;
      end
      sErro:begin
        fim = 1;
        tipo = erro;
      end
      sAdjetivo:begin
        fim = 1;
        tipo = adjetivo;
      end
      sAdjCompa:begin
        fim = 1;
        tipo = adjCompa;
      end
      sAdverbio:begin
        fim = 1;
        tipo = adverbio;
      end
  endcase
end


endmodule
