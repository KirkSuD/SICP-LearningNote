#-*-coding:utf8;-*-

"""
;;; SICP ex1.15 PY GCD normal-order evaluation simulation
Result: O(nlogn) (O((logn)^n))
"""
arga, argb = "arga", "argb"
for i in range(5):
    print(f"""(if (= {argb} 0)
    {arga}
    (gcd
         {argb}
         (remainder {arga} {argb})))\n""")
    arga, argb = argb, f"(remainder {arga} {argb})"
print("0 0 0\n1 1 0")
a, b = 2, 1
for i in range(30):
    print(i+2,a,b,a/b)
    a,b = a+b+1, a
