#!/bin/bash
grade1=0.0
grade2=0.0
time_limit=5 #sec
flag=0

# Evaluation of test1.ml
ocamlc -o out1 test1.ml run_test1.ml
if [ -f "out1" ]
then

    grade0=`timeout $time_limit ./out1 "invalid.cases"`
    exit_status=$?
    if [ $exit_status -eq 124 ]
    then
        grade0=0.0
        flag=$((flag+1))
        echo "Execution Timeout (>$time_limit sec) while evaluating test1.ml"
        
    fi
    
    grade1=`timeout $time_limit ./out1 "vpl_evaluate.cases"`
    exit_status=$?
    if [ $exit_status -eq 124 ]
    then
        grade1=0.0
        flag=$((flag+1))
        echo "Execution Timeout (>$time_limit sec) while evaluating test1.ml"
    fi
    
    grade1=$(echo $grade1 + $grade0 | bc)
    if [ $flag -lt 1 ]
    then
        if [ 1 -eq "$(echo "${grade1} < 10.0" | bc)" ]
        then
            echo "Wrong output for some test cases of test1.ml"
        fi
    fi
fi

# evaluation of test2.ml
flag=0
ocamlc -o out2 test2.ml run_test2.ml
if [ -f "out2" ]
then 
    grade2=`timeout $time_limit ./out2`
    exit_status=$?
    if [ $exit_status -eq 124 ]
    then
        grade2=0.0
        flag=$((flag+1))
        echo "Execution Timeout (>$time_limit sec) while evaluating test2.ml"
        
    fi
    
    if [ $flag -lt 1 ]
    then
        if [ 1 -eq "$(echo "${grade2} < 5.0" | bc)" ]
        then
            echo "Wrong output for some teset cases of test2.ml"
        fi
    fi
fi

grade=$(echo $grade1 + $grade2 | bc)

echo "#!/bin/bash" > vpl_execution
echo 'echo "Grade :=>> ' $grade\" >> vpl_execution
chmod +x vpl_execution