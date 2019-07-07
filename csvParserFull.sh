#!/bin/sh
# setupapachevhost.sh - Apache webhosting automation demo script
file=sampleCSV.csv

# set the Internal Field Separator to |
IFS='|'
while read -r url ip
do
        printf "Checking %s... " $url
		STATUS=$(curl -s -o /dev/null -w '%{http_code} - %{time_total}' $url)

		COLOR="\e[0m"

		if($STATUS!=*"200 -")
			COLOR="\e[31m"

		printf "%sStatus: %s!\n" $COLOR $STATUS
done < "$file"