#!/bin/bash

: ${WEB_PORT:=9290}
: ${DB_PORT:=9291}
: ${COMPOSER_HOME:=${HOME}/.composer}
: ${CONTAINER_WEB_NAME:='backend_dev_web'}
: ${CONTAINER_DB_NAME:='backend_dev_db'}

echo 'Backend App Docker Script:'
echo 'To modify the default App and DB port or the composer home directory
      you can use environment variables as follow:'
echo 'WEB_PORT=9290 DB_PORT=9291 COMPOSER_HOME=/home/my_user/.composer docker.startup.sh'
echo ''

# Stop on error
set -e

# Checking if docker is installed
if ! hash docker &> /dev/null; then
    echo 'Docker is not installed on this machine and is required for this script to work'
    exit
else
    # Checking that docker engine is started an accessible
    docker info > /dev/null
fi

####################################
echo "Starting Database if necessary on port $DB_PORT"

# Only Start and wait if db not already started
if ! docker ps | grep ${CONTAINER_DB_NAME} > /dev/null; then
    docker start ${CONTAINER_DB_NAME} 2> /dev/null || \
        docker run --name ${CONTAINER_DB_NAME} -d -p ${DB_PORT}:5432 postgres

    echo 'Waiting Database to start'
    sleep 12
fi

####################################
echo 'Setting Parameters.yml config'

rm -f ./project/app/config/parameters.yml || true
cp ./project/app/config/parameters.yml.dist ./project/app/config/parameters.yml
sed -i "s/database_host:.*/database_host: db/g" ./project/app/config/parameters.yml
sed -i "s/database_name:.*/database_name: postgres/g" ./project/app/config/parameters.yml
sed -i "s/database_user:.*/database_user: postgres/g" ./project/app/config/parameters.yml

####################################
echo 'Running Composer'

docker run \
    --rm \
    -v $(pwd)/project:/app \
    -v ${COMPOSER_HOME}:/root/.composer \
    -e COMPOSER_HOME=/root/.composer \
    -e SENSIOLABS_ENABLE_NEW_DIRECTORY_STRUCTURE=true \
    --link ${CONTAINER_DB_NAME}:db \
    webridge/composer:php7 \
    install --prefer-dist

####################################
echo "Starting Web App on port $WEB_PORT"

docker rm -f ${CONTAINER_WEB_NAME} 2> /dev/null || true
docker run -d \
    --name ${CONTAINER_WEB_NAME} \
    -v $(pwd)/project:/var/app \
    -p ${WEB_PORT}:80 \
    --add-host=archive.ubuntu.com:127.0.0.1 \
    --link ${CONTAINER_DB_NAME}:db \
    webridge/symfony-app:php70


#####################################
# revert stop on error
set +e

echo 'Done!'