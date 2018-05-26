
from random import randint

NUM_CASES = 5

RANGE_OF_NUMBERS = (-9000, 9000)

TEST_CASE_FORMAT = """
case = Test %d
grade reduction = 100%%
input = %s
output = %d
"""

for i in range(1, 1+NUM_CASES):

    five_random = [randint(*RANGE_OF_NUMBERS) for _ in range(5)]

    inp = "\n".join(map(str, five_random))
    out = sum(five_random)

    print(TEST_CASE_FORMAT % (i, inp, out))
