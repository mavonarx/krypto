red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("log_g(a) in Zp => Usage: Baby_Giant(a,g,p)");

Baby_Giant(a,g,p) = {
    my(m);
    printf("\n------ Precalculations--------\n");
    m = ceil(sqrt(p-1)); 
    printf(blue("m = ceil(sqrt(p-1)) \= %d \n"),m );
    h = g^(-m) % p;
    printf(blue("h = g^-m %% p = %d\n"), h);
    printf("------------------------------\n");

    babyVals = vector(m+1);

    printf("BABY \n");
    printf("j\t");
    for (i = 0, m,
        printf("\t|");
        printf("%d\t", i);
    );
    printf("\n");
    
    printf("g^j\t");
    for (i = 0, m,
        printf("\t|");
        printf("%d\t", (g^i)%(p));
        babyVals[i+1] = (g^i) % (p);
    );
    printf("\n\n");

    printf("GIANT \n");
    printf("i\t");
    for (i = 0, m,
        printf("\t|");
        printf("%d\t", i);
    );
    printf("\n");

    printf("a * h^i\t");

    end = 0;
    for (i = 0, m,
        if ( end == 1,
            break;
        );
        printf("\t|");
        printf("%d\t", (a* h^i)%(p));
        
        for (j = 0,m,
            if (babyVals[j+1] == (a*h^i) % (p),
                end = 1;
                printf(green("\nCOLLISION FOUND = %d\n"), babyVals[j+1]);
                printf(blue("i = %d, j = %d\n"), j, i);
                x = (i * m + j) % p; 
                printf(blue("x = (i * m + j) %% p = (%d * %d + %d) %% %d = %d"), i,m,j,p,x);
                break;
            );

        );
    );
    printf("\n");

}
