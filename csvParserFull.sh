#!/bin/sh
# setupapachevhost.sh - Apache webhosting automation demo script
file=sampleCSV.csv

WHITE = "\e[0m"
RED = "\e[31m"


# set the Internal Field Separator to |
IFS='|'
while read -r url ip
do
	COLOR = $WHITE

    printf "%b Checking %s... " $COLOR $url

	STATUS=$(curl -s -o /dev/null -w '%{http_code} - %{time_total}' $url)

	case $STATUS in
		*"200 -"*)
			COLOR=$WHITE;;
		*)
			COLOR=$RED;;
	esac
		
	printf "%b Status: %s!\n" $COLOR $STATUS 
done < "$file"