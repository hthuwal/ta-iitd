import json
import sys
import os
import csv

file = sys.argv[1]
file_name, _ = os.path.splitext(file)


with open(file, "r") as f, open(file_name + ".csv", "w") as out:
    csvw = csv.writer(out)
    for line in f:
        line = json.loads(line)
        rating = line['overall']
        text = line['reviewText']
        text.replace(",", "")
        csvw.writerow([rating, text])
