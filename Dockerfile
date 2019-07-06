FROM alpine

#Install Curl 
RUN apk add --no-cache curl

#Set Shell Entry Point
ENTRYPOINT "/bin/sh"