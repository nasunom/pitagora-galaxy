#!/bin/sh

service mysql start

cd /home/galaxy/galaxy
./run.sh --daemon

tail -f paster.log

