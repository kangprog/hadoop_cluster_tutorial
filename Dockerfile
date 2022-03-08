# Base Image
#
# Date: 2022.03.02
# Author: Hyunwoo Kang
#
# Ref URL:
# https://taaewoo.tistory.com/entry/Docker-Docker%EB%A1%9C-Hadoop-%EA%B5%AC%EC%84%B1%ED%95%98%EA%B8%B0-2-Hadoop-%EC%84%A4%EC%B9%98-%EB%B0%8F-%EC%84%B8%ED%8C%85?category=862614
#

from centos:7

#
# CentOS Default Install
#
RUN yum update -y
RUN yum install initscripts -y
RUN yum install wget -y && \
    yum install vim -y && \
    yum install openssh-server openssh-clients openssh-askpass -y && \
    yum install java-1.8.0-openjdk-devel.x86_64 -y

#
# hadoop Install
#
RUN mkdir /hadoop_home
WORKDIR /hadoop_home
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz --no-check-certificate
RUN tar -xvzf hadoop-2.7.7.tar.gz

#
# Copy node config
#
COPY ./config /tmp/config

#
# set public Key
#
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_dsa
RUN cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -t rsa -N ""
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -t ecdsa -N ""
RUN ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -t ed25519 -N ""

#
# set sshd config
#
RUN cp /tmp/config/sshd_config /etc/ssh/sshd_config

EXPOSE 22
