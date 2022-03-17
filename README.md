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

# docker exec -ti hive-metastore mysql -uroot -p
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
beeline>!connect jdbc:hive2//hs01:10000 root 123456

0: jdbc:hive2://hs01:10000> show tables;
```

---

## 구동 확인
```python
# docker ps -a
# http://127.0.0.1:50070 접속 후, active NN 확인 
# http://127.0.0.1:50080 접속 후, standby NN 확인
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
---

## 참고
https://devfon.tistory.com/43