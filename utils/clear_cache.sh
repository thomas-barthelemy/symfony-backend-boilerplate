#!/bin/bash

# Params and default values
: ${CONTAINER_NAME:='backend_dev_web'}
if [ $1 ]; then
    CLEAR_ENV=$1
else
    CLEAR_ENV='dev'
fi

# Checking if docker is available and running
hash docker > /dev/null && \
    docker ps 2>/dev/null | grep ${CONTAINER_NAME} > /dev/null && \
    HAS_DOCKER=1 || HAS_DOCKER=0

if [[ ${HAS_DOCKER} -eq 1 ]]; then
    echo "(Docker) Clearing symfony ${CLEAR_ENV} cache... (You can specify in parameter the environment to clear)"
    docker exec -it ${CONTAINER_NAME} \
        php /var/app/bin/console cache:clear --env=${CLEAR_ENV}
else
    echo "(Vagrant) Clearing symfony ${CLEAR_ENV} cache... You can specify in parameter the environment to clear)"
    vagrant ssh -- -t "php /vagrant/project/bin/console cache:clear --env=${CLEAR_ENV}"
fi