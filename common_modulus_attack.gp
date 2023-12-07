print("Usage: common_attack(m,e1,d1,e2)");
common_attack(m,e1,d1,e2) = {
v = e1 * d1 -1;
printf("v = e1 * d1 -1 = %d\n", v);
g = gcd(v,e2);
printf("gcd of e2 and v is %d\n", g);
if (g!=1, v=v/g, printf("v is unchanged since gcd was 1\n"));
if (g!=1, printf("v_dash is now %d\n",v));
d2 = lift(Mod(e2,v)^-1);
printf("d2 found! its the mutiplicative inverse of e2 mod v => %d\n", d2);
}
