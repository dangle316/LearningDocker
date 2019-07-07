#!/bin/sh
# setupapachevhost.sh - Apache webhosting automation demo script
file=sampleCSV.csv

WHITE="\e[0m"
RED="\e[31m"
GREEN="\e[92m"
EOR="|THISISTHEENDOFTHEREQUEST|"

USIP="65.51.93.34"
CAIP="192.206.151.131"
UKIP="185.35.50.4"
CNIP="221.192.199.49"
JPIP="219.118.201.119"
AUIP="110.33.122.75"


# set the Internal Field Separator to |
IFS='|'
while read -r url region shouldredirect redirecttext
do
	COLOR=$WHITE
	IPHEADER=""

	POPUPSHOWN=false
	HEALTH=true
	
	# Build CURL Request
	case $region in
		*"CA"*)
			IPHEADER=$CAIP;;
		*"UK"*)
			IPHEADER=$CAIP;;
		*"CN"*)
			IPHEADER=$CAIP;;
		*"JP"*)
			IPHEADER=$CAIP;;
		*"AU"*)
			IPHEADER=$CAIP;;
		*"US"*)
			IPHEADER=$USIP;;
		*)
			IPHEADER=$USIP
			region="US"
			;;
	esac		

	#print test case
	printf "%b Checking;(%s" $COLOR $region
	if [ "$shouldredirect" == 'YES' ]; then
		printf "/PopUp"
	elif [ "$shouldredirect" == 'NO' ]; then
		printf "/NoPopUp"
	fi
	printf ");%s;" $url

	# Run Curl Command
	RESPONSE=$(curl -H "X-Forwarded-For: $IPHEADER" -s -w '|THISISTHEENDOFTHEREQUEST|%{http_code};%{time_total};%{size_download}' $url)
	printf ".....;"

	printf "%s" $RESPONSE

	#Run PupUp Checks
	if [ "$shouldredirect" != '' ]; then

		# Parse if PopUp was shown
		case $RESPONSE in
			*$redirecttext*)
				POPUPSHOWN=true;;
			*)
				POPUPSHOWN=false;;
		esac

		# Check PopUp for Health
		if [ "$shouldredirect" == "YES" ] &&  $POPUPSHOWN ; then
			printf "PopUp;"
		elif [ "$shouldredirect" == "YES" ] &&  ! $POPUPSHOWN ; then
			printf "%bNoPopUp%b;" $RED $WHITE
			HEALTH=false
		elif [ "$shouldredirect" == "NO" ] &&  $POPUPSHOWN ; then
			printf "%bPopUp%b;" $RED $WHITE
			HEALTH=false
		elif [ "$shouldredirect" == "NO" ] &&  ! $POPUPSHOWN ; then
			printf "NoPopUp;"
		fi
	else
		printf "NotTested;"
	fi
	
	# Parse Status From Response - https://superuser.com/questions/1001973/bash-find-string-index-position-of-substring - ***TODO THIS IS VERY POOR PERFORMANCE
	STATUS=${RESPONSE#*$EOR}

	# Check Status Code checks
	case $STATUS in
		*"200;"*)
			printf "%s;" $STATUS;;
		*)
			printf "%b%s%b;" $RED $STATUS $WHITE
			HEALTH=false;;
	esac

	if $HEALTH;
	then	
		printf "%bPassed%b\n" $GREEN $WHITE
	else	
		printf "%bFailed%b\n" $RED $WHITE
	fi
	
done < "$file"