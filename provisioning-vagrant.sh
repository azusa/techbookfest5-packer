#!/bin/bash

cd /vagrant
export PROXY_NAME="localhost"
bash provisioning.sh $1
