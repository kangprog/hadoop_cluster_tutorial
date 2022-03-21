# 실행 방법

1. 도커 이미지 빌드
```text
> python tool.py hdfs build
> python tool.py hive build
> python tool.py metastore build
```
---
2. HDFS 실행
- 실행
```text
> python tool.py hdfs up
```
- 동작 확인 (Yarn HA 경우 Standby RM은 webUI 접속 안됨)
```text
NN HA: http://127.0.0.1:50070 or 50080
RM HA: http://127.0.0.1:8088 or 8089
```
---
3. Metastore 실행
- 실행
```text
> python tool.py metastore up
```

- replication 설정 (master-slave)

**ref url:** https://jupiny.com/2017/11/07/docker-mysql-replicaiton/

**master 설정**
```text
> docker exec -ti metastore-master mysql -uroot -p
Password: mysql

mysql> CREATE USER 'repluser'@'%' IDENTIFIED BY 'replpw'; 
mysql> GRANT REPLICATION SLAVE ON *.* TO 'repluser'@'%';
mysql> show master status;  
ex.
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000003 |      603 |              |                  |                   |
+------------------+----------+--------------+------------------+-------------------+

이후, 아래 2개의 정보는 slave에서 replication Master 설정 시, 사용해야 함.
File: mysql-bin.000003
Position: 603
```

**slave 설정**
```text
> docker exec -ti metastore-slave mysql -uroot -p
Password: mysql

mysql> CHANGE MASTER TO MASTER_HOST='metastore-master', MASTER_USER='repluser', MASTER_PASSWORD='replpw', MASTER_LOG_FILE='mysql-bin.000003', MASTER_LOG_POS=603;
mysql> start slave;  
mysql> show slave status;
```

- hive metastore 설정
```text
> docker exec -ti metastore-master mysql -uroot -p
Password: mysql

mysql> create database metastore default character set utf8;
mysql> create user 'hive'@'%' identified by '123456';
mysql> grant all privileges on metastore.* to 'hive'@'%';
mysql> flush privileges;
mysql> exit;
```
---
4. Hive 실행
```text
> python tool.py hive up
```

- HiveQL 접속 방법 및 테스트
```text
> docker exec -ti hs01 hive
or
> docker exec -ti hs02 hive

hive> set hive.execution.engine=tez;
hive> create database test;
hive> use test;
hive> create table test.tab1(
    > col1 int,
    > col2 string
    > );
hive> show tables;
hive> insert into table test.tab1
    > select 1 as col1, 'test' as col2;
```
ps. 만약 ` Execution Error, return code 1 from org.apache.hadoop.hive.ql.exec.tez.TezTask` 발생 시, 메모리 자원할당 부족 에러임.
**필요 메모리 량에 맞게 설정**
```
ex.
hive> set tez.am.resource.memory.mb=3072;
```

- beeline을 통한 접속 방법, 확인 방법
```text
> docker exec -ti beeline bash
> beeline -u  "jdbc:hive2://hs01:10000?hive.execution.engine=tez;tez.am.resource.memory.mb=3072"
or
> beeline -u  "jdbc:hive2://hs02:10001?hive.execution.engine=tez;tez.am.resource.memory.mb=3072"

0: jdbc:hive2://hs01:10000> use test;
0: jdbc:hive2://hs01:10000> select count(*) from tab1;

```
