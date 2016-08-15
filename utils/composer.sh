#!/bin/bash
# Params and default values
: ${CONTAINER_NAME:='backend_dev_web'}
: ${COMPOSER_HOME:=${HOME}/.composer}

# Checking if docker is available and running
hash docker > /dev/null && \
    docker ps 2>/dev/null | grep ${CONTAINER_NAME} > /dev/null && \
    HAS_DOCKER=1 || HAS_DOCKER=0

if [[ ${HAS_DOCKER} -eq 1 ]]; then
    echo "(Docker) Running: composer $@"

    # Script directory
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    # Project directory
    PROJECT_DIR="$( readlink -f ${SCRIPT_DIR}/../project )"
    # Running composer container
    docker run \
        --rm \
        -v ${PROJECT_DIR}:/app \
        -v ${COMPOSER_HOME}:/root/.composer \
        -e COMPOSER_HOME=/root/.composer \
        -e SENSIOLABS_ENABLE_NEW_DIRECTORY_STRUCTURE=true \
        webridge/composer:php7 \
        $@
else
    echo "(Vagrant) Running: composer $@"
    vagrant ssh -- -t "cd /vagrant/project && composer $@"
fi
