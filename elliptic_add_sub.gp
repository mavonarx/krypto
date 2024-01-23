red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("P+Q => Usage Elliptic_add(px,py,qx,qy,a,{mod})");
print("P-Q => Usage Elliptic_sub(px,py,qx,qy,a,{mod})");
print("if no mod is given the real numbers are chosen as a field");
printf(blue("4a^3 + 27b^2 != 0\n"));
printf(blue("y^2 = x^3 + ax + b\n"));

Elliptic_add(px,py,qx,qy,a,mod=-1) = {
    \\ if mod is -1 (default) then the Field of the real numbers is chosen
    my(m, x, y, inv, invi);
    printf(red("attention! this script cannot handle (Q + O) \= Q   or   (P + O) \= P\n"));
    if (mod ==-1, 
        \\ case a
        if (qx !=px,
            print("case a");
            m = 1.0 *(1.0*qy - 1.0*py) / (qx* 1.0 -px*1.0);
            printf(blue("m = (qy - py) / qx - px  = %.8f\n"), m);
            printf(green("m = (%.8f - %.8f) / %.8f - %.8f  = %.8f\n"), qy,py,qx,px,m);
            x = m^2 - px -qx;
            printf(blue("x = m^2 - px -qx = %.8f\n"), x);
            printf(green("x = %.8f^2 - %.8f -%.8f = %.8f\n"), m,px,qx,x);

            y = -m * (x -px) -py;
            printf(blue("y = -m *(x -px) -py = %.8f\n"), y);
            printf(green("y = -%.8f *(%.8f -%.8f) -%.8f = %.8f\n"),m,x,px,py,y);
            printf(blue("(%.8f,%.8f)\n"),x, y); 
        );
        \\ case c
        if ((qx == px) && (py == (-qy % mod)),
            print("case c");
            printf(blue("Case c! P + Q = O, infinte distant point\n"));
            return;
        );
        \\ case b
        if (qx == px && py != 0 && px != 0,
            m = 1.0 *(3.0*(1.0*px^2) + a* 1.0) / (2.0*py);
            printf(blue("m = (3*(px^2) + a) / (2*py) \= %.8f\n"), m);
            printf(green("m = (3*(%.8f^2) + %.8f) / (2*%.8f) \= %.8f\n"), px,a,py,m);
            x = m^2 - (2*px);
            printf(blue("x = m^2 - 2 * px = %.8f\n"), x);
            printf(green("x = %.8f^2 - 2 * %.8f = %.8f\n"), m,px,x);
            y = -m * (x -px) -py;
            printf(blue("y = -m *(x -px) -py = %.8f\n"), y); 
            printf(green("y = -%.8f *(%.8f -%.8f) -%.8f = %.8f\n"),m,x,px,py,y);
            printf(blue("(%d,%d)\n"),x, y); 
        );
        
        
    );

    \\ GALLOIS FIELDS
    if (mod != -1,
        \\ case a
        if (qx !=px,
            print("case a");
            invi = lift(Mod((qx-px),mod)^-1);
            printf(blue("Inverse of qx-px is %d\n"),invi);
            m = ((qy - py) * lift(Mod((qx -px),mod)^-1)) % mod;
            printf(blue("m = (qy - py) * Mod((qx -px),mod)^-1) %% mod = %d\n"), m);
            printf(green("m = %d * %d %% %d = %d\n"), qy-py, invi, mod,m);
            x = (m^2 - px -qx) % mod;
            printf(blue("x = (m^2 - px -qx) %% mod = %d\n"), x);
            printf(green("x = (%d^2 - %d -%d) %% %d = %d\n"), m,px,qx,mod,x);

            y = (-m * (x -px) -py) % mod;
            printf(blue("y = (-m *(x -px) -py) %% mod = %d\n"), y);
            printf(green("y = (-%d *(%d -%d) -%d) %% %d = %d\n"), m,x,px,py,mod,y);
            printf(green("(%d,%d)\n"),x, y); 
        );
        if ((qx == px) && (py == (-qy % mod)),
            print("case c");
            printf(blue("Case c! P + Q = O, infinte distant point\n"));
            return;
        );

        \\case b
        if (qx == px && py != 0 && qy != 0,
            print("case b");
            m = ((3*(px^2) + a) * lift(Mod((2*py), mod)^-1)) % mod;
            printf(blue("m = ((3*(px^2) + a) * Mod((2*py),mod)^-1) %% mod = %d\n"), m);
            printf(green("m = ((3*(%d^2) + %d) * Mod((2*%d),%d)^-1) %% %d = %d\n"), px,a,py,mod,mod,m);
            x = (m^2 - (2*px)) % mod;
            printf(blue("x = (m^2 - 2*px) %% mod = %d\n"), x);
            printf(green("x = (%d^2 - 2*%d) %% %d = %d\n"), m,px,mod,x);
            y = (-m * (x -px) -py) % mod;
            printf(blue("y = (-m *(x -px) -py) %% mod = %d\n"), y); 
            printf(green("y = (-%d *(%d -%d) -%d) %% %d = %d\n"), m,x,px,py,mod,y);
            printf(green("(%d,%d)\n"),x, y); 
        );
        
    );
    
}

Elliptic_sub(px,py,qx,qy,a,mod=-1) = {

    \\ modular case
    if (mod !=1, 
        printf(blue("invert (Addition) Q => (%d, %d)\n"), qx, -qy);
        printf(blue("which is the same as => (%d, %d) \= -Q\n"), qx, lift(Mod(-qy,mod)));
        qy = lift(Mod(-qy,mod));
        printf(blue("now perform normal addition (%d, %d) + (%d, %d)\n"),px,py,qx,qy);
        Elliptic_add(px,py,qx,qy,a,mod);
    ); 

    if (mod == 1, 
        printf(blue("invert Q to (%d, %d)\n"), qx, -qy);
        printf(blue("now perform normal addition\n"));
        qy = -qy;
        Elliptic_add(px,py,qx,qy,a,mod);
    );

}
