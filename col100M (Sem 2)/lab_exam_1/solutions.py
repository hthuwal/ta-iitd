def num_ways(amount, coins, i):

    if amount == 0:
        return 1

    if amount < 0 or i >= len(coins):
        return 0

    return num_ways(amount, coins, i+1) + num_ways(amount - coins[i], coins, i)