#!/bin/bash
if [[ `uname` = *"NT"* ]]; then
    if [ "$1" = '-f' ]; then
        echo 'Running code-sniffer fix'
        vagrant ssh -c 'bash "/vagrant/project/bin/php-cs-fixer fix /vagrant/project/ --config=sf23 -vv"'
    else
        echo 'Running code-sniffer (use -f to fix)...'
        vagrant ssh -c 'bash "/vagrant/project/bin/phpcs --standard=PSR2 /vagrant/project/src -n"'
    fi
else
    if [ "$1" = '-f' ]; then
        echo 'Running code-sniffer fix'
        vagrant ssh -c '/vagrant/project/bin/php-cs-fixer fix /vagrant/project/ --config=sf23 -vv'
    else
        echo 'Running code-sniffer (use -f to fix)...'
        vagrant ssh -c '/vagrant/project/bin/phpcs --standard=PSR2 /vagrant/project/src -n'
    fi
fi
