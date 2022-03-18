#!/bin/bash

node=$1

if [ "$node" == "hs2" ]
then
  # schematool init
  $HIVE_HOME/bin/schematool -dbType mysql -initSchema
  hdfs dfs -mkdir -p /app/tez
  hdfs dfs -put /opt/tez/share/tez.tar.gz /app/tez
  hive --service hiveserver2 --hiveconf hive.server2.thrift.port=10000
fi

if [ "$node" == "beeline" ]
then
  echo "beeline"
fi

# inf container
tail -f /dev/null 2>&1