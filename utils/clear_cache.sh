#!/bin/bash
echo 'Clearing symfony cache... (You can specify in parameter the environment to clear)'
if [ $1 ]; then
    vagrant ssh -c "php /vagrant/project/bin/console cache:clear --env=$1"
else
    vagrant ssh -c 'php /vagrant/project/bin/console cache:clear --env=dev'
fi