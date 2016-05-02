#!/bin/bash
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
    echo '              Runs tests for test classe(s) <classNameTest.php>.'
    exit;
fi

if [[ $USER != 'vagrant' ]]; then
    vagrant ssh -- -t "bash /vagrant/project/utils/run_tests.sh $@"
else
    cd /vagrant/project

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
                                    for file in $( find . -iname "$1*" | grep "Test\.php$" ); do
                                        param="$param --filter $(basename $file .php) $file"
                                        echo "Found matching test file: $file"
                                        break
                                    done
                                    ;;
            * )                     echo 'Invalid paramters, run -h or --help for more information'
                                    exit 1
        esac
        shift
    done
    echo ''
    bin/phpunit $param
fi
