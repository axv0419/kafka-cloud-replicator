import os


src_side_tunnel_ip=os.environ['SOURCE_SIDE_TUNNEL_IP']
tgt_side_tunnel_ip=os.environ['DESTINATION_SIDE_TUNNEL_IP']
broker_urls=[item.strip() for item in os.environ['SOURCE_BROKER_SERVERS'].split(',')]

ports = [15060 + (ix*2)  for ix in range (len(broker_urls))]

print(f'''
Using GCP Admin console  open firewall on {tgt_side_tunnel_ip} for inbound traffic from {src_side_tunnel_ip} on ports {ports}
''')


