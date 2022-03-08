#!/usr/bin/env bash

#
# set Java ENV
#
val_java_home=$(readlink -f /usr/bin/javac)

echo export JAVA_HOME=${val_java_home:0:-10} >> ~/.bashrc
source ~/.bashrc

#
# set Hadoop ENV
#
echo export HADOOP_HOME="/hadoop_home/hadoop-2.7.7" >> ~/.bashrc
source ~/.bashrc

echo export HADOOP_CONFIG_HOME=$HADOOP_HOME/etc/hadoop >> ~/.bashrc
echo export PATH=$PATH:$HADOOP_HOME/bin >> ~/.bashrc
echo export PATH=$PATH:$HADOOP_HOME/sbin >> ~/.bashrc
echo "/usr/sbin/sshd" >> ~/.bashrc

source ~/.bashrc

#
# set Hadoop node directory
#
mkdir /hadoop_home/temp
mkdir /hadoop_home/namenode_dir
mkdir /hadoop_home/datanode_dir

#
# set node config
#
cp /tmp/config/core-site.xml $HADOOP_CONFIG_HOME/core-site.xml
cp /tmp/config/hdfs-site.xml $HADOOP_CONFIG_HOME/hdfs-site.xml
cp /tmp/config/mapred-site.xml $HADOOP_CONFIG_HOME/mapred-site.xml

#
# name node format
#
$HADOOP_HOME/bin/hadoop namenode -format

#
# run
#
cp /tmp/config/slaves $HADOOP_CONFIG_HOME/slaves
$HADOOP_HOME/sbin/start-all.sh

#
# sleep inf
#
tail -f /dev/null