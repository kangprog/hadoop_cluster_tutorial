import os
import sys

if sys.argv[1] == "build":
    os.system("docker build -t hadoop_base:latest .")
    os.system("docker image prune")
    print("Base Image Build")

elif sys.argv[1] == "up":
    os.system("docker-compose -f docker-compose.yml up -d nn01")
    os.system("docker-compose -f docker-compose.yml up -d nn02")
    os.system("docker-compose -f docker-compose.yml up -d dn01")
    os.system("docker-compose -f docker-compose.yml up -d dn02")
    os.system("docker-compose -f docker-compose.yml up -d dn03")
    print("Compose up")

elif sys.argv[1] == "down":
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
    print("Compose Down & Volume all remove")

elif sys.argv[1] == "hive":
    if sys.argv[2] == "build":
        os.system("cd ./hive && docker build -t hive_base:latest .")
        os.system("docker image prune")
        print("HIVE Base Image Build")

    elif sys.argv[2] == "metastore":
        if sys.argv[3] == "up":
            os.system("docker-compose -f docker-compose.yml up -d metastore")
            print("HIVE Metastore Mysql up")
        elif sys.argv[3] == "down":
            os.system("docker-compose -f docker-compose.yml stop metastore")
            os.system("docker-compose -f docker-compose.yml rm metastore")
            print("HIVE Metastore Mysql down")

    elif sys.argv[2] == "beeline":
        if sys.argv[3] == "up":
            os.system("docker-compose -f docker-compose.yml up -d beeline")
            print("HIVE Metastore Mysql up")
        elif sys.argv[3] == "down":
            os.system("docker-compose -f docker-compose.yml stop beeline")
            os.system("docker-compose -f docker-compose.yml rm beeline")
            print("beeline client down")


    elif sys.argv[2] == "up":
        os.system("docker-compose -f docker-compose.yml up -d hs01")
        print("HIVE up")
    elif sys.argv[2] == "down":
        os.system("docker-compose -f docker-compose.yml stop hs01")
        os.system("docker-compose -f docker-compose.yml rm hs01")
        print("HIVE down")




