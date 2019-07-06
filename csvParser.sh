#!/bin/sh
# setupapachevhost.sh - Apache webhosting automation demo script
file=sampleCSV.csv

# set the Internal Field Separator to |
IFS='|'
while read -r url ip
do
        printf "Checking " $url "...\n"
		curl -o -I -L -s -w "%{http_code}" $url

	
done < "$file"