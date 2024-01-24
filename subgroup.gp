print("Usage subgroup(x,z) \n where x = element of gruop z* to see the elemtents and cardinality of z14*");
subgroup(x,z) = {
my(a,count);
a = x;
count = 1;
printf("%d ", a);
while (a != 1, \
a = (a * x) % z;\
count++;\
printf("%d ", a);\
);
printf("\nThe cardinality of the subgroup is: %d\n", count);
if (count == z -1, 
  printf("%d is a generator of Z%d*\n",x,z) 
  );
}

