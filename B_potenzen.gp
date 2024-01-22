red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("Usage: B_potenzen(B)");

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
  printf(blue("= %d"), product);
  return (product);
}
