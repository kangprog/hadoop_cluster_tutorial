# 참고
# https://truman.tistory.com/209
#

FROM hive_base:2.0.0

# MYSQL 연동을 위한 JDBC 설치
ENV CONNECTOR_URL=http://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-5.1.46.tar.gz

RUN curl -fSL "$CONNECTOR_URL" -o /tmp/connector.tar.gz \
    && tar -xvf /tmp/connector.tar.gz -C /opt/ \
    && rm /tmp/connector.tar.gz

RUN cp /opt/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46-bin.jar $HIVE_HOME/lib/ \
    && cp /opt/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46.jar $HIVE_HOME/lib/

# 설정파일 복사
ADD hive-env.sh $HIVE_HOME/conf/
ADD hive-site.xml $HIVE_HOME/conf/

# mock data 복사
ADD init-table.ddl /tmp/
ADD mock_data /tmp/

# hive용 디렉토리를 volume으로 연결
RUN mkdir /opt/hive/warehouse

# 디렉토리 권한부여
RUN chmod g+w /opt/hive/warehouse

# 실행 스크립트 복제
ADD start.sh /start.sh
RUN chmod a+x /start.sh

EXPOSE 10000
EXPOSE 10002

CMD ["/start.sh"]