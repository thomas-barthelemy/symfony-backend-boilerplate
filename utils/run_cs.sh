#!/bin/bash

# Params and default values
: ${CONTAINER_NAME:='backend_dev_web'}

# Checking if docker is available and running
hash docker > /dev/null && \
    docker ps 2>/dev/null | grep ${CONTAINER_NAME} > /dev/null && \
    HAS_DOCKER=1 || HAS_DOCKER=0

if [[ ${HAS_DOCKER} -eq 1 ]]; then
    PROJECT_PATH='/var/app'
else
    PROJECT_PATH='/vagrant/project'
fi

# Checking param
if [ "$1" = '-f' ]; then
    FIX_CMD="php-cs-fixer fix ${PROJECT_PATH} --config=sf23 -vv"
else
    FIX_CMD="phpcs --standard=PSR2 ${PROJECT_PATH}/src -n"
fi

if [[ ${HAS_DOCKER} -eq 1 ]]; then
    echo "(Docker) Running ${FIX_CMD}"
    docker exec -it ${CONTAINER_NAME} /var/app/bin/${FIX_CMD}
else
    echo "(Vagrant) Running ${FIX_CMD}"
    vagrant ssh -- -t "bash /vagrant/project/bin/${FIX_CMD}"
fi
