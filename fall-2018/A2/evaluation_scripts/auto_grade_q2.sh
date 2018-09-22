#!/bin/bash
run()
{
    timelimit="$1"
    shift
    chmod +x "$1"
    time_start=$(date +%s)
    log "\n"
    timeout -k "$timelimit" "$timelimit" "./$@" &>> "$log_file"
    log "\n"
    status=$?
    time_end=$(date +%s)
    user_time=$(( time_end - time_start ))

    if [ "$status" -eq 124 ]; then
        log "Status: Timed out!"
    else
        log "Status: OK, Time taken: $user_time"
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

log()
{
    echo -e "$*"
    echo -e "$*" >> "$log_file"
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

    log "\n#################################################################################################\n"
    log "Evaluating $entry_number\n"

    main_dir=$(pwd)

    if [ -f "${4}/${3}.zip" ]; then
        log "Zip file found!"
        unzip -qq "$4/$3".zip -d "$2"
    elif [ -f "${4}/${3}.rar" ]; then
        log "RAR file found!"
        unrar x "$4/$3.rar" "$2"
    fi

    write_score "$entry_number"

    stud_folder_path=$(realpath "$2/$3")
    data_folder_path=$(realpath "$1")
    compute_accuracy=$(realpath "compute_accuracy_fscore.py")
    cd "$stud_folder_path"

    status="OK"
    if [ -f "naive" ]; then
        fname="naive" 
        bash_fname_penalty="NO"
        dos2unix naive
    elif [ -f "naive.sh" ]; then
        log "Using naive.sh; Follow submission instructions."
        fname="naive.sh"
        bash_fname_penalty="YES_sh"
        dos2unix naive.sh
    else
        status="NA"
        log "ERROR; naive or naive.sh not found!"
        bash_fname_penalty="YES"
    fi

    log "Bash_File_Name_Penalty: ${bash_fname_penalty}"
    write_score ",$bash_fname_penalty"

    t1="900"
    t2="1200"
    t3="1500"

    if [ $status == "OK" ]; then
        part="a"
        log "\nEvaluating Part $part"
        run "$t1" "$fname" "$part" "$data_folder_path/amazon_train.csv" "$data_folder_path/amazon_test.csv" "$stud_folder_path/predictions_naive_$part"
        compute_score "$compute_accuracy" "$data_folder_path/amazon_target_labels.txt" "$stud_folder_path/predictions_naive_$part" "$stud_folder_path/result_naive_$part" 

        part="b"
        log "\nEvaluating Part $part"
        run "$t2" "$fname" "$part" "$data_folder_path/amazon_train.csv" "$data_folder_path/amazon_test.csv" "$stud_folder_path/predictions_naive_$part"
        compute_score "$compute_accuracy" "$data_folder_path/amazon_target_labels.txt" "$stud_folder_path/predictions_naive_$part" "$stud_folder_path/result_naive_$part" 
        
        part="c"
        log "\nEvaluating Part $part"
        run "$t3" "$fname" "$part" "$data_folder_path/amazon_train.csv" "$data_folder_path/amazon_test.csv" "$stud_folder_path/predictions_naive_$part"
        compute_score "$compute_accuracy" "$data_folder_path/amazon_target_labels.txt" "$stud_folder_path/predictions_naive_$part" "$stud_folder_path/result_naive_$part" 

    else
        write_score ",$t1,NA,0.0,$t2,NA,0.0,$t3,NA,0.0"
    fi
    cd "$main_dir"
}

main()
{
    log "Autograding Naive Bayes....\n"
    download_dir="$(realpath "$1")"
    submissions_dir="$(realpath "$2")"
    data_dir="$(realpath "$3")"
    sandbox_dir="$(realpath "$4")"

    rm -rf "${submissions_dir:?}"/*
    rm -rf "${sandbox_dir:?}"/*


    main_dir=$(pwd)
    for student in "$download_dir"/*;
    do
        cd "$student"
        for submission in "$student"/*;
        do
            if [[ "$submission" == *.zip ]] || [[ "$submission" == *.rar ]]; then
                cp "$submission" "$submissions_dir"
                name="$(basename "$submission")"
                log "Copying $name from \"$(basename "$student")\" to \"$(basename "$submissions_dir")\""
            else
                log "No zip or rar found in $student"
            fi
        done
        cd "$main_dir"
    done

    echo "Entry_Number,Bash_Penalty,timelimit_a,time_a,score_a,timelimit_b,time_b,score_b,timelimit_c,time_c,score_c" >> "$score_file"

    for student in "$submissions_dir"/*;
    do
        student="$(basename "$student")"
        entry_number="${student%.*}"
        evaluate "$data_dir" "$sandbox_dir" "$entry_number" "$submissions_dir" 
        echo " " >> "$score_file"
    done
}


log_file="$(realpath "$1")"
rm "$log_file"
shift
score_file="$(realpath "$1")"
rm "$score_file"
shift

# echo $score_file
main "$@"