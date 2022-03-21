import os
import sys

if sys.argv[1] == "hdfs":
    if sys.argv[2] == "build":
        os.system("docker build -t hadoop_base:latest .")
        os.system("docker image prune")

    if sys.argv[2] == "up":
        os.system("docker-compose -f docker-compose.yml up -d nn01")
        os.system("docker-compose -f docker-compose.yml up -d nn02")
        os.system("docker-compose -f docker-compose.yml up -d dn01")
        os.system("docker-compose -f docker-compose.yml up -d dn02")
        os.system("docker-compose -f docker-compose.yml up -d dn03")

    if sys.argv[2] == "down":
        os.system("docker-compose -f docker-compose.yml stop nn01")
        os.system("docker-compose -f docker-compose.yml stop nn02")
        os.system("docker-compose -f docker-compose.yml stop dn01")
        os.system("docker-compose -f docker-compose.yml stop dn02")
        os.system("docker-compose -f docker-compose.yml stop dn03")

        os.system("docker-compose -f docker-compose.yml rm nn01")
        os.system("docker-compose -f docker-compose.yml rm nn02")
        os.system("docker-compose -f docker-compose.yml rm dn01")
        os.system("docker-compose -f docker-compose.yml rm dn02")
        os.system("docker-compose -f docker-compose.yml rm dn03")

if sys.argv[1] == "metastore":
    if sys.argv[2] == "build":
        os.system("cd ./mysql/master && docker build -t metastore-master:latest .")
        os.system("cd ./mysql/slave && docker build -t metastore-slave:latest .")
        os.system("docker image prune")

    if sys.argv[2] == "up":
        os.system("docker-compose -f docker-compose.yml up -d metastore-master")
        os.system("docker-compose -f docker-compose.yml up -d metastore-slave")

    if sys.argv[2] == "down":
        os.system("docker-compose -f docker-compose.yml stop metastore-master")
        os.system("docker-compose -f docker-compose.yml stop metastore-slave")

        os.system("docker-compose -f docker-compose.yml rm metastore-master")
        os.system("docker-compose -f docker-compose.yml rm metastore-slave")

if sys.argv[1] == "hive":
    if sys.argv[2] == "build":
        os.system("cd ./hive && docker build -t hive_base:latest .")
        os.system("docker image prune")

    if sys.argv[2] == "up":
        os.system("docker-compose -f docker-compose.yml up -d hs01")
        os.system("docker-compose -f docker-compose.yml up -d hs02")
        os.system("docker-compose -f docker-compose.yml up -d beeline")

    if sys.argv[2] == "down":
        os.system("docker-compose -f docker-compose.yml stop hs01")
        os.system("docker-compose -f docker-compose.yml up -d hs02")
        os.system("docker-compose -f docker-compose.yml stop beeline")

        os.system("docker-compose -f docker-compose.yml rm hs01")
        os.system("docker-compose -f docker-compose.yml up -d hs02")
        os.system("docker-compose -f docker-compose.yml rm beeline")

