import pandas as pd
import numpy as np
from collections import Counter
import random
import sys
from sklearn.metrics import accuracy_score, f1_score


def read(file):
    x = pd.read_csv(file, header=None, keep_default_na=False)
    x = x.values
    y = x[:, 0]
    x = np.delete(x, 0, axis=1)
    return x, y


def majority_prediction(y_train, x_test):
    y_train = Counter(y_train)
    y_train = list(y_train.items())
    majority = max(y_train, key=lambda x: x[1])
    print(majority)

    pred = []
    for i in range(len(x_test)):
        pred.append(int(majority[0]))
    return pred


def random_prediction(y_train, x_test):
    y_train = list(Counter(y_train).keys())
    pred = []
    for i in range(len(x_test)):
        pred.append(int(random.choice(y_train)))
    return pred


train = sys.argv[1]
test = sys.argv[2]
target_labels = sys.argv[3]
with open(target_labels, "r") as f:
    target_labels = f.readlines()
    target_labels = [int(float(each.strip())) for each in target_labels]
    print(set(target_labels))


train_X, train_y = read(train)
test_X, test_y = read(test)

print("Majority Predictions")
pred_m = majority_prediction(train_y, test_X)
# print(accuracy_score(target_labels, pred_m))
print(f1_score(target_labels, pred_m, average='macro'))

print("Random Predictions")
avg = 0
for i in range(100):
    temp = random_prediction(train_y, test_X)
    # score = accuracy_score(target_labels, pred_m)
    score = f1_score(target_labels, pred_m, average='macro')
    print("\r %d %s: " % (i, str(score)), end="")
    avg += score
print("\nAvg: ", avg / 100)
