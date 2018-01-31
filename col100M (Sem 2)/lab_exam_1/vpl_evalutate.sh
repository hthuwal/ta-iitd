#!/bin/bash
grade1=0.0
grade2=0.0


ocamlc -o out1 coinChanger.ml run_coinChanger.ml
if [ -f "out1" ]
then 
    grade1=`./out1`
    if [ 1 -eq "$(echo "${grade1} < 10.0" | bc)" ]
    then
        echo "Wrong output for some teset cases of coinChanger.ml"
    fi
fi

ocamlc -o out2 coinChanger_cost.ml run_coinChanger_cost.ml
if [ -f "out2" ]
then 
    grade2=`./out2`
    if [ 1 -eq "$(echo "${grade2} < 5.0" | bc)" ]
    then
        echo "Wrong output for some teset cases of coinChanger_cost.ml"
    fi
fi
grade=$(echo $grade1 + $grade2 | bc)





echo "#!/bin/bash" > vpl_execution
echo 'echo "Grade :=>> ' $grade\" >> vpl_execution
chmod +x vpl_execution