import json
import sys
import random
import csv
import os
file = sys.argv[1]
file_name, ext = os.path.splitext(file)

distribution = {}

if ext == '.csv':
    f = open(file, "r")
    reader = csv.reader(f)
    for row in reader:
        rating = row[0]
        image = row[1:]
        if rating not in distribution:
            distribution[rating] = []
        distribution[rating].append(image)

test, train = [], []

for rating in distribution:
    random.shuffle(distribution[rating])

for rating in distribution:
    l = len(distribution[rating])
    for i in range(l // 6):
        test.append([rating] + distribution[rating][i])
    for i in range(l // 6, l):
        train.append([rating] + distribution[rating][i])

with open(file_name + "_train.csv", "w") as out:
    csvw = csv.writer(out)
    for each in train:
        csvw.writerow(each)

with open(file_name + "_test.csv", "w") as out:
    csvw = csv.writer(out)
    for each in test:
        csvw.writerow(each)
