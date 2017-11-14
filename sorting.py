from random import randint

stud_records = []
with open("input.txt") as f:
    stud_records = f.readlines()[1:]
    stud_records = list(map(lambda x: x.strip(), stud_records))

BASE_RANGE = (-10, 20)

####################################

NUM_CASES = 20

TEST_CASE_FORMAT = """
case = Test %d
input = %s
output = %s
"""

####################################


def dob(record):
    record = record.split('\t')
    # date = record[1]
    # d, m, y = date[0:2], date[2:4], date[4:]
    return record[0].strip()

left = 0
right = len(stud_records)
len_input = right

for i in range(1, 1 + NUM_CASES):
    inp = ''
    out = ''
    inp += str(len_input) + '\n'
    inp += '\n'.join(stud_records[left:right])

    ans = sorted(stud_records[left:right], key=dob)
    out += '\n'.join(ans)

    print(TEST_CASE_FORMAT % (i, inp, out))

    left = randint(0, len(stud_records))
    right = randint(left, len(stud_records))
    len_input = right - left
    
    # assert(len_input, len(stud_records[left:right]))
    # print(inp)

