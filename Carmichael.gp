red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("Carmichael numbers: Usage Carmichael(n)");


Carmichael(n) = {
    if (n<3, print("numbers smaller 3 are not carmichael numbers"));
    my(factors, len, curr);
    factors = factor(n);
    len = #factors[,1];
    for(i = 1, len,
        curr = factors[i,2];
        if (curr>1, 
        printf(red("n is not square-free (%d ^ %d)\n%d is not Carmichael!\n"),factors[i,1],factors[i,2],n); return;
        ) 
    );
    printf(blue("%d factorized is square free!\n"), n);
    
    printf(blue("check for every primefactor => (p-1) | (n-1)\n"));
    for (i= 1, len,
        curr = factors[i,1];
        if (curr==1, continue);
        if (gcd(curr-1,n-1)!=curr-1,
        printf(red("%d -1 is not a divider of %d -1, \n%d is not Carmichael!\n"), curr, n, n); return;
        ,printf(blue("%d -1 is a divider of %d -1\n"), curr, n);
        );
    );
    printf(blue("%d is a Carmichael number\n"), n);
}

