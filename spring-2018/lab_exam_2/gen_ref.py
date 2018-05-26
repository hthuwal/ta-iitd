with open("in2.txt", "r") as f:
    temp = []
    for line in f:
        x = line.strip()
        if x == 'Bye':
            continue
        elif x == '':
            l = len(temp)
            print("%d %s" %(l, " ".join(temp)), end=" ")
            print("")
            temp = []
        else:
            x = x.split()
            temp.append(x[-1])
            l = len(x)
            x = " ".join(x[0:l-1])

            print("%d %s" %(l-1, x), end=" ")
        # elif line.strip() != "":
        # else:
        