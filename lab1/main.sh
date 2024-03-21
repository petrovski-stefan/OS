#!/bin/bash

if [ $# -lt 1 ];
then
    echo "Enter an argument!"
    exit 1
elif [ $# -gt 1 ];
then
    echo "Too many arguments!"
    exit 1
fi

OUTPUT_FILE=$1


paths=$( ls -lR | grep '^\.' )

for path in ${paths}
do  
    current_path=${path}
    
    parsed=$( echo "${current_path}" | sed 's/://g'  )
    txt_files=$( ls -l "${parsed}" | awk '$NF~/\.txt$/ && $1~/^-r--/ {print $NF}' )

    
    for file in ${txt_files}
    do 
        full_path="${parsed}/${file}"
        cat "${full_path}" >> "${OUTPUT_FILE}"
        echo "       " >> "${OUTPUT_FILE}"

    done
    
done