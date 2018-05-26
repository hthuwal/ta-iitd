import random

# Used to run the object file
from subprocess import Popen, PIPE, TimeoutExpired

NUM_CASES = 50

SOURCE_FILE_NAME = "himanshu_factors.c"
OBJECT_FILE_NAME = "./to_test"

random.seed(9001003)


def print_comment(s):
    print('Comment :=>> ' + s)


def print_grade(num):
    print('Grade :=>> ' + str(num))

############################################
# Core logic!
#
# This will be different for every problem #
############################################

MAX_NUMBER = 10000
RANGE_OF_NUMBERS = (2, MAX_NUMBER)


isPrime = [i for i in range(0, MAX_NUMBER)]


def sieve():
    isPrime[1] = 0
    for i in range(2, MAX_NUMBER):
        if isPrime[i]:
            for j in range(2 * i, MAX_NUMBER, i):
                isPrime[j] = 0


def get_factors(n):
    factors = [i for i in range(1, n + 1) if n % i == 0]
    primeFactors = [factor for factor in factors if isPrime[factor]]
    primeFactorization = []
    for prime in primeFactors:
        x = n
        while x % prime == 0:
            primeFactorization.append(prime)
            x = x / prime

    return factors, primeFactorization

sieve()  # sets nonprime in isPrime as 0

###############################################
# Check for printf etc. based cheating
###############################################

with open(SOURCE_FILE_NAME) as f:
    src = f.read()
    if src.count("printf") > 10:
        print_comment("This has >10 printfs")

###############################################
# Test the object file
###############################################

# For timeouts: https://stackoverflow.com/a/10012262

total_grade = 0
grade_per_case = 100 / NUM_CASES

PRINTED_1, PRINTED_2 = False, False


def num_list(s):
    return [
        int(num)
        for num in s.split()
        if num.strip()
    ]


for i in range(1, 1 + NUM_CASES):

    # This will change too
    num = random.randint(*RANGE_OF_NUMBERS)
    inp = str(num)

    factors, prime_factors = get_factors(num)

    # This will stay the same
    process = Popen([OBJECT_FILE_NAME], stdin=PIPE, stdout=PIPE, stderr=PIPE)

    try:
        stdout, stderr = process.communicate(input=inp.encode(), timeout=0.5)
        stdout = stdout.decode().strip()
        stderr = stderr.decode().strip()
    except TimeoutExpired:
        print("Program timed out for input number: %d\n" % num)
        continue

    # Might need to be changed per question
    lines = list(map(lambda s: s.strip(), stdout.split("\n")))
    lines += ["", ""]

    if num_list(lines[0]) == factors:
        total_grade += grade_per_case / 4.0
    elif i < 10:
        print("Incorrect factors printed for input number: %d\n" % num)
    elif not PRINTED_1:
        PRINTED_1 = True
        print("Incorrect factors printed for some input\n")

    if num_list(lines[1]) == prime_factors:
        total_grade += 3 * (grade_per_case / 4.0)
    elif i < 10:
        print("Incorrect prime factors printed for input number: %d\n" % num)
    elif not PRINTED_2:
        PRINTED_2 = True
        print("Incorrect prime factors printed for some input\n")

print_grade(int(total_grade))
