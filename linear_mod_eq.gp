red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("ax = b (mod n) \=> Linear_mod_eq(a,b,n)");

Linear_mod_eq(a,b,n) = {
    a = a %n;
    b = b %n;
    my(x, a_small, b_small, n_small, z);
    d = gcd(a,n);
    \\ case 1
    if (d==1,
        x = (lift(Mod(a,n)^-1) * b) % n;
        printf(green("GCD(a,n) \= 1, Only 1 solution: x = %d \n"), x);
        return;
    );

    \\ check if d divides b
    if ( b % d != 0, 
        printf(red("GCD(a,n) \= d = %d does not divide b => No solution!\n"), d);
        return;
    );

    \\ here we are in the case that all three arguments are divided by d
    printf(green("GCD(a,n) \= d = %d does divide all three a,b,n => we got %d solutions!\n"), d, d);
    a_small = a / d;
    printf("a_small = %d / %d = %d\n", a,d,a_small);
    b_small = b / d;
    printf("b_small = %d / %d = %d\n", b,d,b_small);
    n_small = n / d;
    printf("n_small = %d / %d = %d\n", n,d,n_small);
    
    z = lift(Mod(a_small, n_small)^-1);
    printf("z = a_small ^-1 %% n_small = %d ^-1 %% %d = %d \n", a_small, n_small, z);
    x = z * b_small % n_small;
    printf("x = z * b_small %% n_small = %d * %d %% %d = %d\n", z,b_small, n_small,x);

    for (i = 0, d-1,
        sol = x + i * n_small;
        printf(green("x_%d = %d + %d * %d %% %d = %d \n"),i, x, i, n_small, n, sol);
    );


}
