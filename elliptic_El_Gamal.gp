red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
printf("Usage: elliptic_El_Gamal(kA, kB, P[x,y], a, b, M[x,y], p)  y^2 = x^3 + a*x + b in GF(p)\n");

elliptic_El_Gamal(kA, kB, P, a,b, M, p=1) = {
  my(E, A, B, key);
  E = ellinit([a,b], p);
  A = ellmul(E, P, kA);
  B = ellmul(E, P, kB);
  printf(blue("Public key of Alice A: %d * (%d, %d) \= (%d, %d)\n"), 
  kA, lift(P[1]), lift(P[2]), lift(A[1]), lift(A[2]));

  printf(green("Alice sends her public Key to Bob\n"));

  printf(green("\nEncryption: \n"));
  printf(blue("Public key of Bob B:   %d * (%d, %d) \= (%d, %d)\n"), 
  kB, lift(P[1]), lift(P[2]), lift(B[1]), lift(B[2]));

  key = ellmul(E, A, kB);
  C = elladd(E,key,M);
  printf(green("Cipher is calculated as M + kb * A\n"));
  printf(blue("C = (%d, %d) + %d * (%d, %d) \= (%d, %d))\n"), 
  lift(M[1]), lift(M[2]), kB, lift(A[1]), lift(A[2]), lift(C[1]), lift(C[2]));
  printf(green("Bob sends the cipher C and his public Key B to Alice\n"));
  printf(green("\nDecryption: \n"));
  printf(green("Alice calculates -kA * B + C \n"));
  \\printf(green("For this alice calculates -B (switch sign of y-component) \= (%d, %d)\n")
  \\, lift(negB[1]), lift(negB[2]));
  product = ellmul(E, B, kA);
  printf(blue("kA * B = %d * (%d, %d) \= (%d, %d)\n"),
  kA, lift(B[1]), lift(B[2]), lift(product[1]), lift(product[2]));
  product = [product[1], -product[2]];
  printf(green("-kA * B => switch sign of y-component of point\n"));
  printf(blue("(%d, %d)\n"), lift(product[1]), lift(product[2]));
  printf(green("Now we have to add C\n"));
  decrypted_message = elladd(E, C, product);
  printf(blue("M_decrypted = (%d, %d) + (%d, %d) \= (%d, %d)\n"),
  lift(product[1]), lift(product[2]), lift(C[1]), lift(C[2]), 
  lift(decrypted_message[1]), lift(decrypted_message[2]));

}
