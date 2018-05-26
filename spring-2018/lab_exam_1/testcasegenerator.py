from random import randint, sample

NUM_CASES = 100
NUM_RANGE = (-5, 50)
NUM_RANGE2 = (-5, 30)
count = 0;
i = 0

while i < NUM_CASES: 
    amt = randint(*NUM_RANGE)
    a = randint(-5, amt/2)
    b = randint(-5, amt/2)
    c = randint(-5, amt/2)
    d = randint(-5, amt/2)
    if (amt <=0 or a<=0 or b<=0 or c<=0 or d<=0 or a == b or a == c or a == d or b == c or b == d or c == d) and count < 20:
        count += 1
        f = randint(0, 1)
        print amt, a, b, c, d, f
    elif (amt <=0 or a<=0 or b<=0 or c<=0 or d<=0 or a == b or a == c or a == d or b == c or b == d or c == d) and count == 20:
        i = i - 1
    else:
        f = randint(0, 1)
        print amt, a, b, c, d, f
    i = i + 1
print count
