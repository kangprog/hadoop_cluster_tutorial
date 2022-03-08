# 방금 전 로컬에 생성한 base 이미지
FROM hadoop-base:2.9.2

# NameNode Web UI 응답 여부를 통해 Healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -f http://localhost:50070/ || exit 1

# 설정 파일 복제
ADD hdfs-site.xml /etc/hadoop/

# FsImage, EditLog 파일 경로를 volume으로 연결
RUN mkdir /opt/hadoop/dfs/name
VOLUME /opt/hadoop/dfs/name

# 실행 스크립트 복제
ADD start.sh /start.sh
RUN chmod a+x /start.sh

# NameNode의 HTTP, IPC 포트 노출
EXPOSE 50070 9000

# 시작 명령어 등록
CMD ["/start.sh", "/opt/hadoop/dfs/name"]