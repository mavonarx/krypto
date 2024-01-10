red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
print("Miller Rabin: Usage MillerRabin(n) or MillerRabin(n, max_a)");


MillerRabin(n, end=n-2) = {
    if (n%2==0, print("Miller rabins not suited for even numbers"); return);
    my(factors, r, k,k_array,lowerbound,upperbound);
    factors = factor(n-1);
    r = factors[1,2]; \\ first factor is always 2, second part of the array it the exponent of 2
    printf("r = %d\n",r);
    u = (n-1) / (2^r);
    printf("u = %d\n",u);

    for (a=2, end,
        printf("------ a = %d --------\n", a);
        \\if (gcd(a,n)!=1, printf(red("n is not prime since %d is a divider of %d\n"),a,n ); return); \\ filter all numbers which are not in zn %
        if (a^(u) %n == 1, 
            printf(green("Case_1: %d ^(%d) %% %d == 1, k = %d\n"),a, u, n, k); next);
        \\if (a^(2^((r-1)*u)) %n != 1, printf(red("%d is composed because %d ^(%d-1) != 1\n"),n, a, r); return);
        upperbound = r;
        lowerbound = 0;
        if (upperbound == lowerbound, next); \\ wurde bereits mit a^u kontrolliert. entspricht k=0
        while (true,
            \\ integer division
            k_array = divrem(lowerbound + upperbound+1,2); 
            k = k_array[1];
            
            if (a^(2^k*u) %n ==n-1, 
                printf(blue("Case_2: found with k = %d\n"),k);
                break;) ;\\ continues to the next a
                printf("k now at = %d\n", k
            );
            if (a^(2^k * u) %n > 1, 
                lowerbound = k;
                printf("increasing lowerbound to %d\n", k);
                if (a^(2^(k+1)*u) %n == n-1, 
                    printf(blue("a^(2^k * u) %% n == -1\n"));
                    printf(blue("%d^(2^%d * %d) %% %d == -1\n"),a,k,u,n);
                    break;
                );
            );

            if (a^((2^k) * u) %n == 1, 
                upperbound = k;
                printf("decreasing upperbound to %d\n", k);
                if (a^(2^(k-1)*u) %n == n-1,
                    printf(blue("a^(2^k * u) %% n == -1\n"));
                    printf(blue("%d^(2^%d * %d) %% %d == -1\n"),a,k,u,n);
                    break;
                );
            );

            if (upperbound - lowerbound <= 1, 
                printf(red("%d is not prime because -1 is not found for any k\n"), n);
                return;
            );
        );
    );
    if (end == n-2,
        printf("Miller Rabin tests says: %d is definetly prime\n", n);,
        printf("Miller Rabin tests says: %d is probably prime\n", n);
    );
}

