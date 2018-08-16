import json
import sys

file = sys.argv[1]

distribution = {}
with open(file, "r") as f:
    for line in f:
        line = json.loads(line)
        rating = line['overall']
        if rating not in distribution:
            distribution[rating] = 0
        distribution[rating] += 1

items = list(distribution.items())
items.sort(key=lambda x: x[0])
print(items)
