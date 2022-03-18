## 실행 방법

#### HDFS Cluster
```python
# python tool.py build
# python tool.py up
# python tool.py down
```

#### HS2, metastore, beeline
- base image build
```python
# python tool.py hive build
```

- metastore Up, Down & Setting
```python
# metastore up & down

# python tool.py hive metastore up
# python tool.py hive metastore down
```
```python
# metastore setting

# docker exec -ti metastore mysql -uroot -p
password: mysql

mysql> create database metastore default character set utf8;
mysql> create user 'hive'@'%' identified by '123456';
mysql> grant all privileges on metastore.* to 'hive'@'%';
mysql> flush privileges;
mysql> exit;
```

- hiveserver Up & Down
```python
# python tool.py hive up
# python tool.py hive down
# docker exec -ti hs01 bash
# passwd
123456
```

- beeline test client Up & Down
```python
# python tool.py hive beeline up
# python tool.py hive beeline down
```
```python
# connect hive server use beeline.

# docker exec -ti beeline bash
# beeline
beeline>!connect jdbc:hive2//hs01:10000 root 123456!connect jdbc:hive2//hs01:10000 root 123456

0: jdbc:hive2://hs01:10000> set hive.execution.engine=tez;
0: jdbc:hive2://hs01:10000> 

```

---

## 구동 확인
```python
# docker ps -a
# http://127.0.0.1:50070 접속 후, active NN 확인 
# http://127.0.0.1:50080 접속 후, standby NN 확인
```

```python
# hive(TEZ)

# docker exec -ti hs01 hive
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

# http://127.0.0.1:8088 들어가서 쿼리 동작, 엔진 확인
```

---

## ISSUE
- zkServer.sh가 실행이 안되는 문제... 3888에 connection refuse 뜬다.
  - 해결방법:
  https://stackoverflow.com/questions/30940981/zookeeper-error-cannot-open-channel-to-x-at-election-address
  - ㅈㄴ 어이없음.. zknode 3개에서 빠르게 동시에 실행시키면 됨.....
  
  ```commandline
  /opt/zookeeper/bin/zkServer.sh start
  /opt/zookeeper/bin/zkServer.sh status
  ```
  
- hive tez engine 설정 후, insert into 시, virtual Memeory 부족으로 인하여 task return 1 에러 발생
  - 해결방법: https://118k.tistory.com/568
  - 우선 hive 실행을 Debug Level로 실행 후 자세한 내용 파악 필요.
  - 경험한 에러는 2.4G를 사용하는데 2.1G 할당되서 발생하는 오류였음. 3G 할당 후 성공 확인
  ```text
  # 에러 상세 내용 중 일부
  Container [pid=352,containerID=container_1647588320530_0001_02_000001] is running beyond virtual memory limits. Current usage: 165.8 MB of 1 GB physical memory used; 2.4 GB of 2.1 GB virtual memory used. Killing container.
  ```
  ```python
  > hive --hiveconf hive.root.logleve=DEBUG,console
  > set tez.am.resource.memory.mb=3072;
  ```
- 위 에러 해결 후, session timeout 에러 발생
  - 해결방법 찾는중...
---

## 참고
https://devfon.tistory.com/43
https://earthconquest.tistory.com/233