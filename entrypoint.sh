#!/bin/bash

# start ssh service
/sbin/sshd

node=$1

if [ "$node" == "namenode" ]
then
  sleep 5
  echo 1 > /opt/zookeeper/data/myid
  /opt/zookeeper/bin/zkServer.sh start

  hdfs zkfc -formatZK
  $HADOOP_HOME/sbin/hadoop-daemon.sh start journalnode

  sleep 10
  hadoop namenode -format
  $HADOOP_HOME/sbin/hadoop-daemon.sh start namenode
  $HADOOP_HOME/sbin/hadoop-daemon.sh start zkfc

  sleep 10
  $HADOOP_HOME/sbin/start-yarn.sh
fi

if [ "$node" == "secondarynamenode" ]
then
  sleep 5
  echo 2 > /opt/zookeeper/data/myid
  /opt/zookeeper/bin/zkServer.sh start
  $HADOOP_HOME/sbin/hadoop-daemon.sh start journalnode

  sleep 10
  hdfs namenode -bootstrapStandby
  $HADOOP_HOME/sbin/hadoop-daemon.sh start namenode
  $HADOOP_HOME/sbin/hadoop-daemon.sh start zkfc

  sleep 10
  $HADOOP_HOME/sbin/yarn-daemon.sh start resourcemanager
  $HADOOP_HOME/sbin/yarn-daemon.sh start nodemanager
fi

if [ "$node" == "zkdatanode" ]
then
  sleep 5
  echo 3 > /opt/zookeeper/data/myid
  /opt/zookeeper/bin/zkServer.sh start
  $HADOOP_HOME/sbin/hadoop-daemon.sh start journalnode

  sleep 10
  $HADOOP_HOME/sbin/hadoop-daemon.sh start datanode
  $HADOOP_HOME/sbin/yarn-daemon.sh start nodemanager
fi

if [ "$node" == "datanode" ]
then
  sleep 15
  $HADOOP_HOME/sbin/hadoop-daemon.sh start datanode
  $HADOOP_HOME/sbin/yarn-daemon.sh start nodemanager
fi

tail -f /dev/null 2>&1