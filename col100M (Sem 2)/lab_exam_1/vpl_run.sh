#!/bin/bash
ocamlc -o out1 test1.ml run_test1.ml
if [ -f out1 ]
then
    echo "Compilation of test1.ml is successful"
fi

ocamlc -o out2 test2.ml run_test2.ml
if [ -f out2 ]
then
    echo "Compilation of test2.ml is successful"
fi