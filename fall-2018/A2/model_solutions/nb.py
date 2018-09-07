import csv
import sys
from sklearn.naive_bayes import MultinomialNB
from sklearn.feature_extraction.text import CountVectorizer
from nltk.stem import *
from tqdm import tqdm
from nltk.corpus import stopwords

stop_words = set(stopwords.words('english'))

train = sys.argv[2]
test = sys.argv[3]
out = sys.argv[4]


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
print(sys.argv[1])
if sys.argv[1] == "b":
    stemmer = PorterStemmer()
    for i in tqdm(range(len(train_X))):
        train_X[i] = [stemmer.stem(each) for each in train_X[i].split()]
        train_X[i] = " ".join([each for each in train_X[i] if each not in stop_words])
    for i in tqdm(range(len(test_X))):
        test_X[i] = [stemmer.stem(each) for each in test_X[i].split()]
        test_X[i] = " ".join([each for each in test_X[i] if each not in stop_words])


vectorizer = CountVectorizer(input='content')
train_X = vectorizer.fit_transform(train_X)
test_X = vectorizer.transform(test_X)

clf = MultinomialNB()
clf.fit(train_X, train_y)
prediction = clf.predict(test_X)

with open(out, "w") as f:
    for each in prediction:
        f.write(str(each) + "\n")
