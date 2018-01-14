from random import randint

NUM_RANGE = (-10000, 10000)
BASE_RANGE = (-10, 20)

####################################

NUM_CASES = 100

TEST_CASE_FORMAT = """
case = Test %d
input = %s
output = \"%s\"
"""

####################################


def base10toN(num, base):
    """Change ``num'' to given base
    Upto base 36 is supported."""

    converted_string = ""
    currentnum = num
    if not 1 < base < 17:
        raise ValueError("base must be between 2 and 36")
    if not num:
        return '0'
    while currentnum:
        mod = currentnum % base
        currentnum = currentnum // base
        converted_string = chr(48 + mod + 7 * (mod >= 10)) + converted_string
    return converted_string


for i in range(1, 1 + NUM_CASES):
    inp = ''
    out = ''

    num = randint(*NUM_RANGE)
    while num < 1:
        inp += "%d\n" % (num)
        out += "Input number not in range, please enter again\n"
        num = randint(*NUM_RANGE)
    inp += "%d\n" % (num)

    base = randint(*BASE_RANGE)
    while base < 2 or base > 16:
        inp += "%d\n" % (base)
        out += "Input base not in range, please enter again\n"
        base = randint(*BASE_RANGE)
    inp += "%d" % (base)

    out += base10toN(num, base)[::-1]

    # Quick check
    # assert str(base) not in out

    print(TEST_CASE_FORMAT % (i, inp, out))
