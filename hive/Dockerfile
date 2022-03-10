FROM hive_base:2.0.0

# 설정파일 복사
ADD hive-env.sh $HIVE_HOME/conf/
ADD hive-site.xml $HIVE_HOME/conf/

# hive용 디렉토리를 volume으로 연결
RUN mkdir /opt/hive/warehouse
VOLUME /opt/hive/warehouse

# 디렉토리 권한부여
RUN chmod g+w /opt/hive/warehouse

# 실행 스크립트 복제
ADD start.sh /start.sh
RUN chmod a+x /start.sh

EXPOSE 10000
EXPOSE 10002

CMD ["/start.sh"]