from random import randint

NUM_RANGE = (0, 10000)
BASE_RANGE = (2, 10)

####################################

NUM_CASES = 20

TEST_CASE_FORMAT = """
case = Test %d
input = %s
output = %s
"""

####################################


def base10toN(num, base):
    """Change ``num'' to given base
    Upto base 36 is supported."""

    converted_string = ""
    currentnum = num
    if not 1 < base < 37:
        raise ValueError("base must be between 2 and 36")
    if not num:
        return '0'
    while currentnum:
        mod = currentnum % base
        currentnum = currentnum // base
        converted_string = chr(48 + mod + 7*(mod > 10)) + converted_string
    return converted_string


for i in range(1, 1+NUM_CASES):

    num = randint(*NUM_RANGE)
    base = randint(*BASE_RANGE)

    inp = "%d\n%d" % (num, base)
    out = base10toN(num, base)[::-1]

    # Quick check
    assert str(base) not in out

    print(TEST_CASE_FORMAT % (i, inp, out))
