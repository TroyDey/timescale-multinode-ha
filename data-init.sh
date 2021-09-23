#!/bin/sh
set -e

# Helper script that will be run as part of the Postgres docker container's init procedure
# Modifies the postgresql.conf file to enable multi-node TimeScaleDB

sed -ri "s/^#?(max_prepared_transactions)[[:space:]]*=.*/\1 = 150/;s/^#?(wal_level)[[:space:]]*=.*/\1 = logical/" /var/lib/postgresql/data/postgresql.conf
