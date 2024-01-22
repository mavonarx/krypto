red(s) = { return(concat("\e[31m", concat(s, "\e[0m"))); }
blue(s) = { return(concat("\e[34m", concat(s, "\e[0m"))); }
print("Fermat-Liars: Usage FL(n)");

FL(n) = {
  for(a=1, n-1,
    if(gcd(a,n)== 1,
      if (a^(n-1) % n==1, 
      printf(blue("%d is a fermat liar of %d -> because %d^(%d -1) %% %d = 1 \n"),a,n, a, n,n), 
      \\printf(red("%d is not a fermat liar because %d^(n-1) mod n is not 1\n"),a,a)
      ) 
    )
  );
  print("Fermat-Liars are Numbers element Z*: a^(n-1) \= 1 (mod n)")
}

FL_debug(n) = {
  for(a=1, n-1,
    if(gcd(a,n)== 1,
      if (a^(n-1) % n==1, 
      printf(blue("%d is a fermat liar of %d!\n"),a,n), 
      printf(red("%d is not a fermat liar because %d^(n-1) mod n is not 1\n"),a,a)
      ) 
    )
  );
}



