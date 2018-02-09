# #!/bin/bash
testno=0
time_limit=1.5 #sec
testcase_file="in.txt"
result_file="result.txt"

if [ -f $result_file ]
then
    rm $result_file
fi
# Evaluation of run_bonus.ml

compilation=$(ocamlc -o out bonus.ml run_bonus.ml 2>&1) # if compilation is successful out1 file is created

if [ -f "out" ]
then
    printf "Compilation Successful! Evaluating Code\n"

    while IFS= read line
    do

        testno=$((testno+1))
        arr=($line) #splitting line into elements
        printf "Test case $testno: coinChanger ${arr[*]}\n"

        execution=$(timeout $time_limit ./out ${arr[*]} 2>&1)
        exit_status=$?

        if [ $exit_status -eq 124 ] #timeout occured
        then
            printf "Execution Timeout (>$time_limit sec) while evaluating bonus.ml\n\n"
        
        elif [ $exit_status -eq 0 ] #No runtime error occured (Correct or wrong answer)
        then
            printf "$execution\n\n"
        
        else #some error occured for this test case
            printf "Runtime Error: $execution\n\n"
        fi

    done <"$testcase_file"

else
    printf "Compilation failed with the following error:\n$compilation\n"
fi

grade=0.0
if [ -f "$result_file" ]
then
    while IFS= read line
    do
        # echo $line
        grade=$(echo $grade + $line | bc)
    done <"$result_file"
fi
echo $grade
echo "#! /bin/bash" > vpl_execution
echo 'echo "Grade :=>> ' $grade\" >> vpl_execution
chmod +x vpl_execution
