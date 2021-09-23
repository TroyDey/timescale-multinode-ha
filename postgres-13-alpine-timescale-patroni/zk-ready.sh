# Waits for zookeeper to be up 
echo "Waiting for zookeeper"

zookeeper_is_up="$(echo srvr | nc zookeeper 2181 | grep Mode)"

while [ -z "$zookeeper_is_up" ]; do
    echo "."
    sleep 1
    zookeeper_is_up="$(echo srvr | nc zookeeper 2181 | grep Mode))"
done

sleep 10 

echo "Zookeeper is up and running..."