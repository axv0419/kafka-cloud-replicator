#!/bin/bash

BASE_DIR="$( cd "$(dirname "$0")/.."; pwd -P )"
echo 
echo "Using base directory $BASE_DIR"
. ${BASE_DIR}/setenv.sh
echo 

export DESTINATION_BOOTSTRAP_BROKER_URL=$(python -c "print(\"${DESTINATION_BROKER_SERVERS}\".split(',')[0])")
export SOURCE_BOOTSTRAP_BROKER_URL=$(python -c "print(\"${SOURCE_BROKER_SERVERS}\".split(',')[0])")
export DOLLAR='$'

mkdir -p ${BASE_DIR}/config
echo  Creating ${BASE_DIR}/config/producer.properties from template
envsubst < ${BASE_DIR}/template/producer.properties > ${BASE_DIR}/config/producer.properties

echo  Creating ${BASE_DIR}/config/consumer.properties from template
envsubst < ${BASE_DIR}/template/consumer.properties > ${BASE_DIR}/config/consumer.properties


echo  Creating ${BASE_DIR}/config/replication.properties from template
envsubst < ${BASE_DIR}/template/replication.properties > ${BASE_DIR}/config/replication.properties


echo  Creating ${BASE_DIR}/docker-compose.yaml from template
python3 ${BASE_DIR}/bin/dest_docker.py  > ${BASE_DIR}/docker-compose.yaml


python3 ${BASE_DIR}/bin/instructions.py

echo "#########"
echo "Start replicator destination tunnel and Confluent Replicator"
echo "cd ${BASE_DIR} ; docker-compose up -d"
echo "#########"
