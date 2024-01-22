red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
print("DiscreteLogTable: Usage DiscreteLogTable(log_base,mod)");

DiscreteLogTable(base, p) = {
    my(max, a, erzeugendes);
    max = 10;
    erzeugendes =1;
    printf("\n%s%7s%s",,"a = ", "", "|");
    for (a = 1, p-1,
            printf("%-12d%s", a, "|");
    );
    printf("\n");
    for (a = 1, p-1, 
        printf("%-12s", "---------------");
    );
    printf("\n");
    lo = concat("log", base);
    lo = concat(lo, " =");
    printf("%-11s%s",lo "|");

    for (a = 1, p-1, 
        vals = "";
        for (res = 1, p-1, 
            
            if (base^res %p == a,
                    vals = concat(vals, Str(res));
                    vals = concat(vals, " ");
            );
        );
        if (vals == "", erzeugendes = 0);
        printf("%-12s%s", vals, "|");
    );
    printf("\n%d is ", base );
    if (erzeugendes == 0, 
        printf(red("not"));, 
        printf(green("indeed"));

    );
    printf(" a generator of Z%d*", p,);
}

