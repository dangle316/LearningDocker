#!/bin/sh
# setupapachevhost.sh - Apache webhosting automation demo script
file=sampleCSV.csv

WHITE= "\e[0m"
RED= "\e[31m"
EOR = "|THISISTHEENDOFTHEREQUEST|"


# set the Internal Field Separator to |
IFS='|'
while read -r url ip
do
	COLOR=$WHITE

	printf "%b Checking %s... " $COLOR $url
	
	# Run Curl Command
	RESPONSE=$(curl -s -o /dev/null -w $EOR'%{http_code} - %{time_total}' $url)
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