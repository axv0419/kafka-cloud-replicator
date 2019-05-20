FROM openjdk:8-jre-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh 

RUN mkdir /work
WORKDIR  /work
VOLUME  /cfg
ADD ccloud-0.2.1 ccloud-0.2.1
ADD .ccloud /root/.ccloud

ENTRYPOINT [ "/work/ccloud-0.2.1/bin/ccloud" ]