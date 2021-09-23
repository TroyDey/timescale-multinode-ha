#!/usr/bin/python3

# Checks zookeeper to see if the initial primary 
# has fully initialized and waits until init is complete

import time
from kazoo.client import KazooClient

print("Waiting for primary to come up...")
print("Connecting to Zookeeper")

zk = KazooClient(hosts='zookeeper:2181')
zk.start()

print("Begin wait loop...")

while not zk.exists('/service/kraken-mare/members/tsdb-access-admin'):
    print('Primary not up, sleeping...')
    time.sleep(1)

print("Primary up!")
    