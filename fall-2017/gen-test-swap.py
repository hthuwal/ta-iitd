from random import randint

RANGE = (-9000, 9000)

####################################

NUM_CASES = 15

TEST_CASE_FORMAT = """
case = Test %d
input = %s
output = %s
"""

####################################


for i in range(1, 1+NUM_CASES):

    a, b = randint(*RANGE), randint(*RANGE)

    inp = " ".join(map(str, [a, b]))
    out = " ".join(map(str, [b, a]))

    print(TEST_CASE_FORMAT % (i, inp, out))
