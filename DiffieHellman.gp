blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
print("Diffie-Hellman: Usage DiffieHellman(z,a,b,{g}), \nz = Zn*, a = secret alice (optional), b = secret bob (optional), g = generator (optional)");

DiffieHellman(z, a=-1, b=-1, g=-1) = {
    my(A, B, key_Bob, key_Alice);
    if (g==-1, 
        g = lift(znprimroot(z));
        printf("Generator %d chosen!\n", g);
    );

    if (a==-1,
        print("type in the secret number of alice");
        a = input();
        a = a % z;
    );

    if (b==-1,
        print("type in the secret number of bob");
        b = input();
        b = b % z;
    );

    A = g^a % z;
    B = g^b % z;

    printf(blue("Alice sends Bob A = g^a %% p = %d\n"),A);
    printf(green("Bob sends Alice B = g^b %% p = %d\n"),B);

    printf("-------------------------------------------\n");
    key_Bob = A^b %z;
    key_Alice = B^a %z;

    printf(blue("Alice calculates key B^a = %d\n"), key_Alice);
    printf(green("Bob calculates key A^b = %d\n"), key_Bob);

}
