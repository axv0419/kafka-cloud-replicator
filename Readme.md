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

# Usage

## 1. Prerequisites

## 2. Preperation

## 3-A. Setup at source VPC

## 3-B. Setup at destination VPC
