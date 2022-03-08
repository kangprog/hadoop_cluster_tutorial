## 개요
centOS 7버전을 베이스로 HDFS Cluster 구축

---
## 실행 방법
1. Base Image 빌드
```commandline
# cd ./base
# docker build -t hadoop_base:2.9.2 .
```

2. NameNode Image 빌드
```commandline
# cd ./namenode
# docker build -t hadoop_namenode:2.9.2 .
```

3. DataNode Image 빌드
```commandline
# cd ./datanode
# docker build -t hadoop_datanode:2.9.2 .
```

4. docker-compose 실행
```commandline
# docker-compose -f docker-compose.yml up -d
```

5. Name Node 동작 확인
```commandline
http://127.0.0.0:50070
```

---

## 참고 사이트

[Docker로 하둡 구성하기](https://taaewoo.tistory.com/entry/Docker-Docker%EB%A1%9C-Hadoop-%EA%B5%AC%EC%84%B1%ED%95%98%EA%B8%B0-2-Hadoop-%EC%84%A4%EC%B9%98-%EB%B0%8F-%EC%84%B8%ED%8C%85?category=862614)

[Docker로 하둡 테스트환경 구성하기](https://blog.geunho.dev/posts/hadoop-docker-test-env-hdfs/)

[OpenJDK from Centos Install](https://stackoverflow.com/questions/40636338/how-to-define-openjdk-8-in-centos-based-dockerfile)