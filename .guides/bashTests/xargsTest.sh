#!/bin/bash

# Check if files.txt exists
check_files_txt() {
    if [ -f files.txt ]; then
        echo "files.txt exists"
    else
        echo "files.txt does not exist"
        exit 1
    fi
}

# Check if xargs was used correctly in fileManage.sh
check_xargs_usage() {
    if grep -q 'cat files.txt | xargs touch' fileManage.sh; then
        echo "xargs was used correctly in fileManage.sh"
    else
        echo "xargs was not used correctly in fileManage.sh"
        exit 1
    fi
}

# Check if the files exist
check_files_exist() {
    for file in file1.txt file2.txt file3.txt; do
        if [ -f $file ]; then
            echo "$file exists"
        else
            echo "$file does not exist"
            exit 1
        fi
    done
}

# Check the content of created_files.txt
check_created_files_content() {
    expected_content="file1.txt\nfile2.txt\nfile3.txt"
    actual_content=$(cat created_files.txt | tr '\n' ' ')
    if [ "$actual_content" == "$(echo -e $expected_content | tr '\n' ' ')" ]; then
        echo "created_files.txt content is correct"
    else
        echo "created_files.txt content is incorrect"
        exit 1
    fi
}

# Main function to perform checks
main() {
    case $1 in
        "check_files_txt")
            check_files_txt
            ;;
        "check_xargs_usage")
            check_xargs_usage
            ;;
        "check_files_exist")
            check_files_exist
            ;;
        "check_created_files_content")
            check_created_files_content
            ;;
        *)
            echo "Unknown requirement"
            exit 1
            ;;
    esac
}

# Pass the argument to the main function
main "$1"
