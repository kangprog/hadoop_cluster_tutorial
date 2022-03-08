# Base Image
#
# Date: 2022.03.02
# Author: Hyunwoo Kang
#

from centos:7

#
# CentOS Default Install
#
RUN yum update -y
RUN yum install  -y \
    initscripts \
    vim \
    openssh-server \
    openssh-clients \
    openssh-askpass \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel.x86_64

ENV HADOOP_VERSION=2.9.2
ENV HADOOP_URL=http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

# Hadoop 2.9.2 버전을 내려받고 /opt/hadoop에 압축 해제
RUN curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz

# 데이터 디렉토리 생성 및 설정 폴더의 심볼릭 링크 생성
RUN ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop \
    && mkdir /opt/hadoop/dfs \
    && ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop \
    && rm -rf /opt/hadoop/share/doc

# 로컬의 core-site.xml 파일을 복제
ADD core-site.xml /etc/hadoop/

# 실행 환경에 필요한 환경 변수 등록
ENV HADOOP_PREFIX /opt/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop
ENV PATH $HADOOP_PREFIX/bin/:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk/