# #!/bin/bash
time_limit=0.5 #sec
result_file="result.txt"
gpt=0.2
num_cases=25
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

runner="run3_4.ml"
compilation=$(ocamlc -o out cell.ml model.ml test.ml $runner 2>&1)
best=50
best_r=-1
for j in {0..10000}
do
	seed=$RANDOM
	RANDOM=$seed
	for i in {7..31} 
	do
		input_file="testcases/9input"$i
		hcid=$(($RANDOM % 9))
		func_num=$(( ($RANDOM % 3) + 1 ))
		execution=$(timeout $time_limit ./out $input_file $hcid $func_num 2>&1)
		exit_status=$?
		assess "$exit_status" "$execution" "$(($i-7))"
	done
	if [ -f $result_file ]
	then
	    curr_grade=$(do_grading)
	else
	    curr_grade=0
	fi
	num_corr=$(echo $curr_grade / $gpt | bc)
	if [ $num_corr -lt $best ]
	then
		best=$num_corr
		best_r=$seed
	fi
	echo $seed":"$num_corr $best_r":"	$best 
done