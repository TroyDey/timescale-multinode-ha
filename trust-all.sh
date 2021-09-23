#!/bin/sh
set -e

# Allow trust access to all
# for some reason the patroni hba config doesn't get
# written out so if we don't modify the file ourselves
# replication will fail
sed -i '$ d' /var/lib/postgresql/data/pg_hba.conf

echo "host replication replicator all md5" >>/var/lib/postgresql/data/pg_hba.conf
echo "host all all all trust" >>/var/lib/postgresql/data/pg_hba.conf

sed -ri "s!^#?(listen_addresses)\s*=.*!\1 = '0.0.0.0'!" /var/lib/postgresql/data/postgresql.conf