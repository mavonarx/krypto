print("Usage MyZn(n)");

MyZn(n) = {
  for(a=1, n-1,
    if(gcd(a,n)== 1,
      printf("%d ",a), 
      ) 
  );
}

