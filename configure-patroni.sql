-- Setup users for replication, used by Patroni
CREATE USER replicator WITH SUPERUSER ENCRYPTED PASSWORD 'rep-pass';
CREATE USER rewind_user WITH SUPERUSER ENCRYPTED PASSWORD 'rewind_password';