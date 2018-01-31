#!/bin/bash
ocamlc -o out1 coinChanger.ml run_coinChanger.ml
if [ -f out1 ]
then
    echo "Compilation of coinChanger.ml is successful"
fi

ocamlc -o out2 coinChanger_cost.ml run_coinChanger_cost.ml
if [ -f out2 ]
then
    echo "Compilation of coinChanger_cost.ml is successful"
fi