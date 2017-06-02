#!/bin/bash
wget -O install_salt.sh https://bootstrap.saltstack.com
sudo sh install_salt.sh -A ${salt_master}
salt-call --local grains.setval roles ${roles}
salt-call --local grains.setval environment ${environment}
touch /tmp/signal
