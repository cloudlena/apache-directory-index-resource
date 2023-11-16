FROM amd64/alpine

RUN apk update
RUN apk upgrade
RUN apk add --no-cache bash curl wget jq pup

COPY scripts/ /opt/resource/
RUN chmod +x /opt/resource/*
