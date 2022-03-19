FROM hadoop_base:latest

#
# Hive 2.0.0 버전을 내려받고 /opt/hive에 압축 해제
#
ENV HIVE_VERSION=2.0.0
ENV HIVE_URL=http://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz

RUN curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && tar -xvf /tmp/hive.tar.gz -C /opt/ \
    && rm /tmp/hive.tar.gz

# 데이터 디렉토리 생성 및 설정 폴더의 심볼릭 링크 생성
RUN ln -s /opt/apache-hive-$HIVE_VERSION-bin /opt/hive

#
# 환경변수 설정
#
ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH

#
# MYSQL 연동을 위한 JDBC 설치
#
ENV CONNECTOR_URL=http://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-5.1.46.tar.gz

RUN curl -fSL "$CONNECTOR_URL" -o /tmp/connector.tar.gz \
    && tar -xvf /tmp/connector.tar.gz -C /opt/ \
    && rm /tmp/connector.tar.gz

RUN cp /opt/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46-bin.jar $HIVE_HOME/lib/ \
    && cp /opt/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46.jar $HIVE_HOME/lib/

#
# TEZ Engine Download
#
ENV TEZ_VERSION=0.9.2
ENV TEZ_URL=http://downloads.apache.org/tez/$TEZ_VERSION/apache-tez-$TEZ_VERSION-bin.tar.gz

RUN curl -fSL "$TEZ_URL" -o /tmp/tez.tar.gz \
    && tar -xvf /tmp/tez.tar.gz -C /opt/ \
    && rm /tmp/tez.tar.gz

RUN ln -s /opt/apache-tez-$TEZ_VERSION-bin /opt/tez


#
# TEZ 환경변수 추가
#
ENV TEZ_HOME /opt/tez
ENV TEZ_CONF_DIR $TEZ_HOME/conf
ENV TEZ_JARS=$TEZ_HOME/*:$TEZ_HOME/lib/*
ENV HADOOP_CLASSPATH $CLASSPATH:$TEZ_CONF_DIR:$TEZ_JARS/*:$TEZ_JARS/lib/*

ADD hive-env.sh $HIVE_HOME/conf/
ADD hive-site.xml $HIVE_HOME/conf/
ADD tez-site.xml $TEZ_HOME/conf

EXPOSE 10000 10002

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
