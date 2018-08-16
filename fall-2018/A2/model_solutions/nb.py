import csv
import sys
from sklearn.naive_bayes import MultinomialNB
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics import accuracy_score, f1_score
from collections import Counter
train = sys.argv[1]
test = sys.argv[2]


def read(file):
    file = open(file, "r")
    reader = csv.reader(file)
    X = []
    y = []
    for row in reader:
        y.append(row[0])
        X.append(row[1])

    return X, y


train_X, train_y = read(train)
test_X, test_y = read(test)
print(len(train_X), len(test_X))

vectorizer = CountVectorizer(input='content')
train_X = vectorizer.fit_transform(train_X)
test_X = vectorizer.transform(test_X)

clf = MultinomialNB()
clf.fit(train_X, train_y)
prediction = clf.predict(test_X)

print(Counter(train_y))
print(Counter(test_y))
print(accuracy_score(test_y, prediction))
print(f1_score(test_y, prediction, average='macro'))