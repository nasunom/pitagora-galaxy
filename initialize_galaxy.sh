#!/bin/sh

service mysql start

install_log='/home/galaxy/galaxy_install.log'

cd /home/galaxy/galaxy
./run.sh --daemon --log-file=$install_log --pid-file=galaxy_install.pid

galaxy_install_pid=`cat galaxy_install.pid`
while : ; do
    tail -n 2 $install_log | grep -q "Starting server in PID $galaxy_install_pid"
    if [ $? -eq 0 ] ; then
        echo "Galaxy is running."
        break
    fi
done

exit_code=$?

if [ $exit_code != 0 ] ; then
    exit $exit_code
fi

./run.sh --stop-daemon --log-file=$install_log --pid-file=galaxy_install.pid

service mysql stop

