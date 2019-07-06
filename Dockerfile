FROM alpine

#Install Curl 
RUN apk add --no-cache curl

#Copy Shell Script
COPY helloWorld.sh hellowWorld.sh

#Set Shell Entry Point
ENTRYPOINT "/bin/sh"