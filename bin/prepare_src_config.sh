#!/bin/bash

export BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"

echo "Using base directory $BASE_DIR"

. ${BASE_DIR}/setenv.sh
echo 

export DESTINATION_BOOTSTRAP_BROKER_URL=$(python -c "print(\"${DESTINATION_BROKER_SERVERS}\".split(',')[0])")
export SOURCE_BOOTSTRAP_BROKER_URL=$(python -c "print(\"${SOURCE_BROKER_SERVERS}\".split(',')[0])")

echo  Creating ${BASE_DIR}/docker-compose.yaml from template
python3 ${BASE_DIR}/bin/src_docker.py  > ${BASE_DIR}/docker-compose.yaml

python3 ${BASE_DIR}/bin/instructions.py

echo "#########"
echo "Start replicator destination tunnel and Confluent Replicator"
echo "cd ${BASE_DIR} ; docker-compose up -d"
echo "#########"
