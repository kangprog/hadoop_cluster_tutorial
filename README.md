## 개요
centOS 7버전을 베이스로 HDFS Cluster 구축

---
## HDFS 구축 실행 방법
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
# docker-compose -f docker-compose.yml up -d namenode
# docker-compose -f docker-compose.yml up -d datanode01
# docker-compose -f docker-compose.yml up -d datanode02
# docker-compose -f docker-compose.yml up -d datanode03
```

5. Name Node 동작 확인
```commandline
http://127.0.0.0:50070
```

---

## HIVE 구축 실행 방법
0. HDFS를 먼저 구축 한 후, 진행 해야한다.
1. base-hive Image 빌드
```commandline
# cd ./base-hive
# docker build -t hive_base:2.0.0 .
```

2. Hive Node Image 빌드
```commandline
# cd ./hive
# docker build -t hadoop_hivenode:2.0.0 .
```

3. Hive-metastore 실행
```commandline
# docker-compose -f docker-compose.yml up -d hive-metastore
```

4. Hive-metastore(mysql) 셋팅
```commandline
# docker exec -ti hive-metastore mysql -uroot -p
password: mysql

mysql> create database metastore default character set utf8;
mysql> create user 'hive'@'%' identified by '123456';
mysql> grant all privileges on metastore.* to 'hive'@'%';
mysql> flush privileges;
mysql> exit;
```

5. Hive Node 실행
```commandline
# docker-compose -f docker-compose.yml up -d hivenode
```

6. Hive 동작 확인
```commandline
# docker exec -ti hivenode bash
# hive
hive>
```

7. Hive 동작 테스트
```commandline
// hivenode container
// /tmp/init-table.ddl 내용 복사 후 hive에서 table 생성

# cat /tmp/init-table.ddl
hive> <init-table.ddl 내용>
```
```commandline
// data overwrite
// /tmp/dept.csv, /tmp/emp.csv, /tmp/salgrade.csv 

hive> load data local inpath '/tmp/dept.csv' overwrite into table dept;
hive> load data local inpath '/tmp/emp.csv' overwrite into table emp;
hive> load data local inpath '/tmp/salgrade.csv' overwrite into table salgrade;

hive> select d.deptno, d.dname, e.ename, e.sal from emp e, dept d where e.deptno=d.deptno;
```
---
## 참고 사이트

[Docker로 하둡 구성하기](https://taaewoo.tistory.com/entry/Docker-Docker%EB%A1%9C-Hadoop-%EA%B5%AC%EC%84%B1%ED%95%98%EA%B8%B0-2-Hadoop-%EC%84%A4%EC%B9%98-%EB%B0%8F-%EC%84%B8%ED%8C%85?category=862614)

[Docker로 하둡 테스트환경 구성하기](https://blog.geunho.dev/posts/hadoop-docker-test-env-hdfs/)

[OpenJDK from Centos Install](https://stackoverflow.com/questions/40636338/how-to-define-openjdk-8-in-centos-based-dockerfile)

[Hive 구축](https://truman.tistory.com/209)

[Hive 구축 및 테스트](https://lsjsj92.tistory.com/438)

[Hive-MYSQL 구축](https://earthconquest.tistory.com/233)