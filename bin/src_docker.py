import os



broker_urls=[item.strip() for item in os.environ['SOURCE_BROKER_SERVERS'].split(',')]

out_str = ['''version: "3.0"
services:''']

for ix in range (len(broker_urls)):
  broker_url = broker_urls[ix]
  port = 15060 + (ix*2)
  container = f'''  kafka-boot-broker-{ix}:
  image: m7dock/gotunnel:01
  container_name: kafka-boot-broker-{ix}
  ports:
    - {port}:9092
  entrypoint:
  - /work/gotunnel
  - -backend
  - {broker_url}
  - -listen 
  - :9092 
  - -tunnels 
  - "0"'''
  out_str.append(container)
print ("\n".join(out_str))
    