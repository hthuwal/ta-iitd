import sys


def num_ways(amount, coins, i):

    if amount == 0:
        return 1

    if amount < 0 or i >= len(coins):
        return 0

    return num_ways(amount, coins, i+1) + num_ways(amount - coins[i], coins, i)


def min_count(amount, coins, i):
    if amount == 0:
        return 0

    if amount < 0 or i >= len(coins):
        return sys.maxsize

    ans1 = min_count(amount - coins[i], coins, i)
    if ans1 != sys.maxsize:
        ans1 += 1
    return min(ans1, min_count(amount, coins, i+1))
