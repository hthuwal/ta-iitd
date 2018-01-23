from random import randint

NUM_CASES = 50
NUM_RANGE = (1, 15)

for i in range(0, NUM_CASES):
    amt = randint(*NUM_RANGE)
    a = randint(*NUM_RANGE)
    b = randint(*NUM_RANGE)
    c = randint(*NUM_RANGE)
    d = randint(*NUM_RANGE)
    f = randint(0, 1)
    print amt, a, b, c, d, f
