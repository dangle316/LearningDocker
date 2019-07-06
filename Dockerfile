FROM alpine

#Copy Shell Script
COPY helloWorld.sh helloWorld.sh

#Install Curl & Set Script PErmissions
RUN apk add --no-cache curl \
	chmod 775 /helloWorld.sh

#Set Shell Entry Point
ENTRYPOINT "/bin/sh"
