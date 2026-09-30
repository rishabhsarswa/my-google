#!/bin/bash

#wget --user="rishu" --password="" ftp://10.207.109.103:7021//awnto/flog -O flog


filename="flog"

TARGET_DIR="qq"
mkdir -p qq

count=0

# Loop through the file line by line
while IFS= read -r line; do
    pdir="$(dirname "$line")"
    #pfile="$(basename "$line")"
    mkdir -p "$pdir"
    
    
    # Count only regular files in the directory (excluding folders and subdirectories)
FILE_COUNT=$(find "$TARGET_DIR" -maxdepth 1 -type f | wc -l)

# Check if the file count is less than 4
while [ "$FILE_COUNT" -gt 15 ]; do
    FILE_COUNT=$(find "$TARGET_DIR" -maxdepth 1 -type f | wc -l)
    sleep 0.1
done
    
    #echo $FILE_COUNT
    ((count++))
    ./load.sh $count "$line" &
    
    
done < "$filename"

while [ "$FILE_COUNT" -lt 1 ]; do
    FILE_COUNT=$(find "$TARGET_DIR" -maxdepth 1 -type f | wc -l)
    echo " --- the end --- "
    sleep 3
done
