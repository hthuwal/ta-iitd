import sys
from sklearn.metrics import accuracy_score, f1_score

with open(sys.argv[1], "r") as f:
    gold = f.readlines()
    gold = [int(float(each.strip())) for each in gold]

with open(sys.argv[2], "r") as f:
    pred = f.readlines()
    pred = [int(float(each.strip())) for each in pred]

if(len(gold) != len(pred)):
    print('Number of labels are more than required' if pred.size > gold.size else 'Number of labels are less than required', end="")
    fscore = 0
else:
    fscore = str(f1_score(gold, pred, average='macro'))
    print(fscore, end="")

with open(sys.argv[3], 'w') as fp:
    fp.write(fscore)
