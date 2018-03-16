import random


def gen_random_mat(n, m, low, high):
    mat = []
    for i in range(0, n):
        temp = []
        for j in range(0, m):
            temp.append(random.uniform(low, high))
        mat.append(temp)
    return mat


def gen_random_vector(n, low, high):
    vec = []
    for i in range(0, n):
        vec.append(random.uniform(low, high))
    return vec


def print_mat(mat):
    for row in mat:
        print(len(row), end=" ")
        for col in row:
            print(col, end=" ")
    print("")


num_samples = 500

for i in range(num_samples):
    n = random.randint(3, 10)
    m = n
    mat = gen_random_mat(n, m, -10, 10)
    # rang = [i for i in range(n)]
    # i, j = random.sample(rang, 2)
    b = gen_random_vector(n, -10, 10)
    # mat[i] = list(map(lambda x: 2 * x, mat[j]))
    # b[i] = 3 * b[j]
    for i in range(0, n):
        mat[i].append(b[i])
    # print(mat[i])
    # mat[i] = list(map(lambda x: 2*x, mat[j][0:m-1])).append(mat[j][m-1]*3)
    # mat.append(b)
    print_mat(mat)
