import os
import sys

if sys.argv[1] == "build":
    os.system("docker build -t hadoop_base:latest .")
    os.system("docker image prune")
    print("Base Image Build")
elif sys.argv[1] == "up":
    os.system("docker-compose -f docker-compose.yml up -d")
    print("Compose up")
elif sys.argv[1] == "down":
    os.system("docker-compose -f docker-compose.yml down")
    os.system("docker volume rm $(docker volume ls)")
    print("Compose Down & Volume all remove")