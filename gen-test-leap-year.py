from random import randint
import calendar

RANGE_OF_YEARS = (1000, 4000)
CORRECT_RANGE = (1500, 3000)

####################################

NUM_CASES = 15

TEST_CASE_FORMAT = """
case = Test %d
input = %d
output = %s
"""

####################################


for i in range(1, 1+NUM_CASES):

    year = randint(*RANGE_OF_YEARS)

    if year not in range(*CORRECT_RANGE):
        out = "It is not in range."
    else:

        if calendar.isleap(year):
            out = "It is a leap year."
        else:
            out = "It is not a leap year."

    print(TEST_CASE_FORMAT % (i, year, out))
