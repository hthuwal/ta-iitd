# #!/bin/bash
time_limit=0.5 #sec
result_file="result.txt"
gpt=0.2
num_cases=5
grade=0

if [ -f $result_file ]
then
    rm $result_file
fi

function assess(){
    local exit_status=$1
    local execution=$2
    local testno=$3
    if [ $exit_status -eq 124 ] #timeout occured
    then
        printf "Execution Timeout (>$time_limit sec) while evaluating.\n"
    
    elif [ $exit_status -eq 0 ] #No runtime error occured (Correct or wrong answer)
    then
        printf ""
        # if [[ $execution =~ INCORRECT ]]
        # then
        # printf "\nTEST CASE $testno:"
        # printf "$execution\n"
        # fi
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

function run(){
    if [ -f "out" ]
    then
        rm out # delete previous executables
    fi
    runner=$1
    RANDOM=$2 # seeding the random number generator
    func_name=$3

    printf "\nTesting $func_name\n"

    compilation=$(ocamlc -o out cell.ml model.ml test.ml $runner 2>&1) # if compilation is successful out file is created
    if [ -f "out" ]
    then
        for i in {1..5} 
        do
            input_file="testcases/9input"$i
            if [[ $runner =~ run3_[1,3]_1\.ml || $runner =~ run3_[1,3]_2\.ml || $runner =~ run3_[1,3]_3\.ml ]]
            then
                value=$(( ($RANDOM % 9) + 1 ))
                row=$(($RANDOM % 9))
                execution=$(timeout $time_limit ./out $input_file $value $row 2>&1)
                exit_status=$?
                assess "$exit_status" "$execution" "$(($i-7))"

            elif [[ $runner == "run3_1_4.ml" ]]
            then
                i=$(($RANDOM % 9))
                j=$(($RANDOM % 9))
                execution=$(timeout $time_limit ./out $input_file $i $j 2>&1)
                exit_status=$?
                assess "$exit_status" "$execution" "$(($i-7))"

            elif [[ $runner =~ run3_[2,5]\.ml ]]
            then
                execution=$(timeout $time_limit ./out $input_file 2>&1)
                exit_status=$?
                assess "$exit_status" "$execution" "$(($i-7))"

            elif [[ $runner == "run3_3_4.ml" || $runner == "run3_4.ml" ]]
            then
                hcid=$(($RANDOM % 9))
                func_num=$(( ($RANDOM % 3) + 1 ))
                execution=$(timeout $time_limit ./out $input_file $hcid $func_num 2>&1)
                exit_status=$?
                assess "$exit_status" "$execution" "$(($i-7))"
            else
                echo "This shouldn't have happened"
            fi
        done

        if [ -f $result_file ]
        then
            curr_grade=$(do_grading)
        else
            curr_grade=0
        fi
        
        num_corr=$(echo $curr_grade / $gpt | bc)
        printf "$num_corr/$num_cases Correct\n"
        
        grade=$(echo $grade + $curr_grade | bc)
    else
        printf "Compilation failed with the following error:\n$compilation\n\n"
    fi
}


run run3_1_1.ml 764 "eliminateValueRow" 
run run3_1_2.ml 502 "eliminateValueCol" 
run run3_1_3.ml 520 "eliminateValueBox" 
run run3_1_4.ml 645 "eliminate" 
run run3_2.ml 534 "loneCells"
run run3_3_1.ml 8 "getCellsRow"
run run3_3_2.ml 512 "getCellsCol"
run run3_3_3.ml 456 "getCellsBox"
run run3_3_4.ml 13 "loneRanger"
run run3_4.ml 483 "getTwin"
run run3_5.ml 931 "solveHumanistic"

printf "\nScore: $grade/11"
