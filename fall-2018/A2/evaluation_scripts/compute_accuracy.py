import sys
import numpy as np


def compute_accuracy(true_labels, predicted_labels):
    num_instances = true_labels.size
    print(num_instances, np.sum(true_labels == predicted_labels))
    return np.sum(true_labels == predicted_labels) * 100 / num_instances


targets = np.genfromtxt(sys.argv[1], dtype=np.int)
predicted = np.genfromtxt(sys.argv[2], dtype=np.int)
with open(sys.argv[3], 'w') as fp:
    fp.write(compute_accuracy(targets, predicted))
