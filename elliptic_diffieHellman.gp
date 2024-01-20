red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("Usage elliptic_diffieHellman(kA, kB, Px,Py, a, b, p)  y^2 = x^3 + a*x + b in GF(p)");

elliptic_diffieHellman(kA, kB, Px, Py, a,b, p=1) = {
  my(E, A, B);
  E = ellinit([a,b], p);
  A = ellmul(E, [Px, Py], kA);
  P = [Px, Py];
  B = ellmul(E, [Px, Py], kB);
  printf(blue("Public key of Alice: %d * (%d, %d) \= (%d, %d)\n"), 
  kA, lift(P[1]), lift(P[2]), lift(A[1]), lift(A[2]));
  printf(blue("Public key of Bob:   %d * (%d, %d) \= (%d, %d)\n"), 
  kB, lift(P[1]), lift(P[2]), lift(B[1]), lift(B[2]));
  key_Alice = ellmul(E, B, kA);
  key_Bob = ellmul(E, A, kB);
  printf(blue("Bob calculated the key with:   %d * (%d, %d) \= (%d, %d)\n"), 
  kB, lift(A[1]), lift(A[2]), lift(key_Bob[1]), lift(key_Bob[2]));
  printf(blue("Alice calculated the key with: %d * (%d, %d) \= (%d, %d)\n"), 
  kA, lift(B[1]), lift(B[2]), lift(key_Alice[1]),lift(key_Alice[2]));
  printf(blue("The overall key is the the product: P * kA * kB"));
}

