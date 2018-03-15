# #!/bin/bash
time_limit=0.3 #sec
result_file="result.txt"
temp_grade=0
tf1="cases1.txt"
tf2a="cases2a.txt"
tf2b="cases2b.txt"
tf2c="cases2a.txt"
tf3="cases3.txt"
tf4="cases4.txt"
tf5a="cases5a.txt"
tf5b="cases5b.txt"

g1=0.0
g2a=0.0
g2b=0.0
g2c=0.0
g3=0.0
g4=0.0
g5a=0.0
g5b=0.0

if [ -f $result_file ]
then
    rm $result_file
fi
# Evaluation of test1.ml

function assess(){
    local exit_status=$1
    local execution=$2
    if [ $exit_status -eq 124 ] #timeout occured
    then
        printf "Execution Timeout (>$time_limit sec) while evaluating.\n"
    
    elif [ $exit_status -eq 0 ] #No runtime error occured (Correct or wrong answer)
    then
        printf ""
    
    else #some error occured for this test case
        printf "Runtime Error: $execution\n"
    fi
}

function do_grading(){
    local temp_grade=0.0
    if [ -f "$result_file" ]
    then
        while IFS= read line
        do
            temp_grade=$(echo $temp_grade + $line | bc)
        done <"$result_file"
    fi
    rm "$result_file"
    echo "$temp_grade"
}


printf "\ntest1.ml\n"
compilation=$(ocamlc -o out test1.ml model.ml run_test1.ml 2>&1) # if compilation is successful out file is created

testno=0
num_corr=0
if [ -f "out" ]
then
    printf "Compilation Successful! Evaluating Code\n"

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf1"

    if [ -f $result_file ]
    then
        g1=$(do_grading)
    else
        g1=0
    fi
    num_corr=$(echo $g1 / 0.1 | bc)
    printf "$num_corr/20 Correct\n"

    if [ -f out ]
    then
        rm out
    fi
else
    printf "Compilation failed with the following error:\n$compilation\n\n"
fi


printf "\ntest2.ml\n"
printf "\nTesting swap\n"
compilation=$(ocamlc -o out test2.ml model.ml run_test2_swap.ml 2>&1) # if compilation is successful out file is created
testno=0
num_corr=0
if [ -f "out" ]
then
    printf "Compilation Successful! Evaluating Code\n"

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf2a"

    if [ -f $result_file ]
    then
        g2a=$(do_grading)
    else
        g2a=0
    fi
    gpt=0.1
    num_corr=$(echo $g2a / $gpt | bc)
    printf "$num_corr/60 Correct\n"

    if [ -f out ]
    then
        rm out
    fi
else
    printf "Compilation failed with the following error:\n$compilation\n\n"
fi


printf "\nTesting mult\n"
compilation=$(ocamlc -o out test2.ml model.ml run_test2_mult.ml 2>&1) # if compilation is successful out file is created
testno=0
num_corr=0
if [ -f "out" ]
then

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf2b"

    if [ -f $result_file ]
    then
        g2b=$(do_grading)
    else
        g2b=0
    fi
    num_corr=$(echo $g2b / 0.1 | bc)
    printf "$num_corr/60 Correct\n"

    if [ -f out ]
    then
        rm out
    fi
else
    printf "Compilation failed with the following error:\n$compilation\n\n"
fi


printf "\nTesting addRows\n"
compilation=$(ocamlc -o out test2.ml model.ml run_test2_addrows.ml 2>&1) # if compilation is successful out file is created
testno=0
num_corr=0
if [ -f "out" ]
then

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf2c"

    if [ -f $result_file ]
    then
        g2c=$(do_grading)
    else
        g2c=0
    fi
    num_corr=$(echo $g2c / 0.1 | bc)
    printf "$num_corr/60 Correct\n"

    if [ -f out ]
    then
        rm out
    fi
else
    printf "Compilation failed with the following error:\n$compilation\n\n"
fi


printf "\ntest3.ml\n"
compilation=$(ocamlc -o out test3.ml model.ml run_test3.ml 2>&1) # if compilation is successful out file is created
testno=0
num_corr=0
if [ -f "out" ]
then
    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf3"

    if [ -f $result_file ]
    then
        g3=$(do_grading)
    else
        g3=0
    fi
    num_corr=$(echo $g3 / 0.1 | bc)
    printf "$num_corr/100 Correct\n"

    if [ -f out ]
    then
        rm out  
    fi

else
    printf "Compilation failed with the following error:\n$compilation\n\n"
fi

printf "\ntest4.ml\n"
compilation=$(ocamlc -o out test4.ml model.ml run_test4.ml 2>&1) # if compilation is successful out file is created
testno=0
num_corr=0
if [ -f "out" ]
then
    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf4"

    if [ -f $result_file ]
    then
        g4=$(do_grading)
    else
        g4=0
    fi
    num_corr=$(echo $g4 / 0.1 | bc)
    printf "$num_corr/50 Correct\n"

    if [ -f out ]
    then
        rm out
    fi

else
    printf "Compilation failed with the following error:\n$compilation\n\n"
fi

printf "\ntest5.ml\n"
printf "\nTesting solveRowEchelon\n"
compilation=$(ocamlc -o out test5.ml model.ml run_test5a.ml 2>&1) # if compilation is successful out file is created
testno=0
num_corr=0
if [ -f "out" ]
then

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf5a"

    if [ -f $result_file ]
    then
        g5a=$(do_grading)
    else
        g5a=0
    fi
    num_corr=$(echo $g5a / 0.1 | bc)
    printf "$num_corr/50 Correct\n"

    if [ -f out ]
    then
        rm out
    fi
else
    printf "Compilation failed with the following error:\n$compilation\n\n"
fi


printf "\nTesting solve\n"
compilation=$(ocamlc -o out test5.ml model.ml run_test5b.ml 2>&1) # if compilation is successful out file is created
testno=0
num_corr=0
if [ -f "out" ]
then

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf5b"

    if [ -f $result_file ]
    then
        g5b=$(do_grading)
    else
        g5b=0
    fi
else
    printf "Compilation failed with the following error:\n$compilation\n\n"
fi

num_corr=$(echo $g5b / 0.1 | bc)
printf "$num_corr/50 Correct\n"

grade=$(echo $g1 + $g2a + $g2b + $g2c + $g3 + $g4 + $g5a + $g5b | bc)
echo "#! /bin/bash" > vpl_execution
echo 'echo "Grade :=>> ' $grade\" >> vpl_execution
chmod +x vpl_execution
