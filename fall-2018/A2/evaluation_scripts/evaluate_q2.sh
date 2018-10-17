#!/bin/bash
run()
{
    timelimit="$1"
    shift
    logs="$1"
    shift
    chmod +x "$1"

    echo -e "\nEvaluating Part $2"
    echo -e "\nEvaluating Part $2" >> "$logs"
    
    time_start=$(date +%s)
    timeout -k "$timelimit" "$timelimit" "./$@" &>> "$logs"
    status=$?
    time_end=$(date +%s)
    
    user_time=$(( time_end - time_start ))

    if [ "$status" -eq 124 ]; then
        echo "Status: Timed out"
        echo "Status: Timed out" >> "$logs"
    else
        echo "Status: OK, Time taken: $user_time"
        echo "Status: OK, Time taken: $user_time" >> "$logs"
    fi

    write_score ",$timelimit,$user_time"
}

compute_score()
{
    
    # Compute score as per predicted values and write to given file
    # $1 python_file
    # $2 targets
    # $3 predicted
    # $4 outfile
    if [ -f "$3" ]; then
        score=$(python3 "$1" "$2" "$3" "$4")
    else
        score="0.0"
    fi
    write_score ",$score"
}

write_score()
{
    echo -n "$1" >> "$score_file"
}

evaluate()
{
    # $1: data_dir
    # $2: sandbox_dir
    # $3: entry_number
    # $4: submissions_dir

    main_dir=$(pwd)

    if ! [ -d "$2" ]; then
        mkdir -p "$2"
    fi

    if [ -f "${4}/${3}.zip" ]; then
        echo -e "\nExtracting ${3}.zip"
        unzip -qqu "$4/$3".zip -d "$2"
    elif [ -f "${4}/${3}.rar" ]; then
        echo -e "\nExtracting ${3}.rar"
        unrar x "$4/$3.rar" "$2"
    else
        echo "Zip Not found"
    fi

    entry_number="$3"

    stud_folder_path=$(realpath "$2/$3")
    logs=$(realpath "$2")"/logs"
    score=$(realpath "$2")"/score"

    if ! [ -d "$logs" ]; then
        mkdir -p "$logs"
    fi
    if ! [ -d "$score" ]; then
        mkdir -p "$score"
    fi
    
    logs="$logs/$entry_number"
    score_file="$score/$entry_number"
    
    rm "$logs" "$score_file"

    data_folder_path=$(realpath "$1")
    compute_accuracy=$(realpath "compute_accuracy_fscore.py")
    cd "$stud_folder_path"

    
    status="OK"
    if [ -f "naive" ]; then
        fname="naive" 
        bash_fname_penalty="NO"
        dos2unix naive
    elif [ -f "naive.sh" ]; then
        fname="naive.sh"
        bash_fname_penalty="YES_sh"
        dos2unix naive.sh
    else
        status="NA"
        bash_fname_penalty="YES"
    fi

    write_score "$entry_number"
    write_score ",$bash_fname_penalty"

    t1="900"
    t2="1200"
    t3="1500"
    
    if [ $status == "OK" ]; then
        part="a"
        run "$t1" "$logs" "$fname" "$part" "$data_folder_path/amazon_train.csv" "$data_folder_path/amazon_test.csv" "$stud_folder_path/predictions_naive_$part" 
        compute_score "$compute_accuracy" "$data_folder_path/target_labels.txt" "$stud_folder_path/predictions_naive_$part" "$stud_folder_path/result_naive_$part" 

        part="b"
        run "$t2" "$logs" "$fname" "$part" "$data_folder_path/amazon_train.csv" "$data_folder_path/amazon_test.csv" "$stud_folder_path/predictions_naive_$part"
        compute_score "$compute_accuracy" "$data_folder_path/target_labels.txt" "$stud_folder_path/predictions_naive_$part" "$stud_folder_path/result_naive_$part" 
        
        part="c"
        run "$t3" "$logs" "$fname" "$part" "$data_folder_path/amazon_train.csv" "$data_folder_path/amazon_test.csv" "$stud_folder_path/predictions_naive_$part"
        compute_score "$compute_accuracy" "$data_folder_path/target_labels.txt" "$stud_folder_path/predictions_naive_$part" "$stud_folder_path/result_naive_$part" 
    else
        write_score ",$t1,NA,0.0,$t2,NA,0.0,$t3,NA,0.0"
    fi
    cd "$main_dir"
}

evaluate "$@"