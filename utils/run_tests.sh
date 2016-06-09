#!/bin/bash

# Params and default values
: ${CONTAINER_NAME:='backend_dev_web'}

if [ "$1" = '-h' -o "$1" = '--help' ]; then
    echo 'Usage: run_tests.sh [-c] [-t] {[-g <groupName>] | [-f <className>]}'
    echo ''
    echo 'Default: Runs all tests'
    echo ''
    echo 'Common Commands:';
    echo '    -c, --coverage'
    echo '              Runs all tests and generate code coverage'
    echo ''
    echo '    -t, --textdox'
    echo '              Runs tests with increased verbosity'
    echo ''
    echo '    -g, --group <groupName>'
    echo '              Runs tests of the specified group'
    echo ''
    echo '    -f, --fileName <classNameTest>'
    echo '              Runs tests for test class(es) <classNameTest.php>.'
    exit;
fi

# Checking if docker is available and running
hash docker &> /dev/null && \
    docker ps 2>/dev/null | grep ${CONTAINER_NAME} > /dev/null && \
    HAS_DOCKER=1 || HAS_DOCKER=0

if [[ ${USER} != 'vagrant' && ${HAS_DOCKER} -eq 0 ]]; then
    vagrant ssh -- -t "bash /vagrant/utils/run_tests.sh ${ORIGINAL_PARAM}"
    exit
fi

param="-c app";

while [ "$1" != "" ]; do
    case $1 in
        -c | --coverage )       param="$param --coverage-html web/cov/"
                                ;;
        -t | --testdox )        param="$param --testdox"
                                ;;
        -g | --group )          shift
                                param="$param --group $1"
                                ;;
        -f | --file )           shift
                                if [[ ${HAS_DOCKER} -eq 1 ]]; then
                                    for file in $( docker exec -it ${CONTAINER_NAME} find /var/app/src -iname "$1*" | grep "Test\.php" | tr -d '\r'); do
                                        param="$param --filter $(docker exec -it ${CONTAINER_NAME} basename ${file} .php) $file"
                                        echo "Found matching test file: $file"
                                        break
                                    done
                                else
                                    for file in $( find /vagrant/project/src -iname "$1*" | grep "Test\.php$" ); do
                                        param="$param --filter $(basename $file .php) $file"
                                        echo "Found matching test file: $file"
                                        break
                                    done
                                fi
                                shift
                                ;;
        * )                     echo 'Invalid parameters, run -h or --help for more information'
                                exit 1
    esac
    shift
done

if [[ ${HAS_DOCKER} -eq 1 ]]; then
    echo "(Docker) Running phpunit $(echo ${param} | tr -d '\r')"
    docker exec -it ${CONTAINER_NAME} bash -c "cd /var/app && /var/app/bin/phpunit $(echo ${param} | tr -d '\r')"
    exit
fi


echo "(Vagrant) Running phpunit ${param}"
cd /vagrant/project
bin/phpunit ${param}
