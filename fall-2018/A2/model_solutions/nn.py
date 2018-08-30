import pandas as pd
import numpy as np
import sys
import torch
import torch.nn as nn
from torch.autograd import Variable

# import


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
        self.nhl = len(hidden_layers)
        self.layers = []
        self.out_activation = 'sigmoid'
        if self.nhl == 0:
            self.layers.append(nn.Linear(inp_size, output_size))
            self.layers.append(self.get_activation(self.out_activation))
        else:
            self.layers.append(nn.Linear(inp_size, hidden_layers[0]))
            self.layers.append(self.get_activation(activation))
            for i in range(self.nhl - 1):
                self.layers.append(nn.Linear(hidden_layers[i], hidden_layers[i + 1]))
                self.layers.append(self.get_activation(activation))
            self.layers.append(nn.Linear(hidden_layers[-1], output_size))
            self.layers.append(self.get_activation(self.out_activation))


if __name__ == '__main__':
    train_x, train_y = read_data("col341_a2_data/devnagri_train.csv")
    test_x, test_y = read_data("col341_a2_data/devnagri_test_public.csv")
    activation = sys.argv[1]
    inp_size = train_x.shape[1]
    output_size = 46
    # print(inp_size, output_size)
    hidden_layers = list(map(int, sys.argv[2:]))
    net = Neural_Network(activation, inp_size, hidden_layers, output_size)
    print(net.layers)
