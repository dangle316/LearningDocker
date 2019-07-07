#!/bin/sh
# setupapachevhost.sh - Apache webhosting automation demo script
file=sampleCSV.csv

# set the Internal Field Separator to |
IFS='|'
while read -r url ip
do
        printf "\e[0m Checking %s... " $url
		STATUS=$(curl -s -o /dev/null -w '%{http_code} - %{time_total}' $url)

		COLOR="\e[0m"
		
		case $STATUS in
			*"200 -"*)
				COLOR="\e[0m";;
			*)
				COLOR="\e[32m";;
		esac
		
		printf "%b Status: %s!\n" $COLOR $STATUS 
done < "$file"