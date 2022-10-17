#!/bin/bash

printf "Input stock: "
read -r stock
printf "Input start date (yyyymmdd): "
read -r from_unix_time
printf "Input end date (yyyymmdd): "
read -r to_unix_time

from_unix_time=$(date --date="${from_unix_time}EDT" "+%s")
to_unix_time=$(date --date="${to_unix_time}EDT" "+%s")
# EDT stands for Eastern Daylight Time
# %s -> Seconds since 1970-01-01 00:00:00 UTC.
url="https://query1.finance.yahoo.com/v7/finance/download/${stock^^}?period1=${from_unix_time}&period2=${to_unix_time}&interval=1d&events=history&includeAdjustedClose=true"

if [ ! -d "data/" ]
then
    mkdir data
fi

curl -o "data/${stock^^}.csv" "${url}"