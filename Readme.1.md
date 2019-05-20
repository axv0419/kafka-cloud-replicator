```bash
# set env
. ./replicator_env.sh
# prepare destination 
envsubst < ./template/docker-compose-dest.yaml > docker-compose-dest.yaml


# prepare source 
envsubst < ./template/docker-compose-src.yaml > docker-compose-src.yaml

```