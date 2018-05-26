#!/bin/bash
ocamlc -o out1 test1.ml
if [ -f temp_out1 ]
then
    echo "Compilation of test1.ml is successful"
fi

ocamlc -o out2 test2.ml
if [ -f temp_out2 ]
then
    echo "Compilation of test2.ml is successful"
fi

ocamlc -o out2 test3.ml
if [ -f temp_out3 ]
then
    echo "Compilation of test3.ml is successful"
fi

ocamlc -o out2 test4.ml
if [ -f temp_out4 ]
then
    echo "Compilation of test4.ml is successful"
fi

ocamlc -o out2 test5.ml
if [ -f temp_out5 ]
then
    echo "Compilation of test5.ml is successful"
fi

rm temp_*