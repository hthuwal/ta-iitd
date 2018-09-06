'''
Extract labels from a csv file
assumging:
1. Each row corresponds to a csv file
2. First element of each row is the target label, rest compose the data
'''

import csv
import sys
import os


def dummify_test_data(file):
    file_name, ext = os.path.splitext(file)
    dummy_file = file_name + "_dummy.csv"
    labels_file = os.path.join(os.path.dirname(file), "labels.txt")
    csvr = csv.reader(open(file, "r"))
    csvw = csv.writer(open(dummy_file, "w"))
    csvl = csv.writer(open(labels_file, "w"))
    for row in csvr:
        label = row[0]
        row[0] = -1
        csvw.writerow(row)
        csvl.writerow([label])


dummify_test_data(sys.argv[1])
