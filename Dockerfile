FROM alpine

#Install Curl 
RUN apk add --no-cache curl

#Copy Shell Script
COPY helloWorld.sh helloWorld.sh

#Set Script Permissions
CMD "chmod 775 helloWorld.sh"

#Set Shell Entry Point
ENTRYPOINT "/bin/sh"