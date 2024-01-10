red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("Usage RSA: signature_rsa(e,d,n,m, signature_given) if e or d is not given set -1");

signature_elliptic() = {
}

signature_el_gamal() = {

}

signature_rsa(e=-1, d=-1, n, m, signature_given=-1) = {
    phi_n = eulerphi(n);
    if (e==-1 && d!=-1,
        e = lift(Mod(d,phi_n)^-1);
        printf(blue("e = Modinvers of d = %d\n"), e);
    );
    if (d==-1 && e!=-1,
        d = lift(Mod(e,phi_n)^-1);
        printf(blue("d = Modinvers of e = %d\n"), d);
    );

    signature = (m^d) % n;
    printf(green("Signature s = m^d %% n = %d^%d %% %d = %d\n"),m,d,n,signature);
    if (signature_given==-1,
        check = signature^e % n;
        printf("check = signature^e %%n = %d^%d %%n = %d\n", signature, e,n,check);
        if (check == m,
            printf(green("Signature is valid\n")),
            printf(red("Signature is not valid\n")),
        );,
        check = signature_given^e % n;
        printf("The given signature is: %d\n", signature_given);
        printf("check = signature_given^e %%n = %d^%d %%n = %d\n", signature_given, e,n,check);
        if (check ==m,
            printf(green("Signature is valid\n")),
            printf(red("Signature is not valid\n")),
        );
    );
}