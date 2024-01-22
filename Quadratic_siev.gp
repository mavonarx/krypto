red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }

\\ description needed

Quadratic_sieve(n, F, S) = {
    m = floor(sqrt(n));
    for(s = 1, #S,
        q = Qx(S[s], m, n);
        factors = factor(q);
        
        found = 0;
        for(f = 1, #factors[, 1],
            if((inList(F, factors[f,1]) != 0),
                found =found + 1,
                break;
            );
        );
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