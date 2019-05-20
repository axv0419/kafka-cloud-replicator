FROM openjdk:8-jre-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh 

RUN mkdir /work
WORKDIR  /work
VOLUME  /cfg

RUN mkdir -p /tmp
COPY ./ccloud-latest.tar.gz /tmp
RUN mkdir -p /app && \
    cd /app && tar xzf /tmp/ccloud-latest.tar.gz 


ENTRYPOINT [ "/app/ccloud-0.2.1/bin/ccloud" ]