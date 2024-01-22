red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("Tonelli x^2 = a mod (p): Usage Tonelli(a,p)");
print("Bestimmung einer Wurzel");

Tonelli(a,p) = {
    if (p <=2, 
        printf(red("p has to be bigger than 2\n"));
        return;
    );
    my(case, root, root2 , h, low_p, i, res, euler_crit, euler_crit_h);

    \\ check euler criterium first!
    euler_crit = (a^((p-1)/2)) % p;
    if (euler_crit == p-1, 
        printf(red("a = %d  doesnt have a root in Z%d*\n"), a, p);
        return;
    );

    if (euler_crit == 1, 
        printf(green("euler criterium fullfilled! (a^((p-1)/2)) %% p;\n"));
        printf(green("(%d^((%d-1)/2)) %% %d = %d\n"),a,p,p, euler_crit);
    );

    case = p % 4; 
    \\ check if the case is 
    \\p = 3 %4 or
    \\p = 1 %4
    root = 1;
    printf("Case p %% 4 = %d\n",case);
    if (case == 3,
        \\ true
        printf(green("a ^ ((p +1)/4)\n"));
        root = a ^((p+1)/4) %p;
        root2 = lift(Mod(-root,p));
        printf(green("%d ^ ((%d +1)/4)  \= %d is 1. root of %d in Z%d*\n"), a,p,root, a,p);
        printf(green("%d ^ ((%d +1)/4)  \= %d is 2. root (=> -%d) of %d in Z%d*\n"), a,p,root2,root, a,p);

        \\false => means it has to be the case 1 
        ,
        \\ case == 1
        \\ find a suiting h (which is not a square remainder)
        h = 2;

        while (true,
            euler_crit_h = (h^((p-1)/2)) % p;
            if (euler_crit_h == p -1,
                printf("found h = %d\n", h);
                printf("%d ^((%d-1/2)) \= -1\n", h,p);
                break;
            );
            h++;
        );

        exp_a = (p-1) / 2;
        exp_h = p-1;

        printf(red("exp_a = %d\n"), exp_a);
        printf(blue("exp_h = %d\n"), exp_h);
        i = 1;
        while(exp_a % 2 == 0,
            printf("%d. bisect\n", i);
            i++;
            exp_a /= 2;
            exp_h /= 2;
            printf(red("exp_a = %d\n"), exp_a);
            printf(blue("exp_h = %d\n"), exp_h);
            \\ check if there the product is -1 if yes we have to add to the exponent of h
            res = (a^(exp_a) * h^exp_h)%p;
            printf("Result of  a^(exp_a) * h^exp_h = %d\n", res);
            if (res == p-1,
                exp_h += (p-1)/2; \\ corresponds to a multiplication by -1
                printf(green("%d is equivalent to -1 %% %d-> need adjustment of exponent of h\n"), res,p);
                printf(green("Adjusted exp_h = %d (mult with -1)\n"), exp_h);
            );

        );

        printf(green("Found u = %d (exponent of a) and g = %d (exponent of h)\n"), exp_a, exp_h);
        root = (a^((exp_a +1)/2) * h^(exp_h /2)) %p;
        root2 = lift(Mod(-root,p)); 
        printf(green("%d ^((%d +1) / 2) * %d^(%d / 2) %% p\n"), a,exp_a, h, exp_h,p);
        printf(green("Found 1. root = %d\n"), root);
        printf(green("Found 2. root (=> -%d) \= %d\n"),root, root2);
        );

        printf("Check 1. root: %d^2 %% %d = %d\n", root, p, (root^2) % p);
        printf("Check 2. root: %d^2 %% %d = %d\n", root2, p, (root^2) % p);
}
