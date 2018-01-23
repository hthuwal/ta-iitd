from random import randint

NUM_CASES = 50
NUM_RANGE = (1, 50)
NUM_RANGE2 = (1, 15)

for i in range(0, NUM_CASES):
    amt = randint(*NUM_RANGE)
    a = randint(*NUM_RANGE2)
    b = randint(*NUM_RANGE2)
    c = randint(*NUM_RANGE2)
    d = randint(*NUM_RANGE2)
    f = randint(0, 1)
    print amt, a, b, c, d, f
