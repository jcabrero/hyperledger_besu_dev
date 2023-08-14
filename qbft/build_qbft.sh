#/bin/bash

## Run the network setup for the files
# docker compose -f qbft-setup.yml

## Copy files to appropriate directories
clean() {
    docker compose -v
    rm -r 
}

create() {
    docker compose -f node1/docker-compose.yml up
}

if [ "$1" == "clean" ]; then
    clean
elif [ "$1" == "recreate" ]; then
    clean
    create
else
    create
fi
## Run node 1

