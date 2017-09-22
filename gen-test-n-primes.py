from random import randint
from itertools import count, islice

NUM_RANGE = (-2000, 5000)

####################################

NUM_CASES = 50

TEST_CASE_FORMAT = """
case = Test %d
input = %s
output = "%s"
"""

####################################


# ideone.com/aVndFM
def postponed_sieve():                   # postponed sieve, by Will Ness
    yield 2
    yield 3
    yield 5
    yield 7  # original code David Eppstein,
    sieve = {}  # Alex Martelli, ActiveState Recipe 2002
    ps = postponed_sieve()               # a separate base Primes Supply:
    p = next(ps) and next(ps)            # (3) a Prime to add to dict
    q = p*p                              # (9) its sQuare
    for c in count(9, 2):                 # the Candidate
        if c in sieve:               # c's a multiple of some base prime
            s = sieve.pop(c)  # i.e. a composite ; or
        elif c < q:
            yield c                 # a prime
            continue
        else:   # (c==q):            # or the next base prime's square:
            s = count(q+2*p, 2*p)  # (9+6, by 6 : 15,21,27,33,...)
            p = next(ps)  # (5)
            q = p*p  # (25)
        for m in s:                  # the next multiple
            if m not in sieve:       # no duplicates
                break
        sieve[m] = s                 # original test entry: ideone.com/WFv4f


for i in range(1, 1+NUM_CASES):

    inp = ''
    out = ''

    num = randint(*NUM_RANGE)
    while num <= 0:
        inp += "%d\n" % (num)
        out += "Input number is negative, please enter again\n"
        num = randint(*NUM_RANGE)
    inp += "%d" % (num)

    primes = list(islice(postponed_sieve(), num))
    primes = ", ".join(map(str, primes))

    out += "The first %d prime numbers are: " % num + primes

    print(TEST_CASE_FORMAT % (i, inp, out))
