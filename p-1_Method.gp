red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("Usage: p1(n,B, a)");
print("Usage: B_potenzen(B)");

p1(n,B,a) = {
  printf(blue("k = ")); \\B_potenzen does the rest of the printout
  k = B_potenzen(B);
  resi = gcd(a^(k % n) -1, n);
  printf(blue("gcd(%d^(%d mod %d)-1,%d) \= %d\n"),a,k,n,n,resi);
  if (1 < resi && resi < n,
    printf(green("1 < f < n fullfilled!\n"));
    printf(green("%d is a factor of %d\n"), resi, n);,
    printf(red("1 < f < n not fullfilled!\n"));
    printf(red("%d is not a factor of %d\n"), resi, n);
    );

}

B_potenzen(B) = {
  product = 1;
  first = 1;
  for (i = 2, B,
    if(isprime(i),
    for (j= 1, B,
      if (i^j <= B && i^(j+1)>B,
        if (first,
          first = 0;
          printf(blue("%d^%d "), i, j);,
          printf(blue("* %d^%d "), i, j);
          );
        product *= i^j;
        );
    );
    );
  );
  printf(blue("= %d\n"), product);
  return (product);
}
