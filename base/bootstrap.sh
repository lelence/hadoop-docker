#!/bin/bash

/usr/sbin/sshd -D &

sed s/HOSTNAME/$HOSTNAME/ $HADOOP_CONF_DIR/core-site.xml.template > $HADOOP_CONF_DIR/core-site.xml

$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh

# $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver

/bin/bash