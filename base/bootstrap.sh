#!/bin/bash

/usr/sbin/sshd -D &

export JAVA_HOME=/usr/java/jdk1.8.0_181-amd64

$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh

/bin/bash