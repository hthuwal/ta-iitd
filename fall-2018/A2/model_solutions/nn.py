import pandas as pd
import numpy as np
import 

def read_data(file):
    x = pd.read_csv(file)
    x = x.values()
    y = x[:, 0]
    x = np.delete(x, 0, axis=1)
    return x, y


if __name__ == '__main__':
    train_x, train_y = read_data("col341_a2_data/devnagri_train.csv")
