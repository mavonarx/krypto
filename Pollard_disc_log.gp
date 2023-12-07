red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("DISCRETE LOG: \=> Pollard_disc_log(a,g,p,g1_low, g1_up, g2_low, g2_up, g3_low, g3_up)");

Pollard_disc_log(a,g,p,g1_low, g1_up, g2_low, g2_up, g3_low, g3_up) = {
    my(x, r, s, r_t, s_t);

    l_g1 = g1_up-g1_low +1;
    l_g2 = g2_up-g2_low +1;
    l_g3 = g3_up-g3_low +1; 
    g1 = vector(l_g1);
    g2 = vector(l_g2);
    g3 = vector(l_g3);

    for (i = 1,l_g1, 
        g1[i]= g1_low + (i-1);
    );
    for (i = 1,l_g2, 
        g2[i]= g2_low + (i-1);
    );
    for (i = 1,l_g3, 
        g3[i]= g3_low + (i-1);
    );

    printf("x_i\t\t| r\ts\t|\t|G_i\n");

    
    r_vec = vector(1000);
    s_vec = vector(1000);
    x_vec = vector(1000);

    r = 0;
    s = 0;
    x = 1;
    
    x_vec[1] = x;
    r_vec[1] = r;
    s_vec[1] = s;
    
    count = 0;
    end =0;
    while(end == 0 && count <988,
        printf("x_%d\t",count);
        printf("= %d\t",x_vec[count+1]);
        printf("| %d\t",r_vec[count+1]);
        printf("%d\t|",s_vec[count+1]);
        
        \\ check which group
        for (i = 1,l_g1, 
            if (x_vec[count+1] == g1[i],
                printf("Element G1 => calculate x");
                printf(blue(" = x * a\n"));
                printf("------------------------------------------------------------------------------\n");
                r_vec[count+2] = r_vec[count+1]+1;
                s_vec[count+2] = s_vec[count+1];
                x_vec[count+2] = (x_vec[count+1] * a) % p;
                break;
            );
        );
        for (i = 1,l_g2, 
            if (x_vec[count+1] == g2[i],
                printf("Element G2 => calculate x");
                printf(blue(" = x^2\n"));
                printf("------------------------------------------------------------------------------\n");
                r_vec[count+2] = r_vec[count+1]*2;
                s_vec[count+2] = s_vec[count+1]*2;
                x_vec[count+2] = (x_vec[count+1])^2 % p;
                break;
            );
        );
        for (i = 1,l_g3, 
            if (x_vec[count+1] == g3[i],
                printf("Element G3 => calculate x");
                printf(blue(" = x * g\n"));
                printf("------------------------------------------------------------------------------\n");
                r_vec[count+2] = r_vec[count+1];
                s_vec[count+2] = s_vec[count+1]+1;
                x_vec[count+2] = (x_vec[count+1] * g) % p;
                break;
            );
        );

        \\ search for collisions
        for (i  = 1, count+1,
            if (x_vec[i] == x_vec[count+2],
                printf("x_%d\t",count+1);
                printf(red("= %d\t"),x_vec[count+2]);
                printf("| %d\t",r_vec[count+2]);
                printf("%d\t|",s_vec[count+2]);
                printf(red("COLLISION\n"));
                printf(green("\nCOLLISION FOUND! : %d \n"), x_vec[i]);
                r = r_vec[i];
                s = s_vec[i];
                r_t = r_vec[count+2];
                s_t = s_vec[count+2];
                printf(blue("r   = %d\ns =   %d\nr_t = %d\ns_t = %d\n"),r,s,r_t, s_t);
                
                printf("a^r * g^s = a^r_t * g^s_t\n");
                printf("a^(r_t -r) \= g^(s-s_t)\n");
                printf("%d^(%d - %d) \= %d^(%d-%d)\n",a,r_t,r,g,s,s_t);
                printf("Exponent_a:  %d, Exponent_g: %d\n", r_t -r, s-s_t);
                printf("From now on we only care about exponents!\n");
                printf(green("Linear_mod_equation: %dx = %d (mod %d)\n\n"), r_t-r, s-s_t, p-1);
                sol_vec = Linear_mod_eq(r_t-r, s-s_t, p-1);

                printf("Now which of those solutions maches the discrete log?\n");
                for (i = 1, #sol_vec,
                    solution = (g^sol_vec[i])%p;
                    if (solution == a, 
                        printf(green("%d fullfills disc. log\n"),sol_vec[i] );
                        printf(green("log_%d(%d) \= %d\n"),g,a,sol_vec[i]);
                        break;
                        ,
                        printf(red("%d does not fullfill disc. log\n"), sol_vec[i]);
                    );
                    
                );

                end = 1;
            );
        );

        count++;
    );
}

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

    sol_vec = vector(d);
    for (i = 0, d-1,
        sol = x + i * n_small;
        sol_vec[i+1] = sol;
        printf(green("x_%d = %d + %d * %d %% %d = %d \n"),i, x, i, n_small, n, sol);
    );
    return (sol_vec);
}
