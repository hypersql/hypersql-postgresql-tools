#!/bin/bash

function init_container()
{
    # start pmm-agent
    echo "pmm-agent RUN";
    touch /etc/pmm-agent.yaml
    pmm-agent --config-file=/etc/pmm-agent.yaml &

    # connecttion between ppm-agent and ppm-server
    echo "pmm-admin CONFIG";
    sleep 30;
    pmm-admin config --force --server-insecure-tls --server-url=https://admin:admin@127.0.0.1:443

    # add postgresql to monitor
    echo "pmm-admin ADD postgresql";
    pmm-admin add postgresql --username=postgres --password=postgres postgres 127.0.0.1:5432 --query-source=pgstatements

    echo "Container is ready!"
    echo "Access http://127.0.0.1 through web browser."

    while true; do sleep 1; done
}

init_container

