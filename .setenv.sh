#
# SOURCE_* represents the config setup to connect to the source side of the Repliator
#
# Broker urls for the source cluster

export SOURCE_CLUSTER_ID=l5w5g
_broker_url=pkc-l5w5g.europe-west3.gcp.confluent.cloud:9092
export SOURCE_BROKER_SERVERS=${_broker_url},b0-${_broker_url},b1-${_broker_url},b2-${_broker_url},b3-${_broker_url},b4-${_broker_url}
export SOURCE_API_KEY=LIKDU2ITTTSFTFPP
export SOURCE_API_SECRET=1Qk2A6AJ9aD3OMHYTFwJ96WvyX3ZnpnUvKwwVKqpKsWlkNWq7wV81YQ/JubNt+B2


# e.g All  topic names  matching eu.xaz.* will be replicated
export REPLICA_TOPICS_SOURCE_REGEX=.*[.]eu-la
#  e.g.   eu.xaz.customerbillstopic from source  becomes  eu.xaz.customerbillstopic.copy in target cluster
export REPLICA_TOPICS_DEST_SUFFIX=copy

export DESTINATION_CLUSTER_ID=grape
_broker_url=pkc-lqrjp.us-west2.gcp.confluent.cloud:9092
export DESTINATION_BROKER_SERVERS=${_broker_url},b0-${_broker_url},b1-${_broker_url},b2-${_broker_url},b3-${_broker_url}

export DESTINATION_API_KEY=EO3T7XCFFK5DSA6C
export DESTINATION_API_SECRET=NUz1XqBj1+orYHDQLLzU/qBrZs4eolhH7cGuWv1krwEV4squqKcWt+X4ovYzS9Z/

export SOURCE_SIDE_TUNNEL_IP=35.246.229.124
export DESTINATION_SIDE_TUNNEL_IP=35.236.53.97