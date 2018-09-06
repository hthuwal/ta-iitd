#!/bin/bash
run()
{
    chmod +x $1
    ./$@
}

compute_score()
{
    : '
        Compute score as per predicted values and write to given file
        $1 python_file
        $2 targets
        $3 predicted
        $4 outfile
    '
    python3 $1 $2 $3 $4 $5
}

main()
{
    : '
        $1: data_dir
        $2: sandbox_dir
        $3: entry_number
        $4: submissions_dir
    '
    main_dir=`pwd`
    if [ -f "${4}/${3}.zip" ]; then
        echo -e "Zip file found!"
        unzip $4/$3.zip -d $2
        zip_penalty="NO"
    elif [ -f "${4}/${3}.rar" ]; then
        echo -e "RAR file found!"
        unrar x "$4/$3.rar" $2
        zip_penalty="YES"
    fi
    
    stud_folder_path=$(realpath "$2/$3")
    data_folder_path=$(realpath "$1")

    cd "$stud_folder_path"

    status="OK"
    if [ -f "neural" ]; then
        fname="neural" 
        bash_fname_penalty="NO"
        dos2unix neural
    elif [ -f "neural.sh" ]; then
        echo -e "Using neural.sh; Follow submission instructions."
        fname="neural.sh"
        bash_fname_penalty="YES"
        dos2unix neural.sh
    else
        status="NA"
        echo -e "ERROR; neural or neural.sh not found!"
        bash_fname_penalty="YES"
    fi

    echo -e "Zip Penalty: ${zip_penalty}\nBash_File_Name_Penalty: ${bash_fname_penalty}"
    echo -e "${zip_penalty},${bash_fname_penalty}" > penalty


    if [ $status == "OK" ]; then
        part="a"
        echo -e "\nEvaluating Part $part"
        time run "$fname" "$part" "$data_folder_path/devnagri_train.csv" "$data_folder_path/devnagri_test.csv" "$stud_folder_path/predictions_$fname_$part" 512 0.01 "sigmoid" 100
        compute_score compute_accuracy "$data_folder_path/devnagri_target_labels.txt" "$stud_folder_path/predictions_$fname_$part" "$stud_folder_path/result_$fname_$part" 

        part="b"
        echo -e "\nEvaluating Part $part"
        time run "$fname" "$part" "$data_folder_path/devnagri_train.csv" "$data_folder_path/devnagri_test.csv" "$stud_folder_path/predictions_$fname_$part"
        compute_score compute_accuracy "$data_folder_path/devnagri_target_labels.txt" "$stud_folder_path/predictions_$fname_$part" "$stud_folder_path/result_$fname_$part" 
        
        part="c"
        echo -e "\nEvaluating Part $part"
        time run "$fname" "$part" "$data_folder_path/devnagri_train.csv" "$data_folder_path/devnagri_test.csv" "$stud_folder_path/predictions_$fname_$part"
        compute_score compute_accuracy "$data_folder_path/devnagri_target_labels.txt" "$stud_folder_path/predictions_$fname_$part" "$stud_folder_path/result_$fname_$part" 

    fi
    cd $main_dir
}

main $1 $2 $3 $4
