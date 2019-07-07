#!/bin/sh
# setupapachevhost.sh - Apache webhosting automation demo script
file=sampleCSV.csv

WHITE="\e[0m"
RED="\e[31m"
EOR="|THISISTHEENDOFTHEREQUEST|"


# set the Internal Field Separator to |
IFS='|'
while read -r url ip
do
	COLOR=$WHITE

	printf "%b Checking %s... " $COLOR $url
	
	# Run Curl Command
	RESPONSE=$(curl -s -w $EOR'%{http_code} - %{time_total}' $url)
	
	# Parse Status From Respons - https://superuser.com/questions/1001973/bash-find-string-index-position-of-substring
	STATUS=${RESPONSE#*$EOR}

	# Determine Color from Status Code
	case $STATUS in
		*"200 -"*)
			COLOR=$WHITE;;
		*)
			COLOR=$RED;;
	esac

	# Output Results		
	printf "%b Status: %s!\n" $COLOR $STATUS 


done < "$file"