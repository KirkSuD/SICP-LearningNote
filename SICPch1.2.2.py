#-*-coding:utf8;-*-

"""
;;; SICP ch1.2.2 ex1.10 PY Recursive(divide-and-conquer) count-change with trace
"""

COINS = [1, 5, 10, 25, 50]
SHOW_INFO = True
INDENT_SPACES = "  "
current_indent = 0

def count_change(amount):        
    def cc(amount, kinds_of_coins):
        global current_indent
        if SHOW_INFO:
            print(f"{INDENT_SPACES*current_indent}({amount}, {kinds_of_coins})")
        if amount == 0:
            res = 1
        elif amount < 0 or kinds_of_coins < 0:
            res = 0
        else:
            current_indent += 1
            
            res = cc(amount-COINS[kinds_of_coins], kinds_of_coins) + \
                  cc(amount, kinds_of_coins-1)
            
            current_indent -= 1
        return res
    return cc(amount, len(COINS)-1)

print(count_change(11))


