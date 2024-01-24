red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
printf("Usage: elliptic_nonce(n,m1,m2,s1[r1,s1],s2[r2,s2])\n n = Ordnung von p = |P|");

elliptic_nonce(n,m1, m2, s1, s2) = {
  diff = (s1[2]- s2[2]) %n;
  printf(blue("We want to find out k:\n"));
  printf(green("s1 - s2 (mod n) \= %d - %d (mod %d)\= %d\n"),s1[2], s2[2],
  n, diff);

  diff_inv = lift(Mod(diff^-1,p));
  printf(green("(s1 - s2)^-1 = %d\n"),diff_inv);
  diffmess = (m1 - m2) %n;
  printf(green("h(m1) - h(m2) (mod n)\= %d - %d (mod %d) \= %d\n"), m1, m2,n, diffmess);
  printf(blue("k = (s1 -s2)^-1 * (h(m1) - h(m2))\n"));
  k = (diff_inv * diffmess) %n;
  printf(green("k = %d * %d (mod %d) \= %d\n"), diff_inv, diffmess,n, k);
  printf(blue("We found k!\n"));

  printf(blue("Now lets find out secret key d\n"));
  printf(blue("d = (k * s1  - h(m1)) * r^-1 (mod n)\n"));
  r_inv = lift(Mod((s1[1])^-1,n));
  printf(green("r^-1 = %d\n"),r_inv);
  d = ((k * s1[2] - m1) * r_inv) % n;
  printf(green("d = %d * %d (mod %d) \= %d\n"), ((k *s1[2]) - m1), r_inv, n, d);
  






  
}
