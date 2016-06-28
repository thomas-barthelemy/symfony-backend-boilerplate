#!/bin/bash

# Params and default values
: ${CONTAINER_NAME:='backend_dev_web'}

# Checking if docker is available and running
hash docker > /dev/null && \
    docker ps 2>/dev/null | grep ${CONTAINER_NAME} > /dev/null && \
    HAS_DOCKER=1 || HAS_DOCKER=0

if [[ ${HAS_DOCKER} -eq 1 ]]; then
    echo "(Docker) Running: php bin/console $@"
    docker exec -it ${CONTAINER_NAME} php /var/app/bin/console $@
else
    echo "(Vagrant) Running: php bin/console $@"
    vagrant ssh -- -t "cd /vagrant/project && php ./bin/console $@"
fi