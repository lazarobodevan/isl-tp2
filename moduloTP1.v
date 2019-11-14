module moduloTP(A, B, C, D, saida);

  input wire A, B, C, D;
  output wire [6:0] saida;

  assign saida[0] = A|(~B & ~C & ~D); //a
  assign saida[1] = (~C & ~D) | (~A & ~C) | (~B & ~C) | (~A & B & ~D) | (A & ~B & ~D);//b
  assign saida[2] = (~C & ~D) | (A & D) | (B & C & D);//c
  assign saida[3] = (~B & ~C & ~D) | (~A & D) | (~A & C) | (B & C & ~D);//d
  assign saida[4] = (~C & ~D) | (B & ~D) | (A & B & C) | (~A & ~B & C & D);//e
  assign saida[5] = (A & ~B) | (~B & D) | (A & C & ~D) | (~A & ~C & ~D);//f
  assign saida[6] = (~A & ~B & C) | (~B & ~C & ~D) | (B & ~C & D);//g

endmodule
