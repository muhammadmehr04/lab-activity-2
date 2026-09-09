#!/bin/bash


target_file="$1"


if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one argument."
    exit 1
fi


if [ ! -f "$target_file" ]; then
    echo "Error: The file '$target_file' does not exist."
    exit 1
fi


if [[ "$target_file" != *.c ]]; then
    echo "Error: The target file must be a .c file."
    exit 1
fi


file_owner=$(ls -l "$target_file" | awk '{print $3}')
file_month=$(ls -l "$target_file" | awk '{print $7}')
file_day=$(ls -l "$target_file" | awk '{print $8}')
file_time=$(ls -l "$target_file" | awk '{print $9}')

temp_file="temp_header.tmp"

cat << EOF > "$temp_file"
/**
* File Name: $target_file
* Owner: $file_owner
* Last Modified On: $file_month $file_day $file_time
*/
EOF

cat "$target_file" >> "$temp_file"

mv "$temp_file" "$target_file"

echo "Successfully added header to $target_file"
