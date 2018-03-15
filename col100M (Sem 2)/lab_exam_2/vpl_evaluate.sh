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
    temp_grade=0.0
    if [ -f "$result_file" ]
    then
        while IFS= read line
        do
            temp_grade=$(echo $temp_grade + $line | bc)
        done <"$result_file"
    fi
    rm "$result_file"
}


printf "\ntest1.ml\n"
compilation=$(ocamlc -o out test1.ml model.ml run_test1.ml 2>&1) # if compilation is successful out file is created

testno=0
if [ -f "out" ]
then
    printf "Compilation Successful! Evaluating Code\n"

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        printf "Test case $testno\n"
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf1"
else
    printf "Compilation failed with the following error:\n$compilation\n"
fi
do_grading
g1=$temp_grade
num_corr=$(echo $g1 / 0.1 | bc)
printf "$num_corr/20 Correct\n"

rm out
printf "\ntest2.ml\n"
compilation=$(ocamlc -o out test2.ml model.ml run_test2_swap.ml 2>&1) # if compilation is successful out file is created
testno=0
if [ -f "out" ]
then
    printf "Compilation Successful! Evaluating Code\n"
    printf "\nTesting swap\n"

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        printf "Test case $testno\n"
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf2a"
else
    printf "Compilation failed with the following error:\n$compilation\n"
fi
do_grading
g2a=$temp_grade
gpt=0.1
num_corr=$(echo $g2a / $gpt | bc)
printf "$num_corr/60 Correct\n"

compilation=$(ocamlc -o out test2.ml model.ml run_test2_mult.ml 2>&1) # if compilation is successful out file is created
testno=0
if [ -f "out" ]
then
    printf "\nTesting mult\n"

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        printf "Test case $testno\n"
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf2b"

else
    printf "Compilation failed with the following error:\n$compilation\n"
fi
do_grading
g2b=$temp_grade
num_corr=$(echo $g2b / 0.1 | bc)
printf "$num_corr/60 Correct\n"

compilation=$(ocamlc -o out test2.ml model.ml run_test2_addrows.ml 2>&1) # if compilation is successful out file is created
testno=0
if [ -f "out" ]
then
    printf "\nTesting addRows\n"

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        printf "Test case $testno\n"
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf2c"

else
    printf "Compilation failed with the following error:\n$compilation\n"
fi
do_grading
g2c=$temp_grade
num_corr=$(echo $g2c / 0.1 | bc)
printf "$num_corr/60 Correct\n"

printf "\ntest3.ml\n"
compilation=$(ocamlc -o out test3.ml model.ml run_test3.ml 2>&1) # if compilation is successful out file is created
testno=0
if [ -f "out" ]
then
    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        printf "Test case $testno\n"
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf3"

else
    printf "Compilation failed with the following error:\n$compilation\n"
fi
do_grading
g3=$temp_grade
num_corr=$(echo $g3 / 0.1 | bc)
printf "$num_corr/100 Correct\n"

printf "\ntest4.ml\n"
compilation=$(ocamlc -o out test4.ml model.ml run_test4.ml 2>&1) # if compilation is successful out file is created
testno=0
if [ -f "out" ]
then
    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        printf "Test case $testno\n"
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf4"

else
    printf "Compilation failed with the following error:\n$compilation\n"
fi
do_grading
g4=$temp_grade
num_corr=$(echo $g4 / 0.1 | bc)
printf "$num_corr/50 Correct\n"

printf "\ntest5.ml\n"
compilation=$(ocamlc -o out test5.ml model.ml run_test5a.ml 2>&1) # if compilation is successful out file is created
testno=0
if [ -f "out" ]
then
    printf "\nTesting solveRowEchelon\n"

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        printf "Test case $testno\n"
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf5a"

else
    printf "Compilation failed with the following error:\n$compilation\n"
fi
do_grading
g5a=$temp_grade
num_corr=$(echo $g5a / 0.1 | bc)
printf "$num_corr/50 Correct\n"

compilation=$(ocamlc -o out test5.ml model.ml run_test5b.ml 2>&1) # if compilation is successful out file is created
testno=0
if [ -f "out" ]
then
    printf "\nTesting solve\n"

    while IFS= read line
    do
        testno=$((testno+1))
        arr=($line) #splitting line into elements
        printf "Test case $testno\n"
        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?
        assess "$exit_status" "$execution"
    done <"$tf5b"

else
    printf "Compilation failed with the following error:\n$compilation\n"
fi
do_grading
g5b=$temp_grade
num_corr=$(echo $g5b / 0.1 | bc)
printf "$num_corr/50 Correct\n"

grade=$(echo $g1 + $g2a + $g2b + $g2c + $g3 + $g4 + $g5a + $g5b | bc)
echo "#! /bin/bash" > vpl_execution
echo 'echo "Grade :=>> ' $grade\" >> vpl_execution
chmod +x vpl_execution
