blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
print("Diffie-Hellman: Usage DiffieHellman_ellipt(z_x, z_y,a,b,g, key_Alice, key_Bob)");

DiffieHellman_ellipt(z_x, z_y, a, b, g, key_Alice, key_Bob) = {
    my(A, B, E);
    E = ellinit([a,b], g);
    A = ellmul(E,[z_x, z_y],key_Alice);
    B = ellmul(E, [z_x, z_y], key_Bob);
    Key = ellmul(E, B, key_Alice);
    print(Key);
}
