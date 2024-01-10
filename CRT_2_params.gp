print("ChineseRemainderTheorem: Usage CRT_2_params( Mod(1,3), Mod(1,4), Mod(2,5))");

CRT_2_params(a,b) = {
my(ab, a1, m1, a2, m2, m, M1, M2, u1, u2, X);

a1 = lift(a);
m1 = component(a,1);

a2 = lift(b);
m2 = component(b,1);

ab = gcd(m1,m2);
if (ab != 1, printf("Abort! Gcd of %d and %d is %d -> not coprime\n",m1,m2,ab);return);
m = m1 * m2;
printf("m = %d\n", m);

M1 = m2;
printf("M1 = %d\n", M1);

M2 = m1;
printf("M2 = %d\n", M2);

u1 = lift(Mod(M1,m1)^-1);
printf("u1 = Mod(M1,m1)^-1 = %d\n", u1);
u2 = lift(Mod(M2,m2)^-1);
printf("u2 = Mod(M2,m2)^-1 = %d\n", u2);

X = ((a1 * M1 * u1)%m + (a2 * M2 * u2)%m)%m;
printf("X is ((a1 * M1 * u1) mod m + (a2 * M2 * u2) mod m) mod m\n");
printf("X = %d\n",X);
}
