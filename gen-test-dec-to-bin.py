from random import randint

RAND_RANGE = (-100, 300)
CORRECT_RANGE = (0, 256)

####################################

NUM_CASES = 20

TEST_CASE_FORMAT = """
case = Test %d
input = %d
output = "%s"
"""

####################################


for i in range(1, 1+NUM_CASES):

    inp = randint(*RAND_RANGE)

    if inp not in range(*CORRECT_RANGE):
        out = "It is not in range"
    else:
        binary = "{0:08b}".format(inp)
        out = " ".join(binary)

    print(TEST_CASE_FORMAT % (i, inp, out))
