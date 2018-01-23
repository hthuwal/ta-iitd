import sys


def num_ways(amnt, coins, string):
    '''
    Solution to part (a) -- number of ways in which coins a, b, c, d can be used to
    create amount amt. k is the parameter that controls which of a, b, c, d are
    available - required since they cannot use lists.
    '''
    if amnt == 0:
        print string
        return 1
    else:
        ways = 0
        for i, coin in enumerate(coins):
            if (amnt >= coin):
                ways += num_ways(amnt-coin, coins, string+str(coin)+" ")
        return ways


if __name__ == '__main__':
    coins = [1, 2, 3, 4]
    print num_ways(4, coins, "")

