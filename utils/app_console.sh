#!/bin/bash
echo "Running: php bin/console $1"
vagrant ssh -c "php /vagrant/project/bin/console $1"