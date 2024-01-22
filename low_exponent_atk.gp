print("ChineseRemainderTheorem: Usage low_exponent(e,m1,r1,m2,r2,m3,r3,t)");

low_exponent(e, m1, r1, m2, r2, m3, r3, t) = {
  X = CRT(Mod(r1,m1), Mod(r2,m2), Mod(r3,m3));
  printf("t^e = %d\n", t^e);
  printf("t = X ^(1/e)\n");
  res = sqrtn(X,e);
  printf("t = %d ^(1/%d) \= %d\n", X, e, res);
}

CRT(a,b,c) = {
my(ab, ac, bc, a1, m1, a2, m2, a3, m3, m, M1, M2, M3, u1, u2, u3, X);



a1 = lift(a);
m1 = component(a,1);

a2 = lift(b);
m2 = component(b,1);

a3 = lift(c);
m3 = component(c,1);

ab = gcd(m1,m2);
if (ab != 1, printf("Abort! Gcd of %d and %d is %d -> not coprime\n",m1,m2,ab);return);
ac = gcd(m1,m3);
if (ac != 1, printf("Abort! Gcd of %d and %d is %d -> not coprime\n",m1,m3, ac);return);
bc = gcd(m2,m3);
if (bc != 1, printf("Abort! Gcd of %d and %d is %d -> not coprime\n",m2,m3,bc);return);

m = m1 * m2 * m3;
printf("m = %d\n", m);

M1 = m2 * m3;
printf("M1 = %d\n", M1);

M2 = m1 * m3;
printf("M2 = %d\n", M2);

M3 = m1 * m2;
printf("M3 = %d\n", M3);

u1 = lift(Mod(M1,m1)^-1);
printf("u1 = Mod(M1,m1)^-1 = %d\n", u1);
u2 = lift(Mod(M2,m2)^-1);
printf("u2 = Mod(M2,m2)^-1 = %d\n", u2);
u3 = lift(Mod(M3,m3)^-1);
printf("u3 = Mod(M1,m1)^-1 = %d\n", u3);

X = ((a1 * M1 * u1)%m + (a2 * M2 * u2)%m + (a3 * M3 * u3)%m)%m;
printf("X = ((a1 * M1 * u1) mod m + (a2 * M2 * u2) mod m + (a3 * M3 * u3) mod m) mod m\n");
printf("X = %d\n",X);
return (X);
}
