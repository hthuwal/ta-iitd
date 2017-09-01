from random import randint
from calendar import isleap
from math import sqrt

NUM_CASES = 100
MAX_NUMBER = 1000000
RANGE_OF_NUMBERS = (2, MAX_NUMBER)

TEST_CASE_FORMAT = """
case = Test %d
input = %s
output = \"%s\"
"""

isPrime = [i for i in range(0, MAX_NUMBER)]


def sieve():
    isPrime[1] = 0
    for i in range(2, MAX_NUMBER):
        if isPrime[i]:
            for j in range(2 * i, MAX_NUMBER, i):
                isPrime[j] = 0


def get_factors(n):
    factors = [i for i in range(1, n + 1) if n % i == 0]
    primeFactors = [factor for factor in factors if isPrime[factor]]
    return factors, primeFactors


sieve()  # sets nonprime in isPrime as 0

for i in range(1, 1 + NUM_CASES):

    num = randint(*RANGE_OF_NUMBERS)
    factors, primeFactors = get_factors(num)
    out = ", ".join(map(str, factors)) + "\n"
    out += ", ".join(map(str, primeFactors))
    inp = str(num)
    print(TEST_CASE_FORMAT % (i, inp, out))
