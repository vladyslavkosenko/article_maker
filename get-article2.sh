#!/bin/sh

PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH
URL="http://1.20.225.107:12500/generate"
FETCH_DATE=`date +%Y%m%d`

fdir="./feeds/"; 
fdir="./titles/"; 

start_at_row=`head -n 1 $1 | grep -q 'Search Query,Clicks,Impressions,CTR,Average Position' && echo 2 || echo 1`;

#echo $start_at_row;
#exit;

tail -n +${start_at_row} $1 | tr -d '\r' | while IFS="," read -r col1 col2 col3 col4 col5

do
instruction="You are a talented Super Reality Dome copywriter. And write advertising articles in which you reveal the benefits of cooperation with fulldome.pro" 
text_to_send="Write a long article, 3000 characters for this title: ${col1}" 
    title=`curl -s -X 'POST' ${URL} \
        -H 'accept: application/json' \
        -H 'Content-Type: application/json' \
        -d "{\"instruction\": \"${instruction}\", \"input\": \"${text_to_send}\"}" | jq -rj ".response"`;
    echo ${title};
    echo ""
    echo "===========new==========="

    #printf "%s; %s\n" "${col1}" "${title}" >> ./out/titles.${FETCH_DATE}.csv
    printf "%s; %s\n===New===\n" "${col1}" "${title}" >> ./out/test.${FETCH_DATE}.03.csv
done 
