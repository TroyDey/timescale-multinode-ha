# Multi-Node TimeScale with HA Access Node
Run a multi-node Timescale cluster locally using docker-compose with HA access nodes.

## Setup

* Docker with docker compose
* Image: timescale/timescaledb:2.4.2-pg13
* 3 access nodes
* 3 data nodes
* The access nodes are configured in HA with one leader and two replicas using Patroni

The multi-node setup with docker was adapted from [Multi-Node-TimescaleDB](https://github.com/binakot/Multi-Node-TimescaleDB)
Involves modifications of the Postgres and Timescale Docker setups
[Base Postgres Image](https://github.com/docker-library/postgres/tree/master/13/alpine)
[Base Timescale Image](https://github.com/timescale/timescaledb-docker)

Patroni is used to provide HA for the access nodes.  This requires modifications to the base images.

[Patroni](https://github.com/zalando/patroni)

## Run

```
docker-compose build ; docker-compose up
```