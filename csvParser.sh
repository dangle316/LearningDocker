#!/bin/sh
# setupapachevhost.sh - Apache webhosting automation demo script
file=sampleCSV.csv

# set the Internal Field Separator to |
IFS='|'
while read -r url ip
do
        printf "Checking %s... " $url
		STATUS=$(curl -s -o /dev/null -w '%{http_code}' $url)
		printf "Status: %s!\n" $STATUS

	
done < "$file"