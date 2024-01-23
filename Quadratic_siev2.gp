red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }


print(blue("Contains functions for the quadratic-sieve AND a B-glatt-test function\n"))
print(blue("Quadratic_sieve(n, F, S): n = number to be factorized, F = Factorbase [-1,2,3...], S = Grundmenge [...-3, -2, -1, 0, 1, 2...]\n"))
print(blue("B_Glatt_test(x, n, F): x = test number, n = mod, F = Factorbase [-1,2,3...]\n"))


Quadratic_sieve(n, F, S) = {
    m = floor(sqrt(n));
    printf(blue("\nm = floor(sqrt(n)) \= %d\n\n"), m);
    
    printf("x ∈ S\t\t|");
    for(i = 1, #S,
        printf("%d\t\t|",S[i]);
    );
    printf("\n-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    printf("\nQ \= (m+x)^2 -n\t|");
    for(i = 1, #S, 
        printf("%d\t\t|",Qx(S[i],m,n));
    );
    printf("\n-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    printf("\nfactors\t\t|");
    for (i = 1, #S,
      q = Qx(S[i], m,n);
      f = factor(q);
      len = #f[,1];
      st = "";
      if (f[1,2] == 1, 
          \\printf("%d ",f[1,1]);
          st = concat(f[1,1], " ");,
          \\printf("%d^%d ",f[1,1], f[1,2]);
          st = concat(f[1,1], " ");
          st = concat(st, "^");
          st = concat(st,f[1,2]);
        );
      for (j = 2, len,
        st = concat(st, " * ");
        if (f[j,2] == 1,
          st = concat(st, f[j,1]);,
          \\printf("* %d ",f[j,1]);,
          st = concat(st, f[j,1]);
          st = concat(st, "^");
          st = concat(st, f[j,2]);
          \\printf("* %d^%d ",f[j,1], f[j,2]);
          );
        );
      printf("%-15s", st);
      \\if (len <= 2, printf("\t"););
      printf("|")
      );
    printf("\n-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    printf("\nB-smooth?\t|");
    for (i = 1, #S, 
      if (B_Glatt_test(Qx(S[i],m,n), n, F), 
        printf(green("Yes\t\t"));,
        printf(red("No\t\t"));
        );
        printf("|");
      );
    printf("\n-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    printf("\nB_i = (m + x)\t|");
    for (i = 1, #S, 
      if (B_Glatt_test(Qx(S[i],m,n), n, F), 
        printf(green("%d\t\t"), m + S[i]);,
        printf("\t\t");
        );
        printf("|");
      );



      

    

}

Qx(x, m, n) = {
    return ((m+x)^2-n);
}

inList(list, value)=for(i=1,#list, if(list[i]==value, return(i))); 0


B_Glatt_test(x, n, F) = {
    factors = factor(x);
    found = 0;
    for(f = 1, #factors[, 1],
            if((inList(F, factors[f,1])),
                found = found +1;,
                return (0);
            );
    );
    return (1);
}
