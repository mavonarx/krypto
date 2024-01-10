blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
yellow(s) = { return(concat("\e[33m", concat(s, "\e[0m"))); }
print("El_Gamel: Usage El_Gamel(z,{g},{A}), \nz = Zn*, g = generator");
printf(blue("This is an INTERACTIVE script\n"));
print("Generator and Public Key of Alice are optional")

El_Gamal(z, g=0, A=0) = {
    my(B, key_Bob, key_Alice);
    if (g==0, 
      g = lift(znstar(z)[3][1]);
      printf("Generator = %d\n", g);
      );
    dont = 0;
    if (A == 0,
      print("type in the secret number of alice");
      dont = 1;
      a = input();
      a = a % z;
      printf(blue("Private key a of alice: %d\n"), a);
      A = g^a % z;
      printf(yellow("Public key A of alice formula: g^a %% z = A\n"));
      printf(blue("Public key A of alice: %d^%d %% %d = %d\n"),g,a,z, A);
   );


    print("type in the secret key of bob");
    b = input();
    b = b % z;
    printf(green("Private key b of bob: %d\n"), b);

    B = g^b % z;
    printf(yellow("Public B key of bob formula: g^b %% z = B\n"));
    printf(green("Public key B of bob: %d^%d %% %d = %d\n"), g,b,z,B);


    print("type in the message bob wants to send");
    m = input();
    m = m % z;

    c = A^b * m %z;
    printf(yellow("Encrypted message formula: A^b * m %% z= c\n"));
    printf(green("c = %d^%d * %d %% %d= %d\n"), A,b,m,z,c);
    printf(green("Bob sends his public key =  %d\nand the encrypted message c = %d\n"), B, c);

    if (dont==1,
      m2 = c*B^(z-1-a) %z;
      printf(yellow("Message recovery forumla: c * B^(z-1-a) %% z = m\n"));
      printf(blue("Alice berechnet %d * %d^(%d-1-%d) %% %d = %d\n"), c,B, z, a, z, m2);

      );

}
