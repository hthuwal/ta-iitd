#!/bin/bash

main()
{
    submissions_dir="$2"
    if ! [ -d "$submissions_dir" ]; then
        echo "Creating $submissions_dir"
        mkdir -p "$submissions_dir"
    fi

    download_dir="$(realpath "$1")"
    submissions_dir="$(realpath "$2")"
    main_dir=$(pwd)
    for student in "$download_dir"/*;
    do
        cd "$student"
        for submission in "$student"/*;
        do
            if [[ "$submission" == *.zip ]] || [[ "$submission" == *.rar ]]; then
                cp "$submission" "$submissions_dir"
                echo "Copying $name from \"$(basename "$student")\" to \"$(basename "$submissions_dir")\""
            else
                echo "No zip or rar found in $student"
            fi
        done
        cd "$main_dir"
    done
}

if [ $# -ne 2 ]; then
    echo "Two arguments expected. Source and Destinatino";
else
    main "$@"
fi