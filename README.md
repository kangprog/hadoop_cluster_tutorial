## 실행 방법
```python
# python tool.py build
# python tool.py up
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