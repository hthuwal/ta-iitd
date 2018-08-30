import pandas as pd
import numpy as np
import sys
import torch
import torch.utils.data as Data
import torch.nn as nn
from torch.autograd import Variable
from sklearn.preprocessing import LabelBinarizer
from sklearn.metrics import accuracy_score
# import
use_cuda = torch.cuda.is_available()
print(use_cuda)


def read_data(file):
    x = pd.read_csv(file)
    x = x.values
    y = x[:, 0]
    x = np.delete(x, 0, axis=1)
    return x, y


class Neural_Network(nn.Module):
    def get_activation(self, activation):
        activations = {
            'relu': nn.ReLU(),
            'sigmoid': nn.Sigmoid(),
            'tanh': nn.Tanh(),
            'softmax': nn.Softmax()
        }

        return activations[activation]

    def __init__(self, activation, inp_size, hidden_layers, output_size):
        super(Neural_Network, self).__init__()
        nhl = len(hidden_layers)
        self.layers = []
        out_activation = 'sigmoid'
        if nhl == 0:
            self.layers.append(nn.Linear(inp_size, output_size))
            self.layers.append(self.get_activation(out_activation))
        else:
            self.layers.append(nn.Linear(inp_size, hidden_layers[0]))
            self.layers.append(self.get_activation(activation))
            for i in range(nhl - 1):
                self.layers.append(nn.Linear(hidden_layers[i], hidden_layers[i + 1]))
                self.layers.append(self.get_activation(activation))
            self.layers.append(nn.Linear(hidden_layers[-1], output_size))
            self.layers.append(self.get_activation(out_activation))

        self.layers = nn.Sequential(*self.layers)

    def forward(self, x):
        out = x
        for layer in self.layers:
            out = layer(out)
        return out

if __name__ == '__main__':
    train_x, train_y = read_data("col341_a2_data/devnagri_train.csv")
    lb = LabelBinarizer()
    lb.fit([i for i in range(46)])
    train_y = lb.transform(train_y)
    # print(train_y[0])

    test_x, test_y = read_data("col341_a2_data/devnagri_test_public.csv")
    batch_size = int(sys.argv[1])
    learning_rate = float(sys.argv[2])
    activation = sys.argv[3]
    inp_size = train_x.shape[1]
    output_size = 46
    # print(inp_size, output_size)
    hidden_layers = list(map(int, sys.argv[4:]))
    net = Neural_Network(activation, inp_size, hidden_layers, output_size)
    print(net.layers)
