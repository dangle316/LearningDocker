#!/bin/sh
# setupapachevhost.sh - Apache webhosting automation demo script
file=sampleCSV.csv

WHITE="\e[0m"
RED="\e[31m"
EOR="|THISISTHEENDOFTHEREQUEST|"

USIP="65.51.93.34"
CAIP=""


# set the Internal Field Separator to |
IFS='|'
while read -r url region shouldredirect redirecttext
do
	COLOR=$WHITE
	IPHEADER=""

	HEALTH=0
	
	printf "%b Checking %s... " $COLOR $url

	# Build CURL Request
	case $region in
		*"CA"*)
			IPHEADER="-H \"X-Forwarded-For: $CAIP \"";;
		*"US"*)
			IPHEADER="-H \"X-Forwarded-For: $USIP \"";;
		*)
			IPHEADER="";;
	esac		

	# Run Curl Command
	RESPONSE=$(curl -s -w '|THISISTHEENDOFTHEREQUEST|%{http_code} - %{time_total}s - %{size_download}b' $url)
	
	# Parse Status From Response - https://superuser.com/questions/1001973/bash-find-string-index-position-of-substring
	STATUS=${RESPONSE#*$EOR}

	# Determine Health from Status Code
	case $STATUS in
		*"200 -"*)
			HEALTH=true;;
		*)
			HEALTH=false;;
	esac
	
	# Determine Color from Health
	if ! $HEALTH;
	then
		COLOR=$RED
	fi

	# Output Results		
	printf "%b Status: %s!\n" $COLOR $STATUS 


done < "$file"