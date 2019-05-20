import os


src_cluster_id=os.environ['SOURCE_CLUSTER_ID']
src_side_tunnel_ip=os.environ['SOURCE_SIDE_TUNNEL_IP']
broker_urls=[item.strip() for item in os.environ['SOURCE_BROKER_SERVERS'].split(',')]


out_str = ['''version: "3.0"
services:''']
for ix in range (len(broker_urls)):
    broker_url = broker_urls[ix]
    broker_host ,broker_port=broker_url.split(":")
    port = 15060 + (ix*2)
    out_str.append('''  {broker_host}:
    image: m7dock/gotunnel:01
    container_name: broker-proxy-{ix}
    networks:
        tunnel_net:
            ipv4_address: 172.28.1.{ix}
    entrypoint:
    - /work/gotunnel
    - -backend
    - {src_side_tunnel_ip}:{port}
    - -listen 
    - :9092 
    - -tunnels 
    - "3"'''.format(port=port,ix=ix,broker_host=broker_host,src_side_tunnel_ip=src_side_tunnel_ip))

out_str.append('''  {src_cluster_id}.replicator:
    image: confluentinc/cp-enterprise-replicator-executable:5.2.1
    container_name: {src_cluster_id}-replicator
    networks:
        tunnel_net:
            ipv4_address: 172.28.1.54
    environment: 
      - REPLICATOR_LOG4J_ROOT_LOGLEVEL=DEBUG
    volumes:
      - ./config:/etc/replicator
  cc-cli:
    image: av/ccloud
    container_name: ccloud
    networks:
        tunnel_net:
            ipv4_address: 172.28.1.30      
networks:
    tunnel_net:
        ipam:
            driver: default
            config:
                - subnet: 172.28.0.0/16'''.format(src_cluster_id=src_cluster_id))
print ("\n".join(out_str))
    