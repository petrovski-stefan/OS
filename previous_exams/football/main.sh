#! /bin/bash

if [ $# -ne 1 ];
then
    echo "Enter 1 argument!"
    exit 1

fi

directory=$1

paths_with_results=$( ls -l "${directory}" | awk '$NF~/^kolo/ {print $NF}')


total_file="total.txt"
rm "${total_file}"
for path in ${paths_with_results}
do
   
    full_path="${directory}${path}/"
   

    results_file=$( ls -l ${full_path} | awk '$0!~/total/ && $NF~/.rez$/ {print $NF}')
    
    cat "${full_path}${results_file}" | awk -F, '{print $2,$1}' | sort >> "${total_file}"

done

cat "${total_file}" | grep '' | sort > "${total_file}"

teams=$( cat ${total_file} | awk '{print $1}' | sort | uniq )


for team in ${teams}
do 
    score=$( cat "${total_file}" | grep "^${team}" | awk '$2~/w/ || $2~/d/' | wc -l)
    
    if [ ${score} -gt 0 ];
    then
        echo "${team} ${score}"
    fi
done

rm "${total_file}"