FROM hadoop_base:2.9.2

ENV HIVE_VERSION=2.0.0

ENV HIVE_URL=http://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz

# Hive 2.0.0 버전을 내려받고 /opt/hive에 압축 해제
RUN curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && tar -xvf /tmp/hive.tar.gz -C /opt/ \
    && rm /tmp/hive.tar.gz

# 데이터 디렉토리 생성 및 설정 폴더의 심볼릭 링크 생성
RUN ln -s /opt/apache-hive-$HIVE_VERSION-bin /opt/hive

# 환경변수 설정
ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
