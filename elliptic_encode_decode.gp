red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
green(s) = { return(concat("\e[32m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("Usage Encode(a,b,p,shift,m)  y^2 = x^3 + a*x + b in GF(p)");

Encode(a,b,p,shift,m) = {
  my(x,m_curr);
  m_curr = m * 2^shift;
  printf("%d * 2^%d = %d\n", m, shift, m_curr);
  found = 0;
  counter = 1;
  while (!found,
    curr = m_curr^3 + a * m_curr + b;
    printf("Versuch %d\n", counter);
    curr = curr % p;
    printf("curr = %d^3 + %d * %d + %d %% %d = %d\n", m_curr, a, m_curr, b, p, curr);
    iferr(root_my = lift(Mod(curr,p)^(1/2)); found = 1;
          printf(green("%d does have a sqare root in Z%d\*\n"), curr,p);
          printf(green("sqrt(%d) \= y = %d\n"), curr,root_my);
          printf(green("x = %d, y = %d\n"), m_curr, root_my);
          printf(green("M = (%d, %d)\n"), m_curr, root_my);
          break;, 
      E, 
      m_curr = m_curr+1;
      if(!found, 
        printf(red("%d does not have a sqare root in Z%d*!\n"), curr,p);
        );
    );
    counter = counter+1;
    );
    
}

