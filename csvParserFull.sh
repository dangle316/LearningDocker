#!/bin/sh
# setupapachevhost.sh - Apache webhosting automation demo script
file=sampleCSV.csv

WHITE="\e[0m"
RED="\e[31m"
EOR="|THISISTHEENDOFTHEREQUEST|"

USIP="65.51.93.34"
CAIP="110.33.122.75"


# set the Internal Field Separator to |
IFS='|'
while read -r url region shouldredirect redirecttext
do
	COLOR=$WHITE
	IPHEADER=""

	HEALTH=0
	
	# Build CURL Request
	case $region in
		*"CA"*)
			IPHEADER=$CAIP;;
		*"US"*)
			IPHEADER=$USIP;;
		*)
			IPHEADER=$USIP
			region="US"
			;;
	esac		

	#print test case
	printf "%b Checking (%s" $COLOR $region
	if [ "$shouldredirect" != '' ]; then
		if [ "$shouldredirect" == 'yes' ]; then
			printf("|Redirect")
		else
			printf("|NoRedirect")
		fi
	fi
	printf ") %s " $COLOR $url

	# Run Curl Command
	RESPONSE=$(curl -H "X-Forwarded-For: $IPHEADER" -s -w '|THISISTHEENDOFTHEREQUEST|%{http_code} - %{time_total}s - %{size_download}b' $url)
	
	# Parse Status From Response - https://superuser.com/questions/1001973/bash-find-string-index-position-of-substring
	STATUS=${RESPONSE#*$EOR}

	# Determine Health from Status Code
	case $STATUS in
		*"200 -"*)
			HEALTH=true;;
		*)
			HEALTH=false;;
	esac

	case $RESPONSE in
		*$redirecttext*)
			printf"***REDIRECT***";;
		*)
			printf"";;
	esac
	
	# Determine Color from Health
	if ! $HEALTH;
	then
		COLOR=$RED
	fi

	# Output Results		
	printf "%b Status: %s!\n" $COLOR $STATUS 


done < "$file"