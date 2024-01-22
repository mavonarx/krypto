red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
print("FACORING: Pollard_roh: Usage Pollard_roh(n, x0, a)");

Pollard_roh(n, x, a) = {
    my(y0);
    y = x;
    if(a %n ==0|| a %n  == -2 %n, 
        printf(red("a should not be 0 or -2!\n"));
        return;       
    );
    printf("x0 = %d\ny0 = %d\n\n", x,y);
    found = 0; 
    for (i = 1, n,
        
        x_before = x;
        y_before = y;
        x = (x^2 + a) % n ;
        y = ((y^2 + a) ^2 + a) % n;
        printf("x%d = (%d^2 + %d) %% %d = %d\n", i, x_before, a, n,x);
        printf("y%d = (%d^2 + %d) %% %d = %d\n\n" , i, y_before, a, n,y);

        d = gcd(x-y , n);
        if (d > 1 && d < n, 
            printf(green("%d is a factor of %d\n"), d,n);
            found= 1;
            return d;
            print("continue? y/N");
            g = input();
            if(g != y,
                break;
            )
        );
    );

    if (found==0, 
        printf(red("No factor of %d found - could be prime\n"), n);
    );
}
