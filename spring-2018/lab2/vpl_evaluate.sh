#!/bin/bash
ocaml run_poly.ml
ocaml run_ncuberoot.ml
ocaml run_nlog.ml
ocaml run_degree.ml

file="result.txt"
grade=0

while IFS= read line
do
    # echo $line
    grade=$(echo $grade + $line | bc)
done <"$file"

echo "#! /bin/bash" > vpl_execution
echo 'echo "Grade :=>> ' $grade\" >> vpl_execution
chmod +x vpl_execution