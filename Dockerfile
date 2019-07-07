FROM alpine

#Copy Shell Script
COPY helloWorld.sh helloWorld.sh
COPY curlMe.sh curlMe.sh
COPY csvParserBasic.sh csvParserBasic.sh
COPY csvParser.sh csvParser.sh
COPY csvParserFull.sh csvParserFull.sh
COPY sampleCSV.csv sampleCSV.csv

#Install Curl & Set Script Permissions
RUN apk add --no-cache curl; \
	chmod 775 helloWorld.sh; \
	chmod 775 curlMe.sh; \
	chmod 775 csvParserBasic.sh; \
	chmod 775 csvParser.sh; \
	chmod 775 csvParserFull.sh;

#Set Shell Entry Point
ENTRYPOINT "/bin/sh"
