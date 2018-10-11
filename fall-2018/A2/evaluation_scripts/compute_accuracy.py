import sys
from sklearn.metrics import accuracy_score

with open(sys.argv[1], "r") as f:
    gold = f.readlines()
    gold = [int(float(each.strip())) for each in gold]

with open(sys.argv[2], "r") as f:
    pred = f.readlines()
    pred = [int(float(each.strip())) for each in pred]

if(len(gold) != len(pred)):
    msg = 'Number of labels are more than required' if pred.size > gold.size else 'Number of labels are less than required'
    print(msg, end=" ")
    acc = 0
else:
    acc = str(accuracy_score(gold, pred))
    print(acc, end="")

with open(sys.argv[3], 'w') as fp:
    fp.write(acc)


