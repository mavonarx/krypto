red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("Usage RSA: signature_rsa_create(e,d,n,m, signature_given) if e, d, or signature_given is not given set -1");
print("Usage: EL_Gamal: signature_el_gamal(g,a,p,m,k, {signature_given[r,s]}) k must be coprime to p-1");
print("Usage: elliptic: signature_elliptic(a,b,p,d,k,m,P[],n, {sign_given[r,s]}) a and b are the params of the elliptic curve");

print("d is the private key of alice, m is the hashed message, n = Cardinality of P = |P|");
signature_elliptic(a,b,p,d,k,m,P,n, sign_given=[-1,-1]) = {
  
  print(a);
  print(b);
  print(p);
  E = ellinit([a,b], p);
  Q = ellmul(E,P,d);
  print(Q);
  printf(blue("Public Key Q = %d * (%d,%d) \= (%d, %d)\n"),
  d,lift(P[1]), lift(P[2]), lift(Q[1]), lift(Q[2])
  );
  
  Z = ellmul(E,P,k);
  x = lift(Z[1]);
  y = lift(Z[2]);
  printf(blue("(x,y) \= %d * (%d, %d) \= (%d, %d)\n"),
  k,lift(P[1]), lift(P[2]), x, y
  );  

  r = x % n;
  printf(blue("r = x mod n = %d mod %d = %d\n"), x,n,r );
  inv_k = lift(Mod(k^-1,n));
  printf(blue("Inverse of k = %d\n"), inv_k);
  s = ((m + (r * d)) * inv_k ) % n;
  printf(blue("s = (h(%d) + (%d * %d)) * %d (mod %d) \= %d\n"),
  m, r, d, inv_k, n, s
  );

  printf(green("Signature: (%d, %d)\n"), r,s);

  if (sign_given[1] !=-1,
    printf("set r and s to the given signature\n");
    r = sign_given[1];
    s = sign_given[2];

        u = (m * lift(Mod(s^-1,n))) %n;
    printf(blue("u = h(%d) * %d^-1 (mod %d)\ = %d\n"), m, s, n, u);
    v = (r * lift(Mod(s^-1,n))) %n;
    printf(blue("v = %d * %d^-1 (mod %d)\ = %d\n"), r, s, n, v);
    up = ellmul(E, P, u);
    printf(blue("u * P = (%d, %d)\n"), lift(up[1]), lift(up[2]));
    vq = ellmul(E,Q,v);
    printf(blue("v * Q = (%d, %d)\n"), lift(vq[1]), lift(vq[2]));
    L = elladd(E, up, vq);
    a = lift(L[1]);
    printf(blue("(a,b) \= u * P + v * Q = (%d, %d)\n"), lift(L[1]), lift(L[2]));
    if ((r %n) != (a%n),
      printf(red("r != a mod %d => signature not valid\n"), n),
      printf(green("r == a mod %d => signature valid\n"), n)
    );



  );








}

signature_el_gamal(g,a,p,m,k, signature_given=[-1,-1]) = {
  my(A,r,s);
  A = (g^a)%p;
  printf(blue("A = %d^%d mod %d = %d\n"), g, a, p, A);
  r = (g^k) % p;
  printf(blue("r = %d^%d mod %d = %d\n"), g, k, p, r);
  
  k_inv = lift(Mod(k^-1,(p-1)));
  printf(blue("The invers of k= %d in mod(%d -1) is : %d\n"), k,p-1,k_inv);
  s = (k_inv * (m - (a * r))) % (p-1);  
  printf(blue("s = %d * (%d - (%d * %d)) mod (%d -1) \= %d\n"), 
  k_inv, m, a, r, p, s); 
  
  printf(green("Signature: (%d, %d)\n"), r, s);

  if (signature_given[1] != -1,
    printf(green("r and s are set to the new signature\n"));
    r = signature_given[1];
    if (r > p-1 || r < 1, 
      printf(red("signature refused because 1 <= r <= p-1 not fullfilled"));
      return;
      );
    s = signature_given[2];
    printf(blue("check: A^r * r^s == g^h(m) mod p\n"));
    printf(blue("check: %d^%d * %d^%d == %d^h(%d) mod %d\n"),
    A,r, r, s, g, m, p
    );
    left = ((A^r) * (r^s)) %p;
    printf(blue("Left side: %d^%d * %d^%d mod %d= %d\n"), A, r, r, s, p, left);
    right = (g^m) %p;
    printf(blue("Right side: %d^h(%d) mod %d = %d\n"), g, m, p,right);

    if (left == right,
      printf(green("The signature is correct!\n")),
      printf(red("The signature is not correct\n"))
      );
  );

}

signature_rsa_create(e=-1, d=-1, n, m, signature_given=-1) = {
    phi_n = eulerphi(n);
    printf(blue("Eulerphi of n is: %d\n"), phi_n);
    if (e==-1 && d!=-1,
        e = lift(Mod(d,phi_n)^-1);
        printf(blue("e = Modinvers of d = %d\n"), e);
    );
    if (d==-1 && e!=-1,
        d = lift(Mod(e,phi_n)^-1);
        printf(blue("d = Modinvers of e = %d\n"), d);
    );

    signature = (m^d) % n;
    printf(green("Signature s = m^d %% n = %d^%d %% %d = %d\n"),m,d,n,signature);
    if (signature_given==-1,
        check = signature^e % n;
        printf("check = signature^e %%n = %d^%d %%n = %d\n", signature, e,n,check);
        if (check == m,
            printf(green("Signature is valid\n")),
            printf(red("Signature is not valid\n")),
        );,
        check = signature_given^e % n;
        printf("The given signature is: %d\n", signature_given);
        printf("check = signature_given^e %%n = %d^%d %%n = %d\n", signature_given, e,n,check);
        if (check ==m,
            printf(green("Signature is valid\n")),
            printf(red("Signature is not valid\n")),
        );
    );
}

