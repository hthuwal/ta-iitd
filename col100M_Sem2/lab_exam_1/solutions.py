OCAML_MAX = 4611686018427387903


def num_ways(amount, coins, i):

    if amount == 0:
        return 1

    if amount < 0 or i >= len(coins):
        return 0

    return num_ways(amount, coins, i+1) + num_ways(amount - coins[i], coins, i)


def min_count(amount, coins, i, func):
    if amount == 0:
        return 0

    if amount < 0 or i >= len(coins):
        return OCAML_MAX

    ans1 = min_count(amount - coins[i], coins, i, func)
    if ans1 != OCAML_MAX:
        ans1 += func(coins[i])
    return min(ans1, min_count(amount, coins, i+1, func))


if __name__ == '__main__':
    f = open("in.txt")
    lines = f.readlines()
    for line in lines:
        line = map(int, line.split())
        amount = line[0]
        coins = line[1:5]
        func = line[5]
        if func == 0:
            print num_ways(amount, coins, 0), min_count(amount, coins, 0, (lambda x: 2*x))
        else:
            print num_ways(amount, coins, 0), min_count(amount, coins, 0, (lambda x: 100-x))
