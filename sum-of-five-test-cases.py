from random import randint

RANGE = (-9000, 9000)

NUM_CASES = 5

TEST_CASE_FORMAT = """
case = Test %d
grade reduction = 100%%
input = %s
output = %d
"""

for i in range(1, 1+NUM_CASES):

    five_random = [randint(*RANGE) for _ in range(5)]

    inp = "\n".join(map(str, five_random))
    out = sum(five_random)

    print(TEST_CASE_FORMAT % (i, inp, out))
