#!/bin/sh

PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH
URL="http://1.20.225.107:12500/generate"
FETCH_DATE=`date +%Y%m%d`

fdir="./feeds/"; 

start_at_row=`head -n 1 $1 | grep -q 'Search Query,Clicks,Impressions,CTR,Average Position' && echo 2 || echo 1`;

#echo $start_at_row;
#exit;

tail -n +${start_at_row} $1 | tr -d '\r' | while IFS="," read -r col1 col2 col3 col4 col5

do
    title=`curl -s -X 'POST' ${URL} \
        -H 'accept: application/json' \
        -H 'Content-Type: application/json' \
        -d "{\"instruction\": \"generate article title\", \"input\": \"${col1}\"}" | jq -rj ".response"`;
    echo ${title};

    #printf "%s; %s\n" "${col1}" "${title}" >> ./out/titles.${FETCH_DATE}.csv
    printf "%s; %s\n" "${col1}" "${title}" >> ./out/titles.en.${FETCH_DATE}.01.csv
done 
