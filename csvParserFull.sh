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
	HEALTH=0

	printf "%b Checking %s... " $COLOR $url
	
	# Run Curl Command
	RESPONSE=$(curl -s -w '|THISISTHEENDOFTHEREQUEST|%{http_code} - %{time_total}' $url)
	
	# Parse Status From Response - https://superuser.com/questions/1001973/bash-find-string-index-position-of-substring
	STATUS=${RESPONSE#*$EOR}

	# Determine Health from Status Code
	case $STATUS in
		*"200 -"*)
			HEALTH=0;;
		*)
			HEALTH=1;;
	esac
	
	# Determine Color from Health
	if[$HEALTH==1]
	then
		COLOR=$RED
	fi

	# Output Results		
	printf "%b Status: %s!\n" $COLOR $STATUS 


done < "$file"