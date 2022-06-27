#!/bin/bash

function init_container()
{
    # postgresql listener
    echo "listen_addresses = '*'" >> /etc/postgresql/11/main/postgresql.conf

    # for pmm
    echo "shared_preload_libraries = 'pg_stat_statements'" >> /etc/postgresql/11/main/postgresql.conf
    echo "track_activity_query_size = 2048" >> /etc/postgresql/11/main/postgresql.conf
    echo "pg_stat_statements.track = all" >> /etc/postgresql/11/main/postgresql.conf
    echo "track_io_timing = on" >> /etc/postgresql/11/main/postgresql.conf
    echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/11/main/pg_hba.conf

    # restart postgresql
    service postgresql restart

    # install extention for pmm
    psql -c "create extension pg_stat_statements schema public;";
    psql -c "alter user postgres with password 'postgres';";

    echo "Container is ready!"

    while true; do sleep 1; done
}

init_container

