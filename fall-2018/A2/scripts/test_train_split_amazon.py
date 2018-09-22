import json
import sys
import random
import csv
import os
file = sys.argv[1]
file_name, ext = os.path.splitext(file)

distribution = {}
if ext == '.json':
    with open(file, "r") as f:
        for line in f:
            line = json.loads(line)
            rating = line['overall']
            text = line['reviewText']
            text.replace(",", "")
            if rating not in distribution:
                distribution[rating] = []
            distribution[rating].append(text)

if ext == '.csv':
    f = open(file, "r")
    reader = csv.reader(f)
    for row in reader:
        rating = row[0]
        text = row[1]
        if rating not in distribution:
            distribution[rating] = []
        distribution[rating].append(text)

for rating in distribution:
    random.shuffle(distribution[rating])

test, train = [], []
for rating in distribution:
    l = len(distribution[rating])
    for i in range(l // 2):
        train.append([rating, distribution[rating][i]])
    for i in range(l // 2, l):
        test.append([rating, distribution[rating][i]])

# random.shuffle(train)
# random.shuffle(test)

with open(file_name + "_train.csv", "w") as out:
    csvw = csv.writer(out)
    for each in train:
        csvw.writerow(each)

with open(file_name + "_test.csv", "w") as out:
    csvw = csv.writer(out)
    for each in test:
        csvw.writerow(each)
