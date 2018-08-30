import sys
from sklearn.metrics import accuracy_score

with open(sys.argv[1], "r") as f:
    gold = f.readlines()
    gold = [int(each.strip()) for each in gold]

with open(sys.argv[2], "r") as f:
    pred = f.readlines()
    pred = [int(each.strip()) for each in pred]

print(gold[:10])
print(pred[:10])
print(accuracy_score(gold, pred))
