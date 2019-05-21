## Kakfa Cloud Replicator

Kafka clusters provide reliable event ingestion and processing within a cloud VPC region however some applcations need to replicate topics securely and effectively between Kafka Clusters running in different cloud VPC regions.

<img src="docs/images/Replicator-01.svg" />


Tools such as confluent Repliator and Kafka Mirror maker can replicate topics and events across multi datacenter Kafka deployments. However there are few challenges.

## Challenges

1. _Broker visibility_ : The kafka broker hosts are typically protected by a firewall and are not exposed on the internet. The Kafka services are used from a peered local VPC. Replicator is a Kafka Client program and like a typical Kafka client it needs to be able to establish connection to all the broker servers on both the source and target clusters.
2. _Hostname lookup requirements_ : SASL security imposes the requirement that the client name should be able to lookup and connect to Brokers by using their specified FQDNs which appear in the Client <-> Kafka Cluster connection handshake.

## Extending VPC via secure TCP tunnel
<img src="docs/images/Replicator-02.svg" />

<img src="docs/images/Replicator-03.svg" />

## Usage

## 1. Prerequisites

* Running kafka clusters either on public/private cloud
* VMs enabled with docker version 18 + and docker-compose version 3.0 +
* VMs should have a publically accessibe public IP

## 2. Preperation

Create the project folder 

```bash
# Create project directory
> git clone <THIS GIT REPO> ~/workspace/kafka-cloud-replicator
> cd ~/workspace/kafka-cloud-replicator
# Create setenv.sh file here with the content from step 2
```

Create a `~/workspace/kafka-cloud-replicator/setenv.sh` from the `setenv.sh.template` file in the project folder

```bash

#
# SOURCE_* represents the config setup to connect to the source side of the Repliator
#

export SOURCE_CLUSTER_ID=orange
export SOURCE_BROKER_SERVERS=pkc-orange.us-east1.gcp.confluent.cloud:9092,b0-pkc-orange.us-east1.gcp.confluent.cloud:9092,b1-pkc-orange.us-east1.gcp.confluent.cloud:9092
export SOURCE_API_KEY=srckee
export SOURCE_API_SECRET=srcscrtsrcscrt



#
# Destination_* represents the config setup to connect to the destination side of the Repliator
#

export DESTINATION_CLUSTER_ID=grape
export DESTINATION_BROKER_SERVERS=pkc-grape.us-west1.gcp.confluent.cloud:9092,b0-pkc-grape.us-west1.gcp.confluent.cloud:9092,b1-pkc-grape.us-west1.gcp.confluent.cloud:9092,b2-pkc-grape.us-west1.gcp.confluent.cloud:9092
export DESTINATION_API_KEY=dstkee
export DESTINATION_API_SECRET=dstscrtdstscrt


# e.g All  topic names  matching eu.xaz.* will be replicated
export REPLICA_TOPICS_SOURCE_REGEX=eu[.]xaz[.].*
#  e.g.   eu.xaz.customerbillstopic from source  becomes  eu.xaz.customerbillstopic.copy in target cluster
export REPLICA_TOPICS_DEST_SUFFIX=copy


export SOURCE_SIDE_TUNNEL_IP=433.34.23.45
export DESTINATION_SIDE_TUNNEL_IP=476.34.23.45

```
> Firewall ports will need to be opened - Read the output of following commands. 

## 3-A. Setup at source VPC

Run following commands on the VM peered with the `source` Kafka Cluster

```bash
> cd ~/workspace/kafka-cloud-replicator
# edit the setenv.sh
> vi setenv.sh
# Prepare the configuration
> ./bin/prepare_src_config.sh
```

>  The output shows the Firewall ports that need to be open

Run docker containers on the source

```bash
> docker-compose up -d
```

## 3-B. Setup at destination VPC

Run following commands on the VM peered with the `destination` Kafka Cluster

```bash
# Replicate git
> git clone <THIS GIT REPO> ~/workspace/kafka-cloud-replicator
> cd ~/workspace/kafka-cloud-replicator
# Create setenv.sh file here with the content from step 2
> vi setenv.sh
# Prepare the configuration
> ./bin/prepare_dest_config.sh
```

> The output shows the Firewall ports that need to be open

Run docker containers on the source

```bash
 > docker-compose up -d
```

## 4. Testing

If all goes well you should be able to see the connector with name `replicator-${source_cluster_id}` in the control center

* Test for topic replication from source to target
* Test for topic partition balancing between source and target
* Test event propogation from source to target

## Troubleshooting

> docker-compose fail- ERROR: Pool overlaps with other one on this address space
```bash
# Clean networks
docker network ls -q | xargs docker network rm
# Retry
docker-compose up -d
```