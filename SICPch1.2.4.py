#-*-coding:utf8;-*-

"""
;;; SICP ch1.2.4 PY Exponentiation: recursive, iterative, O(logn)-recursive, O(logn)-iterative
"""
def exp_recur(b, n):
    if n == 0: return 1
    return b * exp_recur(b, n-1)
def exp_iter(b, n):
    res = 1
    while n > 0:
        res *= b
        n -= 1
    return res
def fast_exp_recur(b, n):
    if n == 0: return 1
    elif n%2 == 0: return fast_exp_recur(b,n//2)**2
    else: return b*fast_exp_recur(b,n//2)**2
def fast_exp_iter(b, n, a=1):
    while n != 0:
        if n%2 != 0: a *= b
        b **= 2
        n //= 2
    return a
for i in [exp_recur, exp_iter, fast_exp_recur, fast_exp_iter]:
    for j in range(10):
        print(f"{i.__name__}(2, {j}) = {i(2, j)}")
    print()



