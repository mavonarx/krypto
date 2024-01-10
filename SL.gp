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

    if(test^u % n == (n-1),
        printf(blue("%d is a strong liar for %d\n"), test, n);
        printf(blue("test ^ %d  = -1 modulo(%d)\n"), test, n);
    );

    for(k=0, r-1,
        if(test^(2^k * u) % n == (n-1),
            printf(blue("%d is a strong liar for %d\n"), test, n);
            printf(blue("%d^(2^%d * %d) = -1 modulo(%d)"), test, k, u, n);
        );
    ):
    printf(red("%d is not a strong liar for %d"), test, n);
}