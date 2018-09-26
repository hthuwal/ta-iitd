#!/bin/bash

for i in {1..3}
do
	./auto_grade_q2.sh "../results/naive/set$i/logs" "../results/naive/set$i/scores" "../1801-COL341-A2 (Naive Bayes)-22000" "../submissions" "../data/naive/set$i" "../sandbox/naive/set$i"
done
