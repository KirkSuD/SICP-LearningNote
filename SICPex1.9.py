#-*-coding:utf8;-*-

"""
;;; SICP ex1.9 PY Iterative count-change
"""

"""
def count_change(res,amount,current_coin,coins):
    #print(res,amount,current_coin,coins)
    if amount < 0:
        if coins[current_coin]==0:
            return count_change(res,amount,current_coin-1,coins)
        elif current_coin==0:
            return res
        else:
            amount = amount + amount_list[current_coin]*coins[current_coin] - amount_list[current_coin-1]
            coins[current_coin] = 0
            coins[current_coin-1] += 1
            return count_change(res,amount,4,coins)
    else:
        if amount==0:
            res+=1
            print(coins)
        coins[current_coin]+=1
        return count_change(res,amount-amount_list[current_coin],current_coin,coins)
"""
def count_change(res,amount,current_coin,coins):
    while True:
        #print(res,amount,current_coin,coins)
        if amount < 0:
            if coins[current_coin]==0:
                current_coin-=1
            elif current_coin==0:
                return res
            else:
                amount += amount_list[current_coin]*coins[current_coin] - amount_list[current_coin-1]
                coins[current_coin] = 0
                coins[current_coin-1] += 1
                current_coin=4
        else:
            if amount==0:
                res+=1
                #print(coins)
            coins[4]+=1#coins[current_coin]+=1
            amount-=amount_list[4]#amount-=amount_list[current_coin]
amount_list=[50,25,10,5,1]
for i in range(101):
    print(i,count_change(0,i,4,[0,0,0,0,0]))

    


