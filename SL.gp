red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
print("SL: Usage SL(n, test)");

SL(n, test)={
    my(factors, r, k,k_array,lowerbound,upperbound);
    factors = factor(n-1);
    r = factors[1,2]; \\ first factor is always 2, second part of the array it the exponent of 2
    printf("r = %d\n",r);
    u = (n-1) / (2^r);
    printf("u = %d\n",u);
    found = 0;
    if(test^u % n == 1,
        printf(blue("%d is a strong liar for %d\n"), test, n);
        printf(blue("reason: %d ^ %d  == 1 modulo(%d)\n"), test, u, n);
        found = 1;
        return;
    );

    for(k=0, r-1,
        if(test^(2^k * u) % n == (n-1),
            printf(blue("%d is a strong liar for %d\n"), test, n);
            printf(blue("%d^(2^%d * %d) \= -1 modulo(%d)\n"), test, k, u, n);
            found = 1;
            break;
            return;
        );
    );
    if (!found,

    printf(red("%d is not a strong liar for %d\n"), test, n);
    printf(red("%d ^ %d != 1 (mod %d)\nAND  %d^(2^k * %d) != -1 (mod %d) for a k {0..%d}"), 
    test, u, n,test, u , n, r-1);
    );
}
