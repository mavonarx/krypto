red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }


print(blue("Contains functions for the quadratic-sieve AND a B-glatt-test function\n"))
print(blue("Quadratic_sieve(n, F, S): n = number to be factorized, F = Factorbase [-1,2,3...], S = Grundmenge [...-3, -2, -1, 0, 1, 2...]\n"))
print(blue("B_Glatt_test(x, n, F): x = test number, n = mod, F = Factorbase [-1,2,3...]\n"))


Quadratic_sieve(n, F, S) = {
    m = floor(sqrt(n));
    printf(" X      q(x)    factors         Bi\n");
    for(s = 1, #S,
        x = S[s];
        q = Qx(x, m, n);
        factors = factor(q);
        Bi = m+x;
        found = 0;
        for(f = 1, #factors[, 1],
            if((inList(F, factors[f,1]) != 0),
                found =found + 1,
                break;
            );
        );

        printf(" %d     %d     [", x, q);
        for(f = 1, #factors[, 1],
            printf("%d,", factors[f,1]);
        );
        printf("]       %d\n", Bi);
        if(found == #factors[,1],
            printf(green("%d erfüllt eigenschaft\n"), S[s]),
            printf(red("%d erfüllt eigenschaft nicht\n"), S[s]);
        );
    );
}

Qx(x, m, n) = {
    return ((m+x)^2-n);
}

inList(list, value)=for(i=1,#list, if(list[i]==value, return(i))); 0


B_Glatt_test(x, n, F) = {
    a = x^2%n;
    if(a > n/2,
        a = a - n;
    );
    factors = factor(a);
    found = 0;
    for(f = 1, #factors[, 1],
            if((inList(F, factors[f,1]) != 0),
                found = found +1;
            );
    );
    if(found == #factors[,1],
        printf(green("%d is B-glatt"), x),
        printf(red("%d is not B-glatt"), x);
    );
}