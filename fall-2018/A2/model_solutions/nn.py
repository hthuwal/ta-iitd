import pandas as pd
import numpy as np
import sys
import torch
import torch.utils.data as Data
import torch.nn as nn
from torch.autograd import Variable
from sklearn.preprocessing import LabelBinarizer, scale
from sklearn.metrics import accuracy_score
# import
use_cuda = torch.cuda.is_available()
print(use_cuda)


def read_data(file):
    x = pd.read_csv(file, header=None)
    x = x.values
    y = x[:, 0]
    x = np.delete(x, 0, axis=1)
    x = scale(x)
    return x, y


class Neural_Network(nn.Module):
    def get_activation(self, activation):
        activations = {
            'relu': nn.ReLU(),
            'leakyrelu': nn.LeakyReLU(),
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


def predict(net, test_x):
    test_x = torch.from_numpy(test_x).type(torch.FloatTensor)

    pred = []
    for i in (range(0, len(test_x), 100)):
        x = test_x[i: i + 100]
        x = Variable(x, volatile=False)
        if use_cuda:
            x = x.cuda()
        outputs = net(x)
        cur_pred = torch.max(outputs, dim=1)[1].data.cpu().numpy().tolist()
        pred.extend(cur_pred)
    return pred


def train_and_predict(net, train_x, train_y, test_x, test_y, lr0, batch_size, num_epochs):
    """ Use Mean Squared Error as Loss """
    criterion = nn.MSELoss()

    """ USE SGD as the optimizer """
    optimizer = torch.optim.SGD(net.parameters(), lr=lr0)

    """ Scheduler to dynamically change the learning rate of SGD optimizer """
    def hc_lambda(epoch):
        return 1.0 / ((1 + epoch)**(0.5))

    scheduler = torch.optim.lr_scheduler.LambdaLR(optimizer, hc_lambda)

    """ converting training data to torch tensors """
    train_x = torch.from_numpy(train_x).type(torch.FloatTensor)
    train_y = torch.from_numpy(train_y).type(torch.FloatTensor)

    """ Creating Dataset Loader """
    dataset = Data.TensorDataset(train_x, train_y)
    train_loader = Data.DataLoader(dataset=dataset, batch_size=batch_size, shuffle=True)

    """ Training """
    prev_epoch_loss = 0

    for epoch in range(num_epochs):

        net.train()  # Set model mode to train
        gold, pred, losses = [], [], []

        for i, (x, y) in enumerate(train_loader):
            # print("\r%d" % (i), end="")
            x, y = Variable(x), Variable(y)

            if use_cuda:
                x, y = x.cuda(), y.cuda()

            outputs = net(x)
            loss = criterion(outputs, y)
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()

            cur_gold = torch.max(y, dim=1)[1].data.cpu().numpy().tolist()
            cur_pred = torch.max(outputs, dim=1)[1].data.cpu().numpy().tolist()
            gold.extend(cur_gold)
            pred.extend(cur_pred)
            losses.extend([loss.data.cpu().numpy()])

        test_pred = predict(net, test_x)
        print("\rEpoch: %d Train Accuracy: %f Loss: %f Test Accuracy %f" % (epoch, accuracy_score(gold, pred), np.mean(losses), accuracy_score(test_y, test_pred)), end="")
        epoch_loss = np.mean(losses)
        # print(" ", epoch_loss, prev_epoch_loss)
        if epoch_loss > prev_epoch_loss:
            scheduler.step()  # reduce learning rate

        prev_epoch_loss = epoch_loss

    test_pred = predict(net, test_x)
    return test_pred


if __name__ == '__main__':

    part = sys.argv[1]
    train = sys.argv[2]
    test = sys.argv[3]
    out = sys.argv[4]
    if part == 'a':
        batch_size = int(sys.argv[5])
        lr = float(sys.argv[6])
        activation = sys.argv[7]
        hidden_layers = list(map(int, sys.argv[8:]))
    else:
        batch_size = 100
        lr = 0.1
        activation = 'relu'
        hidden_layers = []

    train_x, train_y = read_data(train)
    # train_x = scale(train_x)
    train_x = train_x / 255
    lb = LabelBinarizer()
    lb.fit([i for i in range(46)])
    train_y = lb.transform(train_y)
    test_x, test_y = read_data(test)

    net = Neural_Network(activation, 1024, hidden_layers, 46)
    pred = train_and_predict(net, train_x, train_y, test_x, test_y, lr, batch_size, 200)

    with open(out, "w") as f:
        for each in pred:
            f.write(str(each) + "\n")
