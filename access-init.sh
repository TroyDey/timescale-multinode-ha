#!/bin/sh
set -e

# Helper script that will be run as part of the Postgres docker container's init procedure
# Modifies the postgresql.conf file to enable multi-node TimeScaleDB
# It MUST wait for the data node containers to be up and available as the next files
# that the init procedure will run are the 888 and 999 sql files which will
# setup the database and add these docker containers as data nodes.

sed -ri "s/^#?(enable_partitionwise_aggregate)[[:space:]]*=.*/\1 = on/;s/^#?(wal_level)[[:space:]]*=.*/\1 = logical/;s/^#?(jit)[[:space:]]*=.*/\1 = off/" /var/lib/postgresql/data/postgresql.conf
# Patroni will replace the conf file with its own based on the its config 
# that will include postgresql.base.conf, we copy our currnt config there
cp /var/lib/postgresql/data/postgresql.conf /var/lib/postgresql/data/postgresql.base.conf

# Some of the config properties timescaledb-tune alters will be overriden
# by Patroni's postgres section in the yml file since these properties 
# need to be the same across replicas, we could update the patroni yml with 
# these changes here, but for simplicity we just hardcode some good values in the patroni yml.
# max_worker_processes
# max_prepared_transactions
# max_locks_per_transaction

# The data nodes need to be up so that we can add them in the database
echo "Waiting for data nodes..."
until PGPASSWORD=$POSTGRES_PASSWORD psql -h tsdb-data1 -U "$POSTGRES_USER" -c '\q'; do
    sleep 5s
done
until PGPASSWORD=$POSTGRES_PASSWORD psql -h tsdb-data2 -U "$POSTGRES_USER" -c '\q'; do
    sleep 5s
done
until PGPASSWORD=$POSTGRES_PASSWORD psql -h tsdb-data2 -U "$POSTGRES_USER" -c '\q'; do
    sleep 5s
done
