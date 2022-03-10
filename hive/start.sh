#!/bin/bash

# schematool init
$HIVE_HOME/bin/schematool -dbType derby -initSchema

# inf container
tail -f /dev/null 2>&1
